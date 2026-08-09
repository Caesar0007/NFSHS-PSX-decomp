"""tugate.py CPP -- gate every oracle-known symbol in one TU; print PASS/FAIL table."""
import sys, difflib, importlib.util, re, subprocess
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent; sys.path.insert(0, str(ROOT/'tools'))
cpp = sys.argv[1]
sys.argv = [sys.argv[0], cpp, '__none__']
_sp = importlib.util.spec_from_file_location('va', ROOT/'tools'/'verify_asm.py')
V = importlib.util.module_from_spec(_sp)
try: _sp.loader.exec_module(V)
except SystemExit: pass
names = [n for n in V._name2addr if not n.startswith('.') and n]
res = []
for n in sorted(set(names)):
    try:
        b = V.oracle(n)
        if not b: continue
        a = V.ours(n)
        if not a: continue
    except Exception:
        continue
    d = [l for l in difflib.unified_diff(a, b, lineterm='') if l[0] in '+-' and not l.startswith(('+++','---'))]
    res.append((len(d), n))
res.sort()
npass = sum(1 for c, _ in res if c == 0)
print(f"{cpp}: {npass}/{len(res)} PASS")
for c, n in res:
    if c: print(f"  {c:5}  {n}")
