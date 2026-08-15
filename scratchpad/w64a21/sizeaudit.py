#!/usr/bin/env python3
"""w64a21 sizeaudit.py -- tree-wide st_size mismatch audit (the PATCHGTE/stup0 class).

objdiff sizes every function row from the ELF symbol's st_size.  verify_asm diffs
by ADDRESS and walks the oracle's own span, so a symbol whose st_size is TRUNCATED
in our object (an interior label became the next-symbol boundary in
tools/fix_symsizes.py) gates PASS while the board reads only part of the symbol.
This compares st_size for every same-named global .text symbol in
expected/src/**.o vs build/recon/**.o.
"""
import json
import struct
import sys
from pathlib import Path

ROOT = Path(r'C:\Temp\nfs4-decomp')


def text_syms(path):
    """{name: (value, size, is_global)} for symbols in executable sections."""
    try:
        d = path.read_bytes()
    except OSError:
        return None
    if d[:4] != b'\x7fELF':
        return None
    e_shoff, = struct.unpack_from('<I', d, 0x20)
    e_shentsize, e_shnum = struct.unpack_from('<HH', d, 0x2E)
    secs = []
    for i in range(e_shnum):
        off = e_shoff + i * e_shentsize
        name, typ, flags, addr, offset, size, link = struct.unpack_from('<7I', d, off)
        secs.append({'type': typ, 'flags': flags, 'size': size,
                     'off': offset, 'link': link})
    symtab = next((s for s in secs if s['type'] == 2), None)
    if not symtab:
        return None
    strtab = secs[symtab['link']]
    out = {}
    for i in range(symtab['size'] // 16):
        o = symtab['off'] + i * 16
        st_name, st_value, st_size, st_info, st_other, st_shndx = \
            struct.unpack_from('<IIIBBH', d, o)
        if st_shndx >= len(secs) or not (secs[st_shndx]['flags'] & 0x4):
            continue                                   # not SHF_EXECINSTR
        base = strtab['off'] + st_name
        nm = d[base:d.index(b'\x00', base)].decode('utf-8', 'replace')
        if not nm or nm.startswith('.L'):
            continue
        out.setdefault(nm, (st_value, st_size, (st_info >> 4) != 0))
    return out


def main():
    cfg = json.load(open(ROOT / 'objdiff.json', encoding='utf-8'))
    bad = []
    for u in cfg['units']:
        tgt = ROOT / u['target_path']
        base = ROOT / u['base_path']
        ts, bs = text_syms(tgt), text_syms(base)
        if ts is None or bs is None:
            continue
        for nm, (tv, tsz, tg) in ts.items():
            if not tg or tsz == 0:
                continue
            if nm not in bs:
                continue
            bv, bsz, bg = bs[nm]
            if bsz != tsz:
                bad.append((u['name'].replace('\\', '/'), nm, tsz, bsz))
    bad.sort(key=lambda r: (r[3] / r[2] if r[2] else 1, r[0]))
    print(f"{len(bad)} global .text symbols with a size mismatch "
          f"(expected vs ours)")
    for unit, nm, tsz, bsz in bad:
        print(f"  {100.0*bsz/tsz:6.1f}%  oracle {tsz:5}  ours {bsz:5}  "
              f"{unit:<34} {nm}")


if __name__ == '__main__':
    main()
