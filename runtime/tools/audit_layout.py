#!/usr/bin/env python3
"""audit_layout.py -- find gate-invisible static-layout divergence per TU.

The verify gate masks LO16/HI16 reloc fields, so a TU whose file-static
.data/.bss/.sdata layout differs from retail (order, missing members,
initialized-vs-bss classification) still gates PASS -- but reads/writes the
WRONG slots at runtime (the stcdint.c wedge, fixed 2026-09-13).

Detector: for every HI16/LO16 pair to a local section inside a
100%-MATCHED (DONE) function, decode the RETAIL image's pair at the same
offsets; per-section consensus base is voted, and every site deviating
from consensus is reported with the object static it targets vs the retail
VA it should hit.  A clean TU votes unanimously.

Usage:
  py -3.14 runtime/tools/audit_layout.py recon/syslib/psx/libmcrd/LIBMCRD.c
  py -3.14 runtime/tools/audit_layout.py --sweep 'recon/syslib/**/*.c' [--quiet]
"""
import argparse, glob, importlib.util, re, sqlite3, struct, subprocess, sys
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
RUNTIME = ROOT / 'runtime'
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
LOAD = 0x80010000
SECS = ('.data', '.bss', '.sdata', '.sbss', '.rodata')

_img = (ROOT / 'rom' / 'nfs4-f.exe').read_bytes()[0x800:]
def img_word(va):
    off = va - LOAD
    if 0 <= off + 4 <= len(_img):
        return struct.unpack_from('<I', _img, off)[0]
    return None

def ahl(hi, lo):
    return ((hi & 0xFFFF) << 16) + struct.unpack('<h', struct.pack('<H', lo & 0xFFFF))[0]

_bld = None
def bld():
    global _bld
    if _bld is None:
        sys.path.insert(0, str(ROOT / 'tools'))
        spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
        _bld = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(_bld)
        _bld.OUT = _bld.BUILD
    return _bld

