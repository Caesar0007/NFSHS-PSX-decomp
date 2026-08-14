#!/usr/bin/env python3
"""w59a1_sbs.py <recon-file> <Fn> -- side-by-side ours|oracle with X marks.
Reuses verify_asm's compile + normalizers (one compile per run)."""
import sys, difflib, importlib.util
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
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
            rows.append(('X', a[i1 + k] if i1 + k < i2 else '', b[j1 + k] if j1 + k < j2 else ''))
print("%s  %s   ours=%d oracle=%d  diffs=%d" % (f, fn, len(a), len(b),
      sum(1 for r in rows if r[0] == 'X' and (r[1] or r[2])) ))
for i, (m, x, y) in enumerate(rows):
    print("%4d %s %-40s | %s" % (i, m, x, y))
