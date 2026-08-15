"""w63a6 _read_issue -- void-barrier sweep at the two remaining stolen-`lui` slots
(12-diff basin).  side_by_side shows ours filling two branch delay slots that retail
leaves `nop`: the `beqz $v0` of the CdlSetloc guard and the `bnez $v0` of the
CdlSetmode guard.  reorg.c stop_search_p halts the backward scan at any asm."""
import os, subprocess, sys

ROOT = r"C:\Temp\nfs4-decomp"
TU = os.path.join(ROOT, "recon", "syslib", "psx", "libcd", "cdread.c")
BAK = os.path.join(ROOT, "scratchpad", "w63a6", "cdread.c.issue12_20260815.bak")

FLUSH = "    CdFlush();\n"
ERRLBL = "            error:\n"
VOID = '__asm__("" : : "i"(0));'

VARIANTS = {
    "Z1_before_flush": [(FLUSH, "    " + VOID + "\n" + FLUSH)],
    "Z2_after_flush": [(FLUSH, FLUSH + "    " + VOID + "\n")],
    "Z3_error_head": [(ERRLBL, ERRLBL + "                " + VOID + "\n")],
    "Z4_before_flush_and_error": [
        (FLUSH, "    " + VOID + "\n" + FLUSH),
        (ERRLBL, ERRLBL + "                " + VOID + "\n"),
    ],
    "Z5_after_flush_and_error": [
        (FLUSH, FLUSH + "    " + VOID + "\n"),
        (ERRLBL, ERRLBL + "                " + VOID + "\n"),
    ],
}


def gate(fn):
    p = subprocess.run([sys.executable, "tools/verify_asm.py", "recon/syslib/psx/libcd/cdread.c", fn],
                       cwd=ROOT, capture_output=True, text=True, timeout=900)
    out = p.stdout + p.stderr
    for line in out.splitlines():
        if line.strip().startswith(fn + ":"):
            return line.strip()
    return (out.strip().splitlines() or ["NO OUTPUT"])[-1]


base = open(BAK, "rb").read()
assert FLUSH.encode("ascii") in base and ERRLBL.encode("ascii") in base
try:
    for name in (sys.argv[1:] or list(VARIANTS)):
        new = base
        for old, rep in VARIANTS[name]:
            assert old.encode("ascii") in new, (name, old)
            new = new.replace(old.encode("ascii"), rep.encode("ascii"), 1)
        tmp = TU + ".tmp"
        open(tmp, "wb").write(new)
        assert os.path.getsize(tmp) > 20000
        os.replace(tmp, TU)
        print("%-28s %s" % (name, gate("_read_issue")), flush=True)
finally:
    open(TU, "wb").write(base)
    print("restored", os.path.getsize(TU))
