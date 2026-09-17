#!/usr/bin/env python3
"""objwin.py OBJSTEM SECTION [...] -- look each object's input section up in the honest map and
print retail-vs-ours mismatching lines (wincmp style)."""
import sys, re, struct
sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/psyq_pipe')
from images import rom, honest_image, LOAD, ROOT
R = rom(); H, _ = honest_image(0x140000)
mp = (ROOT / 'build/gen_ld/recon_multdef-ok.map').read_text(errors='replace')
def asc(b): return ''.join(chr(c) if 32 <= c < 127 else '.' for c in b)
args = sys.argv[1:]
for stem, sec in zip(args[::2], args[1::2]):
    m = re.search(r'^ (\.\S+)\s+(0x[0-9a-f]+)\s+(0x[0-9a-f]+) (\S*%s\S*)$' % re.escape(stem), mp, re.M)
    hits = [x for x in re.finditer(r'^ (\S+)\s+(0x[0-9a-f]+)\s+(0x[0-9a-f]+) (\S+)$', mp, re.M) if stem in x.group(4) and x.group(1) == sec]
    for x in hits:
        lo, n = int(x.group(2), 16), int(x.group(3), 16)
        print(f'== {x.group(4)} {sec} {lo:#x} +{n:#x}')
        bad = 0
        for a in range(lo, lo + n, 16):
            rw = R[a-LOAD:a-LOAD+16]; hw = H[a-LOAD:a-LOAD+16]
            mk = ''.join('*' if rw[i:i+4] != hw[i:i+4] else ' ' for i in range(0, 16, 4)); bad += mk.count('*')
            if '*' in mk: print(f'  {a:08x} rom {rw.hex()} {asc(rw)} | ours {hw.hex()} {asc(hw)} {mk}')
        print('  mismatching words', bad)
