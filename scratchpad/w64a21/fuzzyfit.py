#!/usr/bin/env python3
"""w64a21 fuzzyfit.py -- work out WHICH diff kinds the board's fuzzy_match_percent
actually charges for.

objdiff's report metric is `fuzzy_match_percent`; the interactive one-shot diff
reports `match_percent`.  They disagree (Camera_UpdateHeliCam: 99.9887 vs 99.9097),
so the board's under/over-counting cannot be reasoned about from the diff view
alone.  Empirically: a full instruction insert/delete costs 1.0 instruction and an
argument mismatch costs 0.05 instruction, so

    charged = (1 - fuzzy/100) * n_insns          (in "instruction" units)

is directly comparable to  1.00*STRUCT + 0.05*(arg diffs of each class).
This script prints, per row, the charged budget vs the per-class counts so the
free classes fall out.
"""
import json
from pathlib import Path

S = Path(r'C:\Temp\nfs4-decomp\scratchpad\w64a21')

rows = json.load(open(S / 'classified.json'))
mech = {(json.loads(l)['unit'], json.loads(l)['fn']): json.loads(l)
        for l in open(S / 'objclass.jsonl')}

print(f"{'charged':>8} {'struct':>6} {'arg':>4}  {'per-class arg counts':<52} fn")
for r in sorted(rows, key=lambda x: x['va']):
    m = mech.get((r['unit'], r['fn']))
    if not m or m.get('err'):
        continue
    n = m.get('n_right') or 0
    if not n or r['after'] is None:
        continue
    charged = (100.0 - r['after']) / 100.0 * n
    c = dict(m.get('classes', {}))
    st = c.pop('STRUCT', 0)
    arg = sum(c.values())
    print(f"{charged:8.3f} {st:6} {arg:4}  {str(c):<52} {r['unit']}/{r['fn'][:40]}")
