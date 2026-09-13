#!/usr/bin/env python3
"""fn_probe.py -- run OUR compiled candidate function inside the real game.

Mechanism: compile the candidate TU through the real build.py lane, extract
the target function's bytes, resolve its relocations against the BASE
build's symbol map (external refs keep their original VAs; internal branches
are PC-relative), place the body at a scratch VA in emulated RAM, and
redirect every direct-call site (DB `edges`) to it.  A paired run
(baseline vs candidate) over the same checkpoint + input schedule then
proves/refutes behavioral equivalence: identical RAM outside the probe's
own patch sites == the candidate is semantically the retail function over
the exercised scenario.

Prints the --patch spec for run_frames.py (and writes it to a file).

Usage:
  py -3.14 runtime/tools/fn_probe.py --tu recon/syslib/psx/libcd/stcdint.c \
      --fn _st_dma --va 0x800F87C0 --scratch 0x801FA000 \
      --out status/probe-_st_dma.patch
"""
import argparse, importlib.util, json, re, sqlite3, struct, subprocess, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
RUNTIME = ROOT / 'runtime'
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'

def sym_map():
    m = {}
    for ln in (ROOT / 'configs' / 'symbol_addrs.txt').read_text().splitlines():
        mo = re.match(r'^\s*([\w$.]+)\s*=\s*(0x[0-9A-Fa-f]+)\s*;', ln)
        if mo:
            m[mo.group(1)] = int(mo.group(2), 16)
    return m

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--tu', required=True)
    ap.add_argument('--fn', required=True)
    ap.add_argument('--va', required=True, type=lambda s: int(s, 16))
    ap.add_argument('--scratch', required=True, type=lambda s: int(s, 16))
    ap.add_argument('--out', required=True)
    args = ap.parse_args()

    sys.path.insert(0, str(ROOT / 'tools'))
    spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
    bld = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(bld)
    bld.OUT = bld.BUILD
    src = ROOT / args.tu
    obj = bld.compile_c(src, skip_asm=False) if src.suffix == '.c' else bld.compile_cpp(src)

    # ---- object views ----
    symtab = subprocess.run([OBJD, '-t', str(obj)], capture_output=True, text=True).stdout
    relocs = subprocess.run([OBJD, '-r', str(obj)], capture_output=True, text=True).stdout
    secdump = subprocess.run([OBJD, '-s', '-j', '.text', str(obj)],
                             capture_output=True, text=True).stdout
    text = bytearray()
    for ln in secdump.splitlines():
        m = re.match(r'^ ([0-9a-f]{4,8}) ((?:[0-9a-f]{2,8} ?){1,4}) ', ln)
        if m:
            addr = int(m.group(1), 16)
            data = bytes.fromhex(m.group(2).replace(' ', ''))
            if len(text) < addr:
                text.extend(b'\0' * (addr - len(text)))
            text[addr:addr+len(data)] = data

    objsyms = []                                   # (name, section, off)
    fn_off = fn_size = None
    for ln in symtab.splitlines():
        m = re.match(r'^([0-9a-f]{8})\s+.*?\s(\.\w[\w.]*)\s+([0-9a-f]{8})\s+(\S+)$', ln)
        if m:
            off, sec, size, name = int(m.group(1), 16), m.group(2), int(m.group(3), 16), m.group(4)
            objsyms.append((name, sec, off))
            if name == args.fn:
                fn_off, fn_size = off, size
    assert fn_off is not None, f'{args.fn} not in object'
    print(f'{args.fn}: .text+0x{fn_off:X} size 0x{fn_size:X}')

    # ---- all .text relocs (needed for section anchoring below) ----
    rl_all = []
    cur = None
    for ln in relocs.splitlines():
        m = re.match(r'^RELOCATION RECORDS FOR \[(\S+)\]', ln)
        if m:
            cur = m.group(1)
            continue
        m = re.match(r'^([0-9a-f]{8})\s+(R_MIPS_\w+)\s+(\S+)$', ln)
        if m and cur == '.text':
            rl_all.append((int(m.group(1), 16), m.group(2), m.group(3)))

    # ---- resolver: symbol/section -> base-build VA ----
    syms = sym_map()
    sec_base = {'.text': args.va - fn_off}
    for name, sec, off in objsyms:
        if sec not in sec_base and name in syms:
            sec_base[sec] = syms[name] - off

    # Fallback anchor for local-only sections (.data/.bss/...): decode the
    # RETAIL image's hi/lo pair at the same object offsets inside a
    # 100%-matched (DONE) sibling function of this object -- byte identity
    # makes the retail constant authoritative for the section base.
    db = sqlite3.connect(RUNTIME / 'analysis.sqlite')
    payload = (ROOT / 'rom' / 'nfs4-f.exe').read_bytes()[0x800:]
    LOAD = 0x80010000
    def img_word(va):
        return struct.unpack_from('<I', payload, va - LOAD)[0]
    done = [(r[0], r[1]) for r in db.execute(
        "SELECT address, end FROM functions WHERE image='nfs4-f.exe' AND status='DONE' "
        "AND unit LIKE ?", ('%' + src.stem + '%',))]
    def in_done(off):
        va = sec_base['.text'] + off
        return any(a <= va < (e or a) for a, e in done)
    # The gate masks LO16 addend fields, so any single anchor pair can be
    # off by an addend delta -- vote across ALL matched-sibling pairs and
    # take the consensus base (gen_symmap's trick).
    def ahl(hi, lo):
        return ((hi & 0xFFFF) << 16) + struct.unpack(
            '<h', struct.pack('<H', lo & 0xFFFF))[0]
    need = {s for _o, _t, s in rl_all if s.startswith('.')} - set(sec_base)
    from collections import Counter
    for sec in sorted(need):
        votes = Counter()
        for k, (off, typ, name) in enumerate(rl_all):
            if name != sec or typ != 'R_MIPS_HI16' or not in_done(off):
                continue
            j = k + 1
            while j < len(rl_all) and (rl_all[j][1] != 'R_MIPS_LO16'
                                       or rl_all[j][2] != sec):
                j += 1
            if j >= len(rl_all) or not in_done(rl_all[j][0]):
                continue
            off_lo = rl_all[j][0]
            a_obj = ahl(struct.unpack_from('<I', text, off)[0],
                        struct.unpack_from('<I', text, off_lo)[0])
            v_img = ahl(img_word(sec_base['.text'] + off),
                        img_word(sec_base['.text'] + off_lo))
            votes[v_img - a_obj] += 1
        if votes:
            base, n = votes.most_common(1)[0]
            sec_base[sec] = base
            print(f'anchored {sec} = 0x{base:08X} '
                  f'({n}/{sum(votes.values())} votes; histogram '
                  + ', '.join(f'0x{b:08X}x{c}' for b, c in votes.most_common(4)) + ')')
    def resolve(name):
        if name in syms:
            return syms[name]
        m = re.match(r'^(?:D|lbl|func)_([0-9A-Fa-f]{8})$', name)
        if m:                              # VA-named global: the name IS the VA
            return int(m.group(1), 16)
        if name in sec_base:
            return sec_base[name]
        for n, sec, off in objsyms:            # object-local symbol
            if n == name and sec in sec_base:
                return sec_base[sec] + off
        raise SystemExit(f'unresolvable symbol {name} (section bases: {sec_base})')

    # ---- relocated .rodata (switch jump tables) ----
    # A jump table's entries are absolute addresses into the ORIGINAL body;
    # the relocated body must use a relocated copy whose entries point into
    # the scratch body, else execution jumps back into the retail function.
    rodata_scratch = None
    if any(s == '.rodata' for _o, _t, s in rl_all
           if fn_off <= _o < fn_off + fn_size):
        rod = subprocess.run([OBJD, '-s', '-j', '.rodata', str(obj)],
                             capture_output=True, text=True).stdout
        rodata = bytearray()
        for ln in rod.splitlines():
            m = re.match(r'^ ([0-9a-f]{4,8}) ((?:[0-9a-f]{2,8} ?){1,4}) ', ln)
            if m:
                addr = int(m.group(1), 16)
                data = bytes.fromhex(m.group(2).replace(' ', ''))
                if len(rodata) < addr:
                    rodata.extend(b'\0' * (addr - len(rodata)))
                rodata[addr:addr+len(data)] = data
        rod_rel = []
        cur = None
        for ln in relocs.splitlines():
            m = re.match(r'^RELOCATION RECORDS FOR \[(\S+)\]', ln)
            if m:
                cur = m.group(1)
                continue
            m = re.match(r'^([0-9a-f]{8})\s+(R_MIPS_32)\s+(\S+)$', ln)
            if m and cur == '.rodata':
                rod_rel.append((int(m.group(1), 16), m.group(3)))
        rodata_scratch = args.scratch + ((fn_size + 15) & ~15)
        for off, name in rod_rel:
            w = struct.unpack_from('<I', rodata, off)[0]
            if name == '.text':
                if fn_off <= w < fn_off + fn_size:
                    nv = args.scratch + (w - fn_off)
                else:
                    nv = sec_base['.text'] + w
            else:
                nv = None                     # resolved after resolver exists
                rod_rel_late = (off, name, w)
                raise SystemExit(f'non-.text rodata reloc {name} -- extend fn_probe')
            struct.pack_into('<I', rodata, off, nv)
        sec_base['.rodata'] = rodata_scratch
        print(f'.rodata relocated to 0x{rodata_scratch:08X} '
              f'({len(rodata)} bytes, {len(rod_rel)} entries)')

    # ---- relocs inside the fn ----
    body = bytearray(text[fn_off:fn_off + fn_size])
    rl = []
    cur = None
    for ln in relocs.splitlines():
        m = re.match(r'^RELOCATION RECORDS FOR \[(\S+)\]', ln)
        if m:
            cur = m.group(1)
            continue
        m = re.match(r'^([0-9a-f]{8})\s+(R_MIPS_\w+)\s+(\S+)$', ln)
        if m and cur == '.text':
            off = int(m.group(1), 16)
            if fn_off <= off < fn_off + fn_size:
                rl.append((off - fn_off, m.group(2), m.group(3)))

    def rd(o):
        return struct.unpack_from('<I', body, o)[0]
    def wr(o, w):
        struct.pack_into('<I', body, o, w)

    i = 0
    n26 = nhi = 0
    while i < len(rl):
        off, typ, name = rl[i]
        if typ == 'R_MIPS_26':
            w = rd(off)
            if name == '.text':
                t_off = (w & 0x03FFFFFF) << 2
                if fn_off <= t_off < fn_off + fn_size:
                    # internal jump: follow the relocated body, never the
                    # retail original
                    target = args.scratch + (t_off - fn_off)
                else:
                    # cross-fn .text target: the TU's OWN function offsets can
                    # drift vs retail (a FAIL fn earlier in the object shifts
                    # every later one), so resolve through the OWNING function's
                    # retail VA, not a single section base.
                    target = None
                    best = None
                    for n2, sec2, o2 in objsyms:
                        if sec2 == '.text' and o2 <= t_off and \
                           not n2.startswith(('.', 'gcc2', '__gnu')):
                            if best is None or o2 > best[1]:
                                best = (n2, o2)
                    if best and best[0] in syms:
                        target = syms[best[0]] + (t_off - best[1])
                    if target is None:
                        target = sec_base['.text'] + t_off
            else:
                target = resolve(name) + ((w & 0x03FFFFFF) << 2)
            assert (target >> 28) == (args.scratch >> 28)
            wr(off, (w & 0xFC000000) | ((target >> 2) & 0x03FFFFFF))
            n26 += 1
            i += 1
        elif typ == 'R_MIPS_HI16':
            j = i + 1                        # partner LO16 (jal may interleave)
            while rl[j][1] != 'R_MIPS_LO16' or rl[j][2] != name:
                j += 1
            off_lo = rl[j][0]
            whi, wlo = rd(off), rd(off_lo)
            ahl = ((whi & 0xFFFF) << 16) + struct.unpack('<h', struct.pack('<H', wlo & 0xFFFF))[0]
            v = resolve(name) + ahl
            lo = v & 0xFFFF
            hi = (v - struct.unpack('<h', struct.pack('<H', lo))[0]) >> 16
            wr(off, (whi & 0xFFFF0000) | (hi & 0xFFFF))
            wr(off_lo, (wlo & 0xFFFF0000) | lo)
            nhi += 1
            rl.pop(j)
            i += 1
        elif typ == 'R_MIPS_LO16':           # orphan LO16 (repeated lo) -- same math, hi=partner above
            wlo = rd(off)
            v = resolve(name) + struct.unpack('<h', struct.pack('<H', wlo & 0xFFFF))[0]
            wr(off, (wlo & 0xFFFF0000) | (v & 0xFFFF))
            i += 1
        elif typ == 'R_MIPS_GPREL16':
            raise SystemExit('GPREL16 in body -- add gp handling before probing this fn')
        else:
            raise SystemExit(f'unhandled reloc {typ}')
    print(f'relocs applied: {n26} x26, {nhi} hi/lo pairs; section bases: ' +
          ', '.join(f'{k}=0x{v:08X}' for k, v in sec_base.items()))

    # ---- call sites from the DB ----
    db = sqlite3.connect(RUNTIME / 'analysis.sqlite')
    sites = [r[0] for r in db.execute(
        "SELECT at FROM edges WHERE image='nfs4-f.exe' AND target=?", (args.va,))]
    assert sites, 'no direct call sites found in DB'
    ptr_refs = [r for r in db.execute(
        "SELECT printf('0x%08X',address), text FROM instructions WHERE image='nfs4-f.exe' "
        "AND text LIKE ? AND text NOT LIKE ?",
        (f'%&{args.fn}%', f'%&{args.fn}()%'))]
    if ptr_refs:
        print('⚠️ ADDRESS-TAKEN references (redirect incomplete!):')
        for a, t in ptr_refs:
            print('   ', a, t)

    jal_new = 0x0C000000 | ((args.scratch >> 2) & 0x03FFFFFF)
    blob = bytearray(body)
    if rodata_scratch is not None:
        blob.extend(b'\0' * (rodata_scratch - args.scratch - len(blob)))
        blob.extend(rodata)
    patches = [f'{args.scratch:x}={bytes(blob).hex()}']
    for at in sites:
        patches.append(f'{at:x}={struct.pack("<I", jal_new).hex()}')
    spec_str = ','.join(patches)
    out = RUNTIME / args.out
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps({
        'fn': args.fn, 'va': f'0x{args.va:08X}', 'scratch': f'0x{args.scratch:08X}',
        'size': fn_size, 'call_sites': [f'0x{s:08X}' for s in sites],
        'exclude_ranges': [[f'0x{args.scratch:08X}', len(blob)]] +
                          [[f'0x{s:08X}', 4] for s in sites],
        'patch': spec_str}, indent=1))
    print(f'{len(sites)} call sites redirected -> 0x{args.scratch:08X}')
    print(f'patch spec -> {out}')

if __name__ == '__main__':
    main()
