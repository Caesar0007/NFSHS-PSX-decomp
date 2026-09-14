#!/usr/bin/env python3
"""gen_rodata_extra.py -- W67-A7 supplementary recon .rodata/.data/.sdata placement.

The W66-A4 ownmap (linkers/nfs4_recon.rodata_placement.json) + the P907 .data
implied-base spine place recon TUs' initialized data whose cells carry a
name-encoded / MAP symbol.  TUs whose data is entirely ANONYMOUS local statics
(no such name) fall through to the .rodata_rest / main-.data catch-alls -- and
every `%hi/%lo` / `%gp_rel` reference to that section in the TU's OWN .text then
resolves to the catch-all address instead of the retail one.  That is the bulk
of the full_link .text / front.text diff class (StCdInterrupt's 42 .data
relocs, SYS/track/texture .rodata jump tables, ...).

For each such (object, section) this derives the retail base the same
non-circular way tools/floor_image.py derives un-named section bases: decode
retail's resolved reference (%hi/%lo pair, or %gp_rel single for .sdata) at the
same in-.text offset and subtract OUR addend (base = retail_target - our_addend;
our addend still tests our code).  It then RESOLVES the section's own pointer
relocations (R_MIPS_32 -> MAP / name-encoded / .L<hex> / section-relative) and
BYTE-COMPARES the resolved bytes to the retail image at that base.  Only a
window whose every resolvable word matches retail is emitted -- so placing it
(overlapping the identical residual blob, benign exactly like the P907 .data
implied-base overlap) is provably byte-neutral for the region and only fixes
the reference target.  Outputs:
  linkers/nfs4_recon.rodata_extra.json  -- .rodata windows (merged into .roNNNN)
  linkers/nfs4_recon.data_extra.json    -- .data/.sdata retail bases (placed_data
                                           /placed_sdata override in gen_ld)
"""
import json, re, struct, subprocess
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
MAP = Path(r'C:/Temp/_from_github/NFS4.MAP')
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
IMG = (ROOT / 'rom' / 'nfs4-f.exe').read_bytes()
FOFF = 0x800
LOAD = 0x80010000
GP = 0x8013C54C
OUT_RO = ROOT / 'linkers' / 'nfs4_recon.rodata_extra.json'
OUT_DATA = ROOT / 'linkers' / 'nfs4_recon.data_extra.json'
PLACEMENT = ROOT / 'linkers' / 'nfs4_recon.rodata_placement.json'

# retail section spans a decoded base is allowed to land in, per section kind
SPANS = {
    '.rodata': [(0x80010000, 0x800128F0), (0x80054548, 0x8005797C)],
    '.data':   [(0x80051260, 0x80052B38), (0x8010CCD4, 0x8013C54C)],
    '.sdata':  [(0x8013C54C, 0x8013DD7C)],
}

# ---- symbol map (MAP globals + configs data + name-encoded + .L<hex>) --------
sym = {}
for ln in MAP.read_text(errors='replace').splitlines():
    m = re.match(r'^ ([0-9A-F]{8}) (\S+)\s*$', ln)
    if m:
        sym.setdefault(m.group(2), int(m.group(1), 16))
sa = ROOT / 'configs' / 'symbol_addrs.txt'
if sa.exists():
    for ln in sa.read_text().splitlines():
        m = re.match(r'^\s*([\w$.]+)\s*=\s*(0x[0-9A-Fa-f]+)\s*;', ln)
        if m:
            sym.setdefault(m.group(1), int(m.group(2), 16))
NAMEVA = re.compile(r'^(?:func|D|DAT|lbl)_([0-9A-Fa-f]{8})$')
DOTL = re.compile(r'^\.L?_?([0-9A-Fa-f]{8})$')

def aof(name):
    if name in sym:
        return sym[name]
    m = NAMEVA.match(name) or DOTL.match(name)
    return int(m.group(1), 16) if m else None

def run(*a):
    return subprocess.run(a, capture_output=True, text=True).stdout

def imgw(va):
    o = va - LOAD + FOFF
    return int.from_bytes(IMG[o:o+4], 'little') if 0 <= o <= len(IMG)-4 else None

def s16(x):
    return struct.unpack('<h', struct.pack('<H', x & 0xFFFF))[0]

