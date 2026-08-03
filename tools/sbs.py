"""sbs.py CPP FN [LO HI] -- aligned side-by-side of ours vs oracle instruction streams
using difflib opcodes, so index drift is visible. LO/HI clip on the ORACLE index."""
import sys, difflib, importlib.util as _iu
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent; sys.path.insert(0, str(ROOT/'tools'))
cpp, fn = sys.argv[1], sys.argv[2]
lo = int(sys.argv[3]) if len(sys.argv) > 3 else 0
hi = int(sys.argv[4]) if len(sys.argv) > 4 else 10**9
_sp = _iu.spec_from_file_location('va', ROOT/'tools'/'verify_asm.py')
V = _iu.module_from_spec(_sp)
try: _sp.loader.exec_module(V)
except SystemExit: pass
a = V.ours(fn); b = V.oracle(fn)
sm = difflib.SequenceMatcher(None, a, b, autojunk=False)
for tag, i1, i2, j1, j2 in sm.get_opcodes():
    if j2 < lo or j1 > hi:
        continue
    n = max(i2-i1, j2-j1)
    for k in range(n):
        L = a[i1+k] if i1+k < i2 else ''
        R = b[j1+k] if j1+k < j2 else ''
        m = ' ' if tag == 'equal' else '|'
        li = str(i1+k) if i1+k < i2 else ''
        rj = str(j1+k) if j1+k < j2 else ''
        print(f"{li:>4} {L:<34}{m} {rj:>4} {R}")
