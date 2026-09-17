#!/usr/bin/env python3
"""wincmp.py VA LEN -- retail vs honest words in a window, with ASCII and mismatch marks."""
import sys, struct
sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/psyq_pipe')
from images import rom, honest_image, LOAD
lo, n = int(sys.argv[1], 16), int(sys.argv[2], 16)
R = rom(); H, _ = honest_image(0x140000)
def asc(b): return ''.join(chr(c) if 32 <= c < 127 else '.' for c in b)
bad = 0
for a in range(lo, lo + n, 16):
    rw = R[a-LOAD:a-LOAD+16]; hw = H[a-LOAD:a-LOAD+16]
    m = ''.join('*' if rw[i:i+4] != hw[i:i+4] else ' ' for i in range(0, 16, 4)); bad += m.count('*')
    print(f'{a:08x} rom {rw.hex()} {asc(rw)} | ours {hw.hex()} {asc(hw)} {m}')
print('mismatching words', bad)
