"""Under the name x2 / notfound x2 fence: dump BOTH the qty272 dispositions and the
verify_asm diff, to see whether the .greg order change survives reload."""
import os, subprocess, sys

ROOT = r"C:\Temp\nfs4-decomp"
TU = os.path.join(ROOT, "recon", "syslib", "psx", "libcd", "iso9660.c")
BAK = os.path.join(ROOT, "scratchpad", "w63a6", "iso9660.c.base_20260815.bak")
HEAD = ("    sep = '\\\\'; notfound = -1; for (i = 0; i < 8; i++) {\r\n").encode("ascii")
F = ('        __asm__("" : : "r"(name), "r"(name), "r"(notfound), "r"(notfound));\r\n').encode("ascii")

base = open(BAK, "rb").read()
assert HEAD in base
open(TU, "wb").write(base.replace(HEAD, HEAD + F, 1))
try:
    p = subprocess.run([sys.executable, "tools/qty272.py", "recon/syslib/psx/libcd/iso9660.c", "CdSearchFile"],
                       cwd=ROOT, capture_output=True, text=True, timeout=900)
    o = p.stdout
    i = o.find("-- GLOBAL")
    print(o[i:] if i >= 0 else o[-2500:])
    env = dict(os.environ, VA_MAX="200")
    p2 = subprocess.run([sys.executable, "tools/verify_asm.py", "recon/syslib/psx/libcd/iso9660.c", "CdSearchFile"],
                        cwd=ROOT, capture_output=True, text=True, timeout=900, env=env)
    print(p2.stdout[:2500])
finally:
    open(TU, "wb").write(base)
    print("restored", os.path.getsize(TU))
