#!/usr/bin/env python3
"""fncompare.py [N] [--mask] [--vs-honest] -- symbol-anchored comparison of every retail
function (8c record) present in our PSYLINK SYM: reference bytes [ra, ra+size) (retail ROM,
or the honest GNU-lane image with --vs-honest) vs ours at [oa, oa+size).  Layout drift is
factored out by the anchoring; --mask also masks relocation fields so only instruction
SHAPE differences remain (assembler-level: nops, macro expansions, gp-relativity)."""
import sys, json
from images import *
MASK = '--mask' in sys.argv; VSH = '--vs-honest' in sys.argv
args = [a for a in sys.argv[1:] if not a.startswith('--')]
LIMIT = int(args[0]) if args else 40
R = rom(); n = len(R)
img, cov = cpe_image(n)
if VSH:
    ref, rcov = honest_image(n); rsym = honest_symbols()
else:
    ref, rcov = R, bytearray(b'\1' * n); rsym = None
ours = our_symbols(); fns = retail_functions()
tot = eq = 0; bad = []; nfn = 0
for k, (ra, name) in enumerate(fns):
    if name not in ours or text_end(ra) is None: continue
    if VSH:
        if name not in rsym: continue
        ra = rsym[name]
        nxt = next((a for a, _ in fns[k + 1:] if a > fns[k][0]), text_end(fns[k][0]))
        size = min(nxt, text_end(fns[k][0])) - fns[k][0]
    else:
        nxt = next((a for a, _ in fns[k + 1:] if a > ra), text_end(ra))
        size = min(nxt, text_end(ra)) - ra
    size = min(size, 0x8000)
    oa = ours[name]
    if oa - LOAD + size > n or not cov[oa - LOAD] or not rcov[ra - LOAD]: continue
    nfn += 1
    r = ref[ra - LOAD: ra - LOAD + size]; o = img[oa - LOAD: oa - LOAD + size]
    words = size // 4
    if MASK:
        same = sum(1 for j in range(0, size - 3, 4) if norm(r[j:j + 4]) == norm(o[j:j + 4]))
        diffs = [j for j in range(0, size - 3, 4) if norm(r[j:j + 4]) != norm(o[j:j + 4]) and not is_branch_pair(r[j:j + 4], o[j:j + 4])]
    else:
        same = sum(1 for j in range(0, size - 3, 4) if r[j:j + 4] == o[j:j + 4])
        diffs = [j for j in range(0, size - 3, 4) if r[j:j + 4] != o[j:j + 4]]
    tot += words; eq += same
    if same != words:
        fd = diffs[0] if diffs else next(j for j in range(0, size - 3, 4) if (norm(r[j:j + 4]) != norm(o[j:j + 4]) if MASK else r[j:j + 4] != o[j:j + 4]))
        bad.append((words - same, name, ra, size, fd, r[fd:fd + 4].hex(), o[fd:fd + 4].hex()))
print('functions compared %d; words %d identical %d (%.3f%%); functions with diffs %d  [%s%s]'
      % (nfn, tot, eq, 100.0 * eq / tot, len(bad), 'masked' if MASK else 'exact', ', vs honest' if VSH else ', vs retail'))
bad.sort(key=lambda b: -b[0])
for nn, name, ra, size, fd, rw, ow in bad[:LIMIT]:
    print('  %5d/%-5d %-60s @%#x +%#x ref %s ours %s' % (nn, size // 4, name[:60], ra, fd, rw, ow))
json.dump([(name, nn) for nn, name, *_ in bad], open(W / 'fncompare_bad.json', 'w'), indent=0)
