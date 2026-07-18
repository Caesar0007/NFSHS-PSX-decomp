#!/usr/bin/env python3
"""fulldiff2.py CPP FUNC -- print FULL side-by-side diff (no 12-line cap)."""
import sys, importlib.util, difflib
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent
sys.argv = ['verify_asm.py', sys.argv[1], sys.argv[2]]
spec = importlib.util.spec_from_file_location('vfy', ROOT/'tools'/'verify_asm.py')
vfy = importlib.util.module_from_spec(spec)
try:
    spec.loader.exec_module(vfy)
except SystemExit:
    pass
fn = sys.argv[2]
o = vfy.ours(fn); e = vfy.oracle(fn)
print(f"ours={len(o)} oracle={len(e)}")
sm = difflib.SequenceMatcher(None, o, e, autojunk=False)
for tag, i1, i2, j1, j2 in sm.get_opcodes():
    if tag == 'equal':
        continue
    print(f"--- {tag} ours[{i1}:{i2}] oracle[{j1}:{j2}]")
    for l in o[i1:i2]:
        print(f"  -{l}")
    for l in e[j1:j2]:
        print(f"  +{l}")
