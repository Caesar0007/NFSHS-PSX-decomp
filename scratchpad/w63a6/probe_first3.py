"""Inspect the W3 (scan-first) basin: count-exact 103/103 at 18 diffs vs the
current 5 diffs @ 104/103.  Print the side-by-side so the structural question
(does the la now land in the lb's delay slot?) can be answered directly."""
import os, subprocess, sys

ROOT = r"C:\Temp\nfs4-decomp"
TU = os.path.join(ROOT, "recon", "syslib", "psx", "libapi", "FIRST.c")
BAK = os.path.join(ROOT, "scratchpad", "w63a6", "FIRST.c.base_20260815.bak")

BLOCK = (
    "    p = _first_devname;\n"
    "    scan = (signed char *)name;\n"
    "    while (*scan > ':')\n"
    "        *p++ = (unsigned char)*scan++;\n"
    "    *p = '\\0';\r\n"
)
W3 = (
    "    scan = (signed char *)name;\n"
    "    p = _first_devname;\n"
    "    while (*scan > ':')\n"
    "        *p++ = (unsigned char)*scan++;\n"
    "    *p = '\\0';\r\n"
)

base = open(BAK, "rb").read()
assert BLOCK.encode("ascii") in base
open(TU, "wb").write(base.replace(BLOCK.encode("ascii"), W3.encode("ascii"), 1))
try:
    p = subprocess.run([sys.executable, "tools/side_by_side.py", "recon/syslib/psx/libapi/FIRST.c", "firstfile"],
                       cwd=ROOT, capture_output=True, text=True, timeout=900)
    print(p.stdout[:3000])
finally:
    open(TU, "wb").write(base)
    print("restored", os.path.getsize(TU))
