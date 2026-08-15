#!/usr/bin/env python3
"""sbs.py <recon-file> <Fn> -- side-by-side ours|oracle with X marks (scratchpad copy of
tools/sbsx.py with the ROOT depth fixed for scratchpad/w60a2/)."""
import sys, difflib, importlib.util
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tools'))
f, fn = sys.argv[1], sys.argv[2]
sys.argv = [sys.argv[0], f, '__none__']
spec = importlib.util.spec_from_file_location('va', ROOT / 'tools' / 'verify_asm.py')
V = importlib.util.module_from_spec(spec)
try:
    spec.loader.exec_module(V)
except SystemExit:
    pass

a = V.ours(fn)
b = V.oracle(fn)
sm = difflib.SequenceMatcher(None, a, b, autojunk=False)
rows = []
for tag, i1, i2, j1, j2 in sm.get_opcodes():
    if tag == 'equal':
        for k in range(i2 - i1):
            rows.append((' ', a[i1 + k], b[j1 + k]))
    else:
        n = max(i2 - i1, j2 - j1)
        for k in range(n):
            l = a[i1 + k] if i1 + k < i2 else ''
            r = b[j1 + k] if j1 + k < j2 else ''
            rows.append(('X', l, r))
print(f"{fn}: ours {len(a)} / oracle {len(b)}")
for i, (m, l, r) in enumerate(rows):
    print(f"{i:4} {m} {l:<40} | {r}")
