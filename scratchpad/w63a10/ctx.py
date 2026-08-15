#!/usr/bin/env python3
"""ctx.py CPP FUNC [n] -- unified diff with N lines of context ('-'=ours '+'=oracle)."""
import sys, os, importlib.util, difflib
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent.parent
sys.path.insert(0, str(ROOT / 'tools'))
cpp, fn = sys.argv[1], sys.argv[2]
n = int(sys.argv[3]) if len(sys.argv) > 3 else 6
os.environ['VA_MAX'] = '0'
sys.argv = [sys.argv[0], cpp, fn]
spec = importlib.util.spec_from_file_location('va', ROOT / 'tools' / 'verify_asm.py')
va = importlib.util.module_from_spec(spec)
try:
    spec.loader.exec_module(va)
except SystemExit:
    pass
o = va.ours(fn); e = va.oracle(fn)
print('ours %d / oracle %d' % (len(o), len(e)))
for l in difflib.unified_diff(o, e, 'OURS', 'ORACLE', lineterm='', n=n):
    print(l)
