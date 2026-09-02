#!/usr/bin/env python3
"""m5_side.py REGION CAND FUNC [--lane-as=...]  -- READ-ONLY side-by-side dumper.

Re-uses regiondiff/tools/verify_region.py verbatim up to (but not including)
its diff section, then prints an ALIGNED side-by-side of ours vs oracle.
Does not modify any tool.
"""
import sys, re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
VR = (ROOT / 'regiondiff' / 'tools' / 'verify_region.py').read_text()
head = VR.split('# ------------------------------------------------------------------ diff')[0]
g = {'__file__': str(ROOT / 'regiondiff' / 'tools' / 'verify_region.py'), '__name__': 'vr'}
exec(compile(head, 'verify_region_head', 'exec'), g)

import difflib
funcs = g['funcs']
for fn in funcs:
    o = g['ours'](fn); e = g['oracle'](fn)
    o_txt = [x[0] for x in o]; o_kind = [x[1] for x in o]
    skeleton = g['skeleton']; mask_reloc = g['mask_reloc']
    sm = difflib.SequenceMatcher(None, [skeleton(x) for x in o_txt],
                                       [skeleton(x) for x in e], autojunk=False)
    print(f"=== {fn}  ours {len(o)} / oracle {len(e)}")
    print(f"{'#':>4} {'':1} {'OURS':<38} {'ORACLE':<38}")
    for tag, i1, i2, j1, j2 in sm.get_opcodes():
        if tag == 'equal':
            for k in range(i2 - i1):
                i, j = i1 + k, j1 + k
                a, b = o_txt[i], e[j]
                if o_kind[i]:
                    a = mask_reloc(a, o_kind[i]); b = mask_reloc(b, o_kind[i])
                mark = ' ' if a == b else '*'
                print(f"{i:>4} {mark} {o_txt[i]:<38} {e[j]:<38}")
        else:
            for i in range(i1, i2):
                print(f"{i:>4} - {o_txt[i]:<38} {'':<38}")
            for j in range(j1, j2):
                print(f"{'':>4} + {'':<38} {e[j]:<38}")
