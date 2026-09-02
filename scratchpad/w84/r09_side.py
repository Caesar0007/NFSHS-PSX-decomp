#!/usr/bin/env python3
"""r09_side.py REGION CPP FUNC [--lane-as=recon/...]  -- side-by-side aligned
dump of ours vs the regional oracle, reusing verify_region.py's own logic by
exec'ing it with a patched print stage.  READ-ONLY helper; does not modify any
tool.  (scratchpad-local, W84-R09)
"""
import sys, os, re, runpy, io, difflib
from pathlib import Path

ROOT = Path(r'C:/Temp/nfs4-decomp')
sys.argv = ['verify_region.py'] + sys.argv[1:]
src = (ROOT / 'regiondiff' / 'tools' / 'verify_region.py').read_text()
# cut the file at the "# ------ diff" marker so we keep ours()/oracle()/skeleton()
head = src.split('# ------------------------------------------------------------------ diff')[0]
g = {'__file__': str(ROOT / 'regiondiff' / 'tools' / 'verify_region.py'), '__name__': 'vr'}
exec(compile(head, 'verify_region.py', 'exec'), g)

ours, oracle, skeleton, mask_reloc = g['ours'], g['oracle'], g['skeleton'], g['mask_reloc']
for fn in g['funcs']:
    o = ours(fn); e = oracle(fn)
    o_txt = [x[0] for x in o]; o_kind = [x[1] for x in o]
    sm = difflib.SequenceMatcher(None, [skeleton(x) for x in o_txt],
                                       [skeleton(x) for x in e], autojunk=False)
    print(f'=== {fn}  ours {len(o)} / oracle {len(e)} ===')
    print(f'{"idx":>4} {"OURS":<44} | ORACLE')
    for tag, i1, i2, j1, j2 in sm.get_opcodes():
        if tag == 'equal':
            for k in range(i2 - i1):
                i, j = i1 + k, j1 + k
                a, b = o_txt[i], e[j]
                if o_kind[i]:
                    a2 = mask_reloc(a, o_kind[i]); b2 = mask_reloc(b, o_kind[i])
                else:
                    a2, b2 = a, b
                mark = '   ' if a2 == b2 else '!!!'
                print(f'{i:>4} {o_txt[i]:<44} | {e[j]:<40} {mark}')
        else:
            for i in range(i1, i2):
                print(f'{i:>4} {o_txt[i]:<44} | {"":<40} <<<ours-only')
            for j in range(j1, j2):
                print(f'{"":>4} {"":<44} | {e[j]:<40} >>>oracle-only')
