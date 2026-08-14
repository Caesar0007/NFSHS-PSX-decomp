"""sbs.py CPP FN -- side-by-side ours|oracle listing via verify_asm's own normalizers."""
import sys, difflib, importlib.util
from pathlib import Path
ROOT = Path(r'C:/Temp/nfs4-decomp'); sys.path.insert(0, str(ROOT/'tools'))
cpp, fn = sys.argv[1], sys.argv[2]
_sp = importlib.util.spec_from_file_location('va', ROOT/'scratchpad'/'w60a4'/'vprobe.py')
V = importlib.util.module_from_spec(_sp)
try: _sp.loader.exec_module(V)
except SystemExit: pass
a = V.ours(fn); b = V.oracle(fn)
sm = difflib.SequenceMatcher(None, a, b, autojunk=False)
print(f"ours={len(a)} oracle={len(b)}")
ia = ib = 0
for tag, i1, i2, j1, j2 in sm.get_opcodes():
    if tag == 'equal':
        for k in range(i2-i1):
            print(f"{i1+k:4} {a[i1+k]:<34}   | {j1+k:4} {b[j1+k]}")
    else:
        n = max(i2-i1, j2-j1)
        for k in range(n):
            l = a[i1+k] if i1+k < i2 else ''
            r = b[j1+k] if j1+k < j2 else ''
            li = str(i1+k) if i1+k < i2 else ''
            ri = str(j1+k) if j1+k < j2 else ''
            print(f"{li:>4} {l:<34} X | {ri:>4} {r}")
