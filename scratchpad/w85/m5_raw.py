#!/usr/bin/env python3
"""m5_raw.py REGION CAND FUNC [--lane-as=...] -- READ-ONLY: dump ours + oracle
instruction streams unaligned, side by side by INDEX."""
import sys
from pathlib import Path
ROOT = Path(__file__).resolve().parents[2]
VR = (ROOT / 'regiondiff' / 'tools' / 'verify_region.py').read_text()
head = VR.split('# ------------------------------------------------------------------ diff')[0]
g = {'__file__': str(ROOT / 'regiondiff' / 'tools' / 'verify_region.py'), '__name__': 'vr'}
exec(compile(head, 'verify_region_head', 'exec'), g)
for fn in g['funcs']:
    o = [x[0] for x in g['ours'](fn)]; e = g['oracle'](fn)
    print(f"=== {fn} ours {len(o)} oracle {len(e)}")
    for i in range(max(len(o), len(e))):
        a = o[i] if i < len(o) else ''
        b = e[i] if i < len(e) else ''
        print(f"{i:>4} {a:<36} | {b:<36}")
