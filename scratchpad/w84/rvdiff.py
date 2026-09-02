#!/usr/bin/env python3
"""rvdiff.py REGION CPP FUNC [--lane-as=...] -- full aligned regional diff, no truncation.

Read-only helper for W84 R08: re-uses regiondiff/tools/verify_region.py's own
compile + normalizer + oracle loader (exec'd up to its diff driver), then prints
the SAME skeleton-aligned pairing with full context instead of the 12-line cap.
Does not modify any tool.
"""
import sys, difflib
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
VR = ROOT / 'regiondiff' / 'tools' / 'verify_region.py'
src = VR.read_text()
cut = src.index('allpass = True')
header = src[:cut]
ns = {'__file__': str(VR), '__name__': '__vr__'}
sys.argv = ['verify_region.py'] + sys.argv[1:]
exec(compile(header, str(VR), 'exec'), ns)

funcs = ns['funcs']
for fn in funcs:
    o = ns['ours'](fn); e = ns['oracle'](fn)
    if e is None:
        print(f'{fn}: NO ORACLE'); continue
    if not o:
        print(f'{fn}: NOT IN OBJECT'); continue
    o_txt = [x[0] for x in o]; o_kind = [x[1] for x in o]
    skeleton = ns['skeleton']; mask_reloc = ns['mask_reloc']
    sm = difflib.SequenceMatcher(None, [skeleton(x) for x in o_txt],
                                       [skeleton(x) for x in e], autojunk=False)
    print(f'=== {fn}  ours={len(o)} oracle={len(e)} ===')
    for tag, i1, i2, j1, j2 in sm.get_opcodes():
        if tag == 'equal':
            for k in range(i2 - i1):
                i, j = i1 + k, j1 + k
                a, b = o_txt[i], e[j]
                if o_kind[i]:
                    a = mask_reloc(a, o_kind[i]); b = mask_reloc(b, o_kind[i])
                if a != b:
                    print(f'  {i:4d} !  {o_txt[i]:<34} | {e[j]}')
                else:
                    print(f'  {i:4d}    {o_txt[i]:<34} | {e[j]}')
        else:
            for i in range(i1, i2): print(f'  {i:4d} -  {o_txt[i]}')
            for j in range(j1, j2): print(f'  {"":4}  +  {"":34} | {e[j]}')