def secbytes(obj, sec):
    buf = bytearray()
    for ln in run(OBJD, '-s', '-j', sec, str(obj)).splitlines():
        m = re.match(r'^ ([0-9a-f]{4,8}) ((?:[0-9a-f]{2,8} ?){1,4})', ln)
        if m:
            a = int(m.group(1), 16); dd = bytes.fromhex(m.group(2).replace(' ', ''))
            if len(buf) < a:
                buf.extend(b'\0' * (a - len(buf)))
            buf[a:a+len(dd)] = dd
    return bytes(buf)

def relocs(obj, want):
    out = []; cur = None
    for ln in run(OBJD, '-r', str(obj)).splitlines():
        m = re.match(r'^RELOCATION RECORDS FOR \[(\S+)\]', ln)
        if m:
            cur = m.group(1); continue
        m = re.match(r'^([0-9a-f]{8})\s+(R_MIPS_\S+)\s+(\S+)$', ln)
        if m and cur == want:
            out.append((int(m.group(1), 16), m.group(2), m.group(3)))
    return out

def text_fns(obj):
    out = []
    for ln in run(OBJD, '-t', str(obj)).splitlines():
        m = re.match(r'^([0-9a-f]{8})\s+.*F \.text\s+[0-9a-f]{8}\s+(\S+)$', ln)
        if m:
            va = aof(m.group(2))
            if va is not None:
                out.append((int(m.group(1), 16), va))
    return out

def text_base(obj):
    votes = Counter(va - off for off, va in text_fns(obj))
    return votes.most_common(1)[0][0] if votes else None

def decode_base(obj, tbase, sec):
    """retail base for section `sec` by CONSENSUS over the object's .text
    references to it (HI16/LO16 pairs, and %gp_rel singles for small data);
    each votes retail_target - our_addend.  Certificate/vendor-vintage noise is
    outvoted.  Search fallback for reloc-free const runs."""
    if tbase is None:
        return None
    tb = secbytes(obj, '.text')
    rl = relocs(obj, '.text')
    votes = Counter()
    inspan = lambda a: any(lo <= a < hi for lo, hi in SPANS[sec])
    for i, (ro, ty, tg) in enumerate(rl):
        if tg != sec:
            continue
        if ty == 'R_MIPS_HI16':
            j = i + 1
            while j < len(rl) and not (rl[j][1] == 'R_MIPS_LO16' and rl[j][2] == sec):
                j += 1
            if j >= len(rl) or ro + 4 > len(tb) or rl[j][0] + 4 > len(tb):
                continue
            lo = rl[j][0]
            oadd = ((struct.unpack_from('<I', tb, ro)[0] & 0xFFFF) << 16) + \
                s16(struct.unpack_from('<I', tb, lo)[0])
            rhi = imgw(tbase + ro); rlo = imgw(tbase + lo)
            if rhi is None or rlo is None:
                continue
            cand = (((rhi & 0xFFFF) << 16) + s16(rlo)) - oadd
            if inspan(cand):
                votes[cand] += 1
        elif ty == 'R_MIPS_GPREL16':
            if ro + 4 > len(tb):
                continue
            oadd = s16(struct.unpack_from('<I', tb, ro)[0])
            rw = imgw(tbase + ro)
            if rw is None:
                continue
            cand = GP + s16(rw) - oadd
            if inspan(cand):
                votes[cand] += 1
    if votes:
        return votes.most_common(1)[0][0]
    if not relocs(obj, sec):
        raw = secbytes(obj, sec)
        if len(raw) >= 8:
            for lo, hi in SPANS[sec]:
                blob = IMG[lo - LOAD + FOFF: hi - LOAD + FOFF]
                idx = blob.find(raw)
                if idx >= 0 and blob.find(raw, idx + 1) < 0:
                    return lo + idx
    return None

def section_bases(obj, tbase, known):
    """retail bases for the object's other sections (to resolve pointer words),
    from named symbols; `known` seeds already-decoded bases."""
    out = dict(known)
    out.setdefault('.text', tbase)
    persec = {}
    for ln in run(OBJD, '-t', str(obj)).splitlines():
        m = re.match(r'^([0-9a-f]{8})\s+.*?\s(\.(?:data|sdata|rodata))\s+[0-9a-f]{8}\s+(\S+)$', ln)
        if m:
            va = aof(m.group(3))
            if va is not None:
                persec.setdefault(m.group(2), Counter())[va - int(m.group(1), 16)] += 1
    for sec, votes in persec.items():
        out.setdefault(sec, votes.most_common(1)[0][0])
    return out

