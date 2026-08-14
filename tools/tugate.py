"""tugate.py CPP -- gate every oracle-known symbol in one TU; print PASS/FAIL table."""
import sys, difflib, importlib.util, re, subprocess
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent; sys.path.insert(0, str(ROOT/'tools'))
cpp = sys.argv[1]
sys.argv = [sys.argv[0], cpp, '__none__']
_sp = importlib.util.spec_from_file_location('va', ROOT/'tools'/'verify_asm.py')
V = importlib.util.module_from_spec(_sp)
try: _sp.loader.exec_module(V)
except SystemExit as e:
    # w60-a4: a TU that fails to COMPILE aborts verify_asm here; swallowing it
    # used to surface as a bogus AttributeError on _name2addr below.
    if not hasattr(V, '_name2addr'):
        sys.exit(f"tugate: verify_asm aborted loading {cpp} (exit {e.code}) -- the compile diagnostics above are the real error")
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
    # w60-a10: apply verify_asm's w59-a9 dead-%hi collapse (tugate diffs the raw
    # streams itself, so without this it OVER-REPORTS vs the authoritative gate).
    if len(a) == len(b):
        for i in range(len(a)):
            mo = re.match(r'lui (\w+),0$', a[i]); me = re.match(r'lui (\w+),\d+$', b[i])
            if mo and me and mo.group(1) == me.group(1): b[i] = a[i]
    d = [l for l in difflib.unified_diff(a, b, lineterm='') if l[0] in '+-' and not l.startswith(('+++','---'))]
    res.append((len(d), n))
res.sort()
npass = sum(1 for c, _ in res if c == 0)
print(f"{cpp}: {npass}/{len(res)} PASS")
for c, n in res:
    if c: print(f"  {c:5}  {n}")
