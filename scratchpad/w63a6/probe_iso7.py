"""w63a6 CdSearchFile -- fence grid on the POST-printf-fix (37-diff) basin.

qty272 now:
    76 sep      refs 6 live 60 -> .2000  $s3   (retail $s5)
    73 name     refs 5 live 57 -> .1754  $s4   (retail $s3)
    77 notfound refs 3 live 58 -> .0517  $s5   (retail $s4)
Need name > notfound > sep.  In-loop read-only fence operand = +2 weighted refs.
Predicted: name x2 (9 refs -> .4736) + notfound x3 (9 refs -> .4655) > sep (.2000).
"""
import os, subprocess, sys

ROOT = r"C:\Temp\nfs4-decomp"
TU = os.path.join(ROOT, "recon", "syslib", "psx", "libcd", "iso9660.c")
BAK = os.path.join(ROOT, "scratchpad", "w63a6", "iso9660.c.printffix_37_20260815.bak")
HEAD = ("    sep = '\\\\'; notfound = -1; for (i = 0; i < 8; i++) {\r\n").encode("ascii")

GRID = [(2, 3), (2, 2), (1, 2), (3, 3), (1, 1), (3, 4), (2, 4), (4, 5)]


def fence(a, b):
    ops = ['"r"(name)'] * a + ['"r"(notfound)'] * b
    return ('        __asm__("" : : %s);\r\n' % ", ".join(ops)).encode("ascii")


def gate(fn):
    p = subprocess.run([sys.executable, "tools/verify_asm.py", "recon/syslib/psx/libcd/iso9660.c", fn],
                       cwd=ROOT, capture_output=True, text=True, timeout=900)
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
