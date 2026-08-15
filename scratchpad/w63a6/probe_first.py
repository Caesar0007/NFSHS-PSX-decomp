"""w63a6 libapi/FIRST.c firstfile -- HEAD address-materialization probe.

Residual (re-gated 2026-08-15): 5 diffs, ours 104 / oracle 103.
    ours    lui $v0,%hi ; addiu $a0,$v0,%lo ; nop      (separate scratch + unfilled slot)
    retail  lui $a0,%hi ; addiu $a0,$a0,%lo            (SELF-temp, lui in the lb's slot)
W43 law: array DECAY (`char *p = arr;`) gives the separate-%hi-scratch schedulable form,
`&scalar` folds back to self-temp.  The prior falsification list covers SIZED arrays
([32]/[16] inert, [4]/[1] = 15) but never the &scalar spelling -- that is what these test.
NOTE the loop site (`strcmp(e->name, _first_devname)`) MUST keep the unsized array form
(w48-a7: a known size lets loop.c hoist the high half into a callee-saved reg), so the
scalar view is a SECOND asm-labelled declaration used only at the head.
"""
import os, subprocess, sys

ROOT = r"C:\Temp\nfs4-decomp"
TU = os.path.join(ROOT, "recon", "syslib", "psx", "libapi", "FIRST.c")
BAK = os.path.join(ROOT, "scratchpad", "w63a6", "FIRST.c.base_20260815.bak")

# NB: FIRST.c has MIXED line endings -- the decl line is CRLF, the body line is LF.
DECLANCHOR = "extern char    _first_devname[];     /* @0x80148A84 : device prefix extracted from `name` */\r\n"
HEAD = "    p = _first_devname;\n"

SCALARDECL = (
    DECLANCHOR
    + "/* w63-a6 probe: &scalar view of the same storage (W43 array-decay-vs-&scalar law). */\r\n"
    + 'extern char    _first_devname_h __asm__("_first_devname");\r\n'
)

VARIANTS = {
    "V1_scalar_view": (SCALARDECL, "    p = &_first_devname_h;\n"),
    "V2_scalar_view_cast": (SCALARDECL, "    p = (char *)&_first_devname_h;\n"),
    "V3_idfence_p": (DECLANCHOR, '    p = _first_devname;\n    __asm__("" : "=r"(p) : "0"(p));\n'),
    "V4_rofence_p": (DECLANCHOR, '    p = _first_devname;\n    __asm__("" : : "r"(p));\n'),
    "V5_index0": (DECLANCHOR, "    p = &_first_devname[0];\n"),
}


def gate(fn):
    p = subprocess.run([sys.executable, "tools/verify_asm.py", "recon/syslib/psx/libapi/FIRST.c", fn],
                       cwd=ROOT, capture_output=True, text=True, timeout=900)
    out = p.stdout + p.stderr
    for line in out.splitlines():
        if line.strip().startswith(fn + ":"):
            return line.strip()
    return (out.strip().splitlines() or ["NO OUTPUT"])[-1]


base = open(BAK, "rb").read()
assert DECLANCHOR.encode("ascii") in base and HEAD.encode("ascii") in base
try:
    for name in (sys.argv[1:] or list(VARIANTS)):
        decl, head = VARIANTS[name]
        new = base.replace(DECLANCHOR.encode("ascii"), decl.encode("ascii"), 1)
        new = new.replace(HEAD.encode("ascii"), head.encode("ascii"), 1)
        tmp = TU + ".tmp"
        open(tmp, "wb").write(new)
        assert os.path.getsize(tmp) > 12000
        os.replace(tmp, TU)
        print("%-20s %-46s %s" % (name, gate("firstfile"), gate("_first_patch")), flush=True)
finally:
    open(TU, "wb").write(base)
    print("restored", os.path.getsize(TU))
