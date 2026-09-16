#!/usr/bin/env python3
"""branchscan.py -- honest image vs ROM: per retail function, mismatching .text words classified
as BRANCH (opcode beq/bne/blez/bgtz/regimm/j/jal) vs OTHER; lists functions whose ONLY mismatches
are branch words (= branch-direction defects the target-masking gate cannot see)."""
import sys, struct
sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/psyq_pipe')
from images import rom, honest_image, LOAD, retail_functions, TEXT
R = rom(); H, cov = honest_image(0x140000)
fns = [(n, a) for a, n in retail_functions()]
addrs = [a for _, a in fns] + [0x8010CCD4]
rows = []
for (name, a), nxt in zip(fns, addrs[1:]):
    if not any(lo <= a < hi for lo, hi in TEXT): continue
    br = oth = 0
    for x in range(a, min(nxt, a + 0x4000), 4):
        o = x - LOAD
        if not cov[o]: continue
        r, h = struct.unpack_from('<I', R, o)[0], struct.unpack_from('<I', H, o)[0]
        if r == h: continue
        op = r >> 26
        if op in (1, 2, 3, 4, 5, 6, 7) or op in (0x14, 0x15, 0x16, 0x17): br += 1
        else: oth += 1
    if br or oth: rows.append((name, a, br, oth))
only = [r for r in rows if r[3] == 0]
print(f'functions with any mismatch: {len(rows)}; BRANCH-ONLY mismatches: {len(only)}')
for name, a, br, oth in sorted(rows, key=lambda r: (-r[2], r[3]))[:40]:
    print(f'  {name:60s} @{a:08x} branch {br:3d} other {oth:3d}')
