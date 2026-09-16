#!/usr/bin/env python3
"""fndiff.py CPP FN [N] -- unified diff (oracle -> ours) with context via verify_asm's normalizer."""
import sys, difflib, importlib.util
from pathlib import Path
ROOT = Path(__file__).resolve().parents[2]; sys.path.insert(0, str(ROOT/'tools'))
cpp, fn = sys.argv[1], sys.argv[2]; n = int(sys.argv[3]) if len(sys.argv) > 3 else 3
sys.argv = [sys.argv[0], cpp, '__none__']
sp = importlib.util.spec_from_file_location('va', ROOT/'tools'/'verify_asm.py'); V = importlib.util.module_from_spec(sp)
try: sp.loader.exec_module(V)
except SystemExit: pass
o, u = V.oracle(fn), V.ours(fn)
print(f'{fn}: oracle {len(o)} ours {len(u)}')
for l in difflib.unified_diff(o, u, 'oracle', 'ours', n=n, lineterm=''): print(l)
