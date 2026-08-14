import sys, importlib.util
from pathlib import Path
ROOT = Path(r"C:/Temp/nfs4-decomp"); sys.path.insert(0, str(ROOT/'tools'))
cpp, fn = sys.argv[1], sys.argv[2]
sys.argv = ["diffsrc.py", cpp, fn]
sp = importlib.util.spec_from_file_location('ds', ROOT/'tools'/'diffsrc.py')
M = importlib.util.module_from_spec(sp)
try: sp.loader.exec_module(M)
except SystemExit: pass
vas = M.oracle_vas(fn)
orc = M.ns["oracle"](fn)
print("=== ORACLE INSN / SLD ===")
for i,(va,ins) in enumerate(zip(vas, orc)):
    print(f"{i:4} SLD:{M.sld_line(va)}  {ins}")
