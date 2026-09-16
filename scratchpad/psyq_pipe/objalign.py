#!/usr/bin/env python3
"""objalign.py -- retail object start alignment (first function address mod 8) per region,
and which object starts at a given address (argv)."""
import json, sys
from collections import Counter
o = json.load(open('C:/Temp/nfs4-decomp/scratchpad/psyq_pipe/sym_obj_order.json'))
best = {}
for e in o:
    if e[1] is not None: best[e[0]] = e
front = Counter(); main = Counter()
for n, e in best.items():
    a = e[1]
    if 0x800128F0 <= a < 0x80051260: front[a % 8] += 1
    elif 0x8005797C <= a < 0x8010CCD4: main[a % 8] += 1
print('front objects first-fn addr mod 8:', dict(front))
print('main  objects first-fn addr mod 8:', dict(main))
short = lambda n: n.split(chr(92))[-1]
print('main objects at 4 mod 8:', [(short(n), hex(e[1])) for n, e in best.items() if 0x8005797C <= e[1] < 0x8010CCD4 and e[1] % 8 == 4][:40])
print('front objects at 4 mod 8:', [(short(n), hex(e[1])) for n, e in best.items() if 0x800128F0 <= e[1] < 0x80051260 and e[1] % 8 == 4][:40])
for a in sys.argv[1:]:
    a = int(a, 16)
    print(hex(a), '->', [(short(n), hex(e[1]), hex(e[2])) for n, e in best.items() if e[1] <= a <= e[2]])