def audit(tu, db, quiet=False):
    src = ROOT / tu
    try:
        obj = (bld().compile_c(src, skip_asm=False) if src.suffix == '.c'
               else bld().compile_cpp(src))
    except Exception as e:
        return f'{tu}: COMPILE-ERROR {e}'
    symtab = subprocess.run([OBJD, '-t', str(obj)], capture_output=True, text=True).stdout
    relocs = subprocess.run([OBJD, '-r', str(obj)], capture_output=True, text=True).stdout
    sec = subprocess.run([OBJD, '-s', '-j', '.text', str(obj)],
                         capture_output=True, text=True).stdout
    text = bytearray()
    for ln in sec.splitlines():
        m = re.match(r'^ ([0-9a-f]{4,8}) ((?:[0-9a-f]{2,8} ?){1,4}) ', ln)
        if m:
            a = int(m.group(1), 16)
            d = bytes.fromhex(m.group(2).replace(' ', ''))
            if len(text) < a:
                text.extend(b'\0' * (a - len(text)))
            text[a:a+len(d)] = d

    objsyms = []                       # (name, sec, off)
    fns = []                           # (off, size, name) text fns
    for ln in symtab.splitlines():
        m = re.match(r'^([0-9a-f]{8})\s+.*?\s(\.\w[\w.]*|\*\w+\*)\s+([0-9a-f]{8})\s+(\S+)$', ln)
        if m and m.group(2) not in ('*UND*', '*ABS*'):
            off, s, size, name = (int(m.group(1), 16), m.group(2),
                                  int(m.group(3), 16), m.group(4))
            objsyms.append((name, s, off))
            if s == '.text' and size:
                fns.append((off, size, name))

    # text base: anchor via a DONE fn of this unit in the DB
    unit_pat = '%' + src.stem + '%'
    done = {}
    for name, va, end in db.execute(
            "SELECT name, address, end FROM functions WHERE image='nfs4-f.exe' "
            "AND status='DONE' AND unit LIKE ?", (unit_pat,)):
        done[name] = (va, end)
    text_base = None
    for off, size, name in fns:
        if name in done:
            text_base = done[name][0] - off
            break
    if text_base is None:
        return f'{tu}: no DONE fn anchor -- skipped'
    done_ranges = [(v, e or v + 4) for v, e in done.values()]
    def in_done(off):
        va = text_base + off
        return any(a <= va < e for a, e in done_ranges)
    def fn_of(off):
        for o, s, n in fns:
            if o <= off < o + s:
                return f'{n}+0x{off-o:X}'
        return hex(off)
    def static_of(s, a):
        best = None
        for name, ss, off in objsyms:
            if ss == s and off <= a and not name.startswith('.'):
                if best is None or off > best[1]:
                    best = (name, off)
        return f'{best[0]}+{a-best[1]:#x}' if best else f'{s}+{a:#x}'

    rl = []
    cur = None
    for ln in relocs.splitlines():
        m = re.match(r'^RELOCATION RECORDS FOR \[(\S+)\]', ln)
        if m:
            cur = m.group(1)
            continue
        m = re.match(r'^([0-9a-f]{8})\s+(R_MIPS_\w+)\s+(\S+)$', ln)
        if m and cur == '.text':
            rl.append((int(m.group(1), 16), m.group(2), m.group(3)))

    if getattr(audit, 'map_mode', False):
        lines = [f'{tu}: static map']
        for name, s, off in sorted(objsyms, key=lambda x: (x[1], x[2])):
            if s in ('.data', '.bss', '.sdata', '.sbss') and not name.startswith('.') \
               and name not in ('gcc2_compiled.', '__gnu_compiled_c'):
                lines.append(f'  {s:6} +0x{off:04X} {name}')
        from collections import defaultdict
        ev = defaultdict(Counter)
        for s in SECS:
            for k, (off, typ, name) in enumerate(rl):
                if name != s or typ != 'R_MIPS_HI16' or not in_done(off):
                    continue
                j = k + 1
                while j < len(rl) and (rl[j][1] != 'R_MIPS_LO16' or rl[j][2] != s):
                    j += 1
                if j >= len(rl) or not in_done(rl[j][0]):
                    continue
                iw_hi, iw_lo = (img_word(text_base + off),
                                img_word(text_base + rl[j][0]))
                if iw_hi is None:
                    continue
                a_obj = ahl(struct.unpack_from('<I', text, off)[0],
                            struct.unpack_from('<I', text, rl[j][0])[0])
                ev[(s, static_of(s, a_obj))][ahl(iw_hi, iw_lo)] += 1
        lines.append('retail VA evidence (majority | all votes):')
        for (s, st), votes in sorted(ev.items()):
            va, n = votes.most_common(1)[0]
            extra = '' if len(votes) == 1 else '  ⚠️ ' + \
                ', '.join(f'0x{v:08X}x{c}' for v, c in votes.most_common(4))
            lines.append(f'  {s:6} {st:28} -> 0x{va:08X} ({n} sites){extra}')
        return '\n'.join(lines)

    lines = []
    verdict = 'CLEAN'
    for s in SECS:
        sites = []                      # (off_hi, our_addend, retail_va)
        for k, (off, typ, name) in enumerate(rl):
            if name != s or typ != 'R_MIPS_HI16' or not in_done(off):
                continue
            j = k + 1
            while j < len(rl) and (rl[j][1] != 'R_MIPS_LO16' or rl[j][2] != s):
                j += 1
            if j >= len(rl) or not in_done(rl[j][0]):
                continue
            off_lo = rl[j][0]
            iw_hi, iw_lo = img_word(text_base + off), img_word(text_base + off_lo)
            if iw_hi is None or iw_lo is None:
                continue
            a_obj = ahl(struct.unpack_from('<I', text, off)[0],
                        struct.unpack_from('<I', text, off_lo)[0])
            sites.append((off, a_obj, ahl(iw_hi, iw_lo)))
        if len(sites) < 2:
            continue
        votes = Counter(v - a for _o, a, v in sites)
        base, n = votes.most_common(1)[0]
        bad = [(o, a, v) for o, a, v in sites if v - a != base]
        # hi/lo mis-pairing artifacts: the site sits in a byte-MATCHED fn, so a
        # delta beyond any plausible layout shift is a decode artifact, not a
        # divergence (e.g. the pair partner picked across an unrelated LO16).
        art = [b for b in bad if abs(b[2] - (base + b[1])) > 0x10000]
        bad = [b for b in bad if abs(b[2] - (base + b[1])) <= 0x10000]
        if art and not quiet:
            lines.append(f'  {s}: {len(art)} pairing-artifact site(s) suppressed')
        if bad:
            verdict = 'LAYOUT-MISMATCH'
            lines.append(f'  {s}: consensus 0x{base:08X} ({n}/{len(sites)}), '
                         f'{len(bad)} deviating sites:')
            for o, a, v in bad[:12]:
                lines.append(f'    {fn_of(o):34} ours {static_of(s, a):26} '
                             f'-> 0x{base+a:08X}  retail 0x{v:08X} '
                             f'(delta {v-(base+a):+#x})')
        else:
            lines.append(f'  {s}: 0x{base:08X} unanimous ({n} sites)')
    hdr = f'{tu}: {verdict}'
    if quiet and verdict == 'CLEAN':
        return hdr
    return '\n'.join([hdr] + lines)

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('tu', nargs='?')
    ap.add_argument('--sweep')
    ap.add_argument('--quiet', action='store_true')
    ap.add_argument('--map', action='store_true',
                    help='print static map + per-static retail evidence')
    args = ap.parse_args()
    audit.map_mode = args.map
    db = sqlite3.connect(RUNTIME / 'analysis.sqlite')
    if args.sweep:
        tus = sorted(str(Path(p).relative_to(ROOT)).replace('\\', '/')
                     for p in glob.glob(str(ROOT / args.sweep), recursive=True))
        for tu in tus:
            print(audit(tu, db, quiet=args.quiet), flush=True)
    else:
        print(audit(args.tu, db))

if __name__ == '__main__':
    main()
