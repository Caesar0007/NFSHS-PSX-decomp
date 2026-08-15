"""Dump qty272 for CdSearchFile under the 5-operand read-only fence (why inert?)."""
import os, subprocess, sys

ROOT = r"C:\Temp\nfs4-decomp"
TU = os.path.join(ROOT, "recon", "syslib", "psx", "libcd", "iso9660.c")
BAK = os.path.join(ROOT, "scratchpad", "w63a6", "iso9660.c.base_20260815.bak")

base = open(BAK, "rb").read()
HEAD = ("    sep = '\\\\'; notfound = -1; for (i = 0; i < 8; i++) {\r\n").encode("ascii")
F = ('        __asm__("" : : "r"(name), "r"(name), "r"(notfound), "r"(notfound), "r"(notfound));\r\n').encode("ascii")
assert HEAD in base, "anchor"
new = base.replace(HEAD, HEAD + F, 1)
open(TU, "wb").write(new)
try:
    p = subprocess.run([sys.executable, "tools/qty272.py", "recon/syslib/psx/libcd/iso9660.c", "CdSearchFile"],
                       cwd=ROOT, capture_output=True, text=True, timeout=900)
    o = p.stdout
    i = o.find("-- GLOBAL")
    print(o[i:i + 1500] if i >= 0 else o[-2000:])
    print(p.stderr[-500:])
finally:
    open(TU, "wb").write(base)
    print("restored", os.path.getsize(TU))
