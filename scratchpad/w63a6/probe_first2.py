"""w63a6 firstfile -- SCHED1 ISSUE-POSITION probe for the head `la _first_devname`.

side_by_side (2026-08-15, 5 diffs @ ours 104 / oracle 103):
    ours    ... addu s3,a1 | lui v0 ; addiu a0,v0 | sw ra ; sw s1 ; sw s0 ; lb v0,0(s2) ; NOP
    retail  ... addu s3,a1 | sw ra ; sw s1 ; sw s0 ; lb v0,0(s2) ; lui a0 ; addiu a0,a0
i.e. ours issues the address pair ABOVE the parm/callee-save store group and leaves the
lb's load-delay slot empty; retail issues it AFTER the lb (filling that slot).
W45 law: the fence is a sched-issue-position FIXPOINT -- POSITION is the dial.
The w59-a13 falsification list was measured on the 6-diff @103/103 basin; 04Z says
re-test after any landing, and the basin has since moved to 5 @104/103.
"""
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

VOID = '    __asm__("" : : "i"(0));\n'


def loop(pre="", mid="", post=""):
    return (
        pre
        + "    p = _first_devname;\n"
        + mid
        + "    scan = (signed char *)name;\n"
        + post
        + "    while (*scan > ':')\n"
        + "        *p++ = (unsigned char)*scan++;\n"
        + "    *p = '\\0';\r\n"
    )


VARIANTS = {
    "W1_void_first": loop(pre=VOID),
    "W2_ro_name_first": ('    __asm__("" : : "r"(name), "r"(dir));\n' + BLOCK),
    "W3_scan_first": (
        "    scan = (signed char *)name;\n"
        "    p = _first_devname;\n"
        "    while (*scan > ':')\n"
        "        *p++ = (unsigned char)*scan++;\n"
        "    *p = '\\0';\r\n"
    ),
    "W4_void_between": loop(mid=VOID),
    "W5_void_after_scan": loop(post=VOID),
    "W6_scan_first_void_between": (
        "    scan = (signed char *)name;\n"
        + VOID
        + "    p = _first_devname;\n"
        "    while (*scan > ':')\n"
        "        *p++ = (unsigned char)*scan++;\n"
        "    *p = '\\0';\r\n"
    ),
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
assert BLOCK.encode("ascii") in base
try:
    for name in (sys.argv[1:] or list(VARIANTS)):
        new = base.replace(BLOCK.encode("ascii"), VARIANTS[name].encode("ascii"), 1)
        assert new != base, name
        tmp = TU + ".tmp"
        open(tmp, "wb").write(new)
        assert os.path.getsize(tmp) > 12000
        os.replace(tmp, TU)
        print("%-26s %-46s %s" % (name, gate("firstfile"), gate("_first_patch")), flush=True)
finally:
    open(TU, "wb").write(base)
    print("restored", os.path.getsize(TU))