def resolve_and_check(obj, sec, base, sbases):
    """resolve the section's R_MIPS_32 pointer words, byte-compare to retail at
    base; returns (checked_words, diff_words, unresolved_count, nbytes)."""
    rb = bytearray(secbytes(obj, sec))
    unresolved = set()
    for ro, ty, tg in relocs(obj, sec):
        if ro + 4 > len(rb):
            continue
        w = struct.unpack_from('<I', rb, ro)[0]
        if ty != 'R_MIPS_32':
            unresolved.add(ro); continue
        ta = aof(tg)
        if ta is None and tg in sbases and sbases[tg] is not None:
            ta = sbases[tg]
        if ta is None:
            unresolved.add(ro); continue
        struct.pack_into('<I', rb, ro, (ta + w) & 0xFFFFFFFF)
    checked = diff = 0
    for w in range(0, (len(rb) // 4) * 4, 4):
        if w in unresolved:
            continue
        ov = struct.unpack_from('<I', rb, w)[0]
        rv = imgw(base + w)
        checked += 1
        if rv != ov:
            diff += 1
    return checked, diff, len(unresolved), len(rb)

def main():
    placed_ro = {r['obj'] for r in json.load(open(PLACEMENT))}
    srcs = [*Path(ROOT / 'recon').rglob('*.cpp'), *Path(ROOT / 'recon').rglob('*.c')]
    objs = []
    for s in srcs:
        o = ROOT / 'build' / (str(s.relative_to(ROOT)) + '.o')
        if o.is_file():
            objs.append((o.relative_to(ROOT).as_posix(), o))
    ro_out, data_out = [], []
    skipped = []
    for rel, o in sorted(objs):
        tbase = text_base(o)
        known = {}
        for sec in ('.rodata', '.data', '.sdata'):
            if sec == '.rodata' and rel in placed_ro:
                continue                          # already in the ownmap
            nb = len(secbytes(o, sec))
            if not nb:
                continue
            base = decode_base(o, tbase, sec)
            if base is None:
                skipped.append((rel, sec, 'no anchor / no unique search')); continue
            span = next((s for s in SPANS[sec] if s[0] <= base < s[1]), None)
            if span is None or base + nb > span[1]:
                skipped.append((rel, sec, f'{base:#x}..{base+nb:#x} outside span')); continue
            known[sec] = base
            sbases = section_bases(o, tbase, known)
            checked, diff, unres, _ = resolve_and_check(o, sec, base, sbases)
            if checked == 0:
                skipped.append((rel, sec, 'no resolvable words')); continue
            if diff:
                skipped.append((rel, sec, f'{diff}/{checked}w differ @ {base:#x}')); continue
            row = {'obj': rel, 'section': sec, 'base': base, 'end': base + nb,
                   'size': nb, 'ok': True, 'unresolved': unres, 'words': checked}
            (ro_out if sec == '.rodata' else data_out).append(row)
    ro_out.sort(key=lambda r: r['base'])
    for a, b in zip(ro_out, ro_out[1:]):
        assert a['end'] <= b['base'], f"rodata extra overlap: {a['obj']} vs {b['obj']}"
    # data/sdata: two extras must not claim the same retail bytes (residual-blob
    # overlap is benign; extra-vs-extra overlap is a wrong base -- drop both).
    ds = sorted(data_out, key=lambda r: r['base'])
    drop = set()
    for a, b in zip(ds, ds[1:]):
        if b['base'] < a['end']:
            drop.add(a['obj'] + a['section']); drop.add(b['obj'] + b['section'])
            skipped.append((a['obj'], a['section'], f"overlaps {b['obj']}{b['section']}"))
    data_out = [r for r in data_out if r['obj'] + r['section'] not in drop]
    OUT_RO.write_text(json.dumps(ro_out, indent=1) + '\n')
    OUT_DATA.write_text(json.dumps(data_out, indent=1) + '\n')
    print(f'{len(ro_out)} .rodata windows -> {OUT_RO.name}')
    for r in ro_out:
        print(f"  {r['base']:#010x}..{r['end']:#010x}  {r['size']:5d}B  {r['words']}w  "
              f"({r['unresolved']} unres)  {r['obj']}")
    print(f'{len(data_out)} .data/.sdata bases -> {OUT_DATA.name}')
    for r in data_out:
        print(f"  {r['base']:#010x}  {r['section']:6s} {r['size']:5d}B  {r['words']}w  {r['obj']}")
    print(f'--- skipped {len(skipped)} ---')
    for rel, sec, why in skipped:
        print(f'  {rel} {sec}: {why}')

if __name__ == '__main__':
    main()
