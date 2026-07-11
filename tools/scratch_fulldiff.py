#!/usr/bin/env python3
"""scratch_fulldiff.py CPP FUNC — full side-by-side unified diff (no 12-line cap), context=2."""
import sys, difflib
sys.argv = ['verify_asm.py', sys.argv[1], sys.argv[2]]
import importlib.util
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent
spec = importlib.util.spec_from_file_location('va', ROOT / 'tools' / 'verify_asm.py')
va = importlib.util.module_from_spec(spec)
# verify_asm.py runs its diff+exit at import time; we don't want that, so patch sys.exit temporarily
_orig_exit = sys.exit
sys.exit = lambda *a, **k: None
try:
    spec.loader.exec_module(va)
finally:
    sys.exit = _orig_exit

fn = sys.argv[2].split(',')[0]
o = va.ours(fn)
e = va.oracle(fn)
print(f"ours={len(o)} oracle={len(e)}")
for l in difflib.unified_diff(o, e, lineterm='', n=3, fromfile='ours', tofile='oracle'):
    print(l)
