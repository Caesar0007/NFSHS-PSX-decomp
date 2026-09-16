#!/usr/bin/env python3
"""honestdiff.py [N] -- per input-section diff attribution of the honest GNU image vs the ROM,
from build/gen_ld/recon_multdef-ok.map: which objects/sections carry the differing words."""
import re, sys
from collections import Counter
sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/psyq_pipe')
from images import rom, honest_image, LOAD, ROOT
N = int(sys.argv[1]) if len(sys.argv) > 1 else 25
R = rom(); n = len(R); img, cov = honest_image(n)
rows = []
for m in re.finditer(r'^ (\.\S+)\s+0x([0-9a-f]+)\s+0x([0-9a-f]+)\s+(\S+\.o)$', ROOT.joinpath('build/gen_ld/recon_multdef-ok.map').read_text(errors='replace'), re.M):
    va, sz = int(m.group(2), 16), int(m.group(3), 16)
    if sz and LOAD <= va < LOAD + n:
        rows.append((va, sz, m.group(1), m.group(4)))
rows.sort()
tot = Counter(); diff = Counter()
for va, sz, sec, o in rows:
    for off in range(va - LOAD, min(va - LOAD + sz, n) - 3, 4):
        if not cov[off]: continue
        tot[(o, sec)] += 1
        if img[off:off + 4] != R[off:off + 4]: diff[(o, sec)] += 1
print('%-60s %-22s %6s %6s' % ('object', 'section', 'diff', 'words'))
for (o, sec), d in diff.most_common(N):
    print('%-60s %-22s %6d %6d' % (o.replace('build/', '')[-60:], sec[:22], d, tot[(o, sec)]))
print('total diff words', sum(diff.values()))
