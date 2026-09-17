#!/usr/bin/env python3
"""textdiff.py OBJSTEM -- mismatching .text words of one object (honest vs ROM) with a crude decode
of lui/addiu/lw/sw immediates so the referenced address can be reconstructed."""
import sys, re, struct
sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/psyq_pipe')
from images import rom, honest_image, LOAD, ROOT
R = rom(); H, _ = honest_image(0x140000)
mp = (ROOT / 'build/gen_ld/recon_multdef-ok.map').read_text(errors='replace')
NM = {0x0f: 'lui', 0x09: 'addiu', 0x23: 'lw', 0x2b: 'sw', 0x21: 'lh', 0x25: 'lhu', 0x29: 'sh', 0x20: 'lb', 0x24: 'lbu', 0x28: 'sb', 0x03: 'jal', 0x02: 'j'}
def dec(w):
    op = w >> 26
    if op in (2, 3): return f'{NM[op]} {(w & 0x3ffffff) << 2 | 0x80000000:#x}'
    if op in NM:
        imm = w & 0xffff; simm = imm - 0x10000 if imm & 0x8000 else imm
        return f'{NM[op]} r{(w>>16)&31},{simm:#x}({(w>>21)&31})' if op != 0x0f else f'lui r{(w>>16)&31},{imm:#x}'
    return f'op{op:#x}'
for stem in sys.argv[1:]:
    for x in re.finditer(r'^ \.text\s+(0x[0-9a-f]+)\s+(0x[0-9a-f]+) (\S*%s\S*)$' % re.escape(stem), mp, re.M):
        lo, n = int(x.group(1), 16), int(x.group(2), 16)
        print(f'== {x.group(3)} .text {lo:#x} +{n:#x}')
        for a in range(lo, lo + n, 4):
            r, h = struct.unpack_from('<I', R, a - LOAD)[0], struct.unpack_from('<I', H, a - LOAD)[0]
            if r != h: print(f'  {a:08x} rom {r:08x} {dec(r):28s} ours {h:08x} {dec(h)}')
