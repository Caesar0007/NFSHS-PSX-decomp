
import sys, re, difflib, importlib.util
from pathlib import Path
ROOT = Path(r"C:\Temp\nfs4-decomp"); sys.path.insert(0, str(ROOT/"tools"))
cpp, wanted = sys.argv[1], sys.argv[2].split("\x1f")
sys.argv = [sys.argv[0], cpp, "__none__"]
sp = importlib.util.spec_from_file_location("va", ROOT/"tools"/"verify_asm.py")
V = importlib.util.module_from_spec(sp)
try: sp.loader.exec_module(V)
except SystemExit as e:
    if not hasattr(V, "_name2addr"):
        print("!!COMPILEFAIL"); raise SystemExit(0)
for n in wanted:
    try: b = V.oracle(n)
    except Exception: b = None
    if b is None: print(f"{n}\tNOORACLE"); continue
    try: a = V.ours(n)
    except Exception: a = None
    if not a: print(f"{n}\tNOTINOBJ"); continue
    if len(a) == len(b):                       # verify_asm's w59-a9 dead-%hi collapse
        for i in range(len(a)):
            mo = re.match(r"lui (\w+),0$", a[i]); me = re.match(r"lui (\w+),\d+$", b[i])
            if mo and me and mo.group(1) == me.group(1): b[i] = a[i]
    d = [l for l in difflib.unified_diff(a, b, lineterm="")
         if l[0] in "+-" and not l.startswith(("+++","---"))]
    print(f"{n}\t" + ("PASS" if not d else f"FAIL:{len(d)}"))
