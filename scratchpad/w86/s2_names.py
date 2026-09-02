"""S2 helper: print the oracle-known symbol names of one TU (same set tugate gates)."""
import sys, importlib.util
from pathlib import Path
ROOT = Path(r"C:\Temp\nfs4-decomp")
sys.path.insert(0, str(ROOT / 'tools'))
cpp = sys.argv[1]
sys.argv = [sys.argv[0], cpp, '__none__']
_sp = importlib.util.spec_from_file_location('va', ROOT / 'tools' / 'verify_asm.py')
V = importlib.util.module_from_spec(_sp)
try:
    _sp.loader.exec_module(V)
except SystemExit:
    pass
for n, a in sorted(V._name2addr.items(), key=lambda kv: kv[1]):
    if n and not n.startswith('.'):
        print(f"{a} {n}")
