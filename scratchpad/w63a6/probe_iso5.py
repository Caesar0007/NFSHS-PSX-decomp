"""w63a6 CdSearchFile -- the fence-operand GRID (the 5-op probe proved the dial LIVE).

Measured under `__asm__("" : : "r"(name)x2, "r"(notfound)x3)` at the top of the
outer for-body (in-loop => +2 weighted refs per operand):
    77 notfound refs 3->9  pri .4500 -> $s3
    73 name     refs 6->10 pri .3370 -> $s4
    76 sep      refs 6      pri .1935 -> $s5   <-- ALREADY RETAIL
Retail = name $s3 / notfound $s4 / sep $s5, so notfound is now OVER-dialed.
Predicted fix: name x2 (refs 10, pri .3370) + notfound x2 (refs 7, 2*7/60 = .2333)
=> name > notfound > sep exactly.
"""
import os, subprocess, sys

ROOT = r"C:\Temp\nfs4-decomp"
TU = os.path.join(ROOT, "recon", "syslib", "psx", "libcd", "iso9660.c")
BAK = os.path.join(ROOT, "scratchpad", "w63a6", "iso9660.c.base_20260815.bak")
HEAD = ("    sep = '\\\\'; notfound = -1; for (i = 0; i < 8; i++) {\r\n").encode("ascii")


def fence(nname, nnf):
    ops = ['"r"(name)'] * nname + ['"r"(notfound)'] * nnf
    return ('        __asm__("" : : %s);\r\n' % ", ".join(ops)).encode("ascii")


GRID = [(2, 2), (2, 1), (3, 2), (3, 3), (2, 3), (1, 1)]


def gate(fn):
    p = subprocess.run(
        [sys.executable, "tools/verify_asm.py", "recon/syslib/psx/libcd/iso9660.c", fn],
        cwd=ROOT, capture_output=True, text=True, timeout=900,
    )
    out = p.stdout + p.stderr
    for line in out.splitlines():
        if line.strip().startswith(fn + ":"):
            return line.strip()
    return (out.strip().splitlines() or ["NO OUTPUT"])[-1]


base = open(BAK, "rb").read()
assert HEAD in base
try:
    for a, b in GRID:
        new = base.replace(HEAD, HEAD + fence(a, b), 1)
        tmp = TU + ".tmp"
        open(tmp, "wb").write(new)
        assert os.path.getsize(tmp) > 20000
        os.replace(tmp, TU)
        print("name x%d / notfound x%d   %s" % (a, b, gate("CdSearchFile")), flush=True)
finally:
    open(TU, "wb").write(base)
    print("restored", os.path.getsize(TU))
