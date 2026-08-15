"""w63a6 cdread.c CdRead -- ARM-ORDER (pre-set-the-default) probe.

side_by_side (re-gated 14 diffs, ours 105 / oracle 103) says the switch residual is
purely WHICH ARM IS THE FALL-THROUGH of the `beq $v1,$v0` test:
    retail  beq v1,v0 ; [slot] li v0,582   <- the DEFAULT (0x246) arm's constant
    ours    beq v1,v0 ; [slot] li v0,585   <- the case-0x20 (0x249) arm's constant
W47-a2 "PRE-SET THE DEFAULT BEFORE THE TEST": reorg fills the slot from the
FALL-THROUGH thread, and gcc lays case bodies in SOURCE order -- so moving the
default arm above `case 0x20` should make 0x246 the fall-through.
Also probes class (c): `CdControlB(9,0,0)`'s third arg, where cse substitutes our
live `$a1` zero (`addu a2,a1,zero`) for retail's rematerialized `addu a2,zero,zero`.
"""
import os, subprocess, sys

ROOT = r"C:\Temp\nfs4-decomp"
TU = os.path.join(ROOT, "recon", "syslib", "psx", "libcd", "cdread.c")
BAK = os.path.join(ROOT, "scratchpad", "w63a6", "cdread.c.base_20260815.bak")

SW = (
    "    switch (sel) {\n"
    "    case 0:    *(int *)&g->w10 = 0x200; break;               /* 2048 bytes */\n"
    "    case 0x20: *(int *)&g->w10 = 0x249; break;               /* 2340 bytes (full raw) */\n"
    "    default: {                                      /* 2328 bytes -- own anchor in this arm */\n"
    "        volatile CdrEnv *d = &_cdr;\n"
    '        __asm__("" : "=r"(d) : "0"(d));\n'
    "        d->w10 = 0x246;\n"
    "        break;\n"
    "    }\n"
    "    }\n"
)

DEFARM = (
    "    default: {\n"
    "        volatile CdrEnv *d = &_cdr;\n"
    '        __asm__("" : "=r"(d) : "0"(d));\n'
    "        d->w10 = 0x246;\n"
    "        break;\n"
    "    }\n"
)

C0 = "    case 0:    *(int *)&g->w10 = 0x200; break;\n"
C20 = "    case 0x20: *(int *)&g->w10 = 0x249; break;\n"

CTRLB_OLD = "        CdControlB(9, 0, 0);\n"

VARIANTS = {
    # X1: default arm physically BEFORE case 0x20
    "X1_default_middle": ("    switch (sel) {\n" + C0 + DEFARM + C20 + "    }\n", None),
    # X2: default arm FIRST
    "X2_default_first": ("    switch (sel) {\n" + DEFARM + C0 + C20 + "    }\n", None),
    # X3: if/else chain with the default pre-assigned before the 0x20 test
    "X3_ifelse_preset": (
        "    if (sel == 0) {\n"
        "        *(int *)&g->w10 = 0x200;\n"
        "    } else {\n"
        "        volatile CdrEnv *d = &_cdr;\n"
        '        __asm__("" : "=r"(d) : "0"(d));\n'
        "        d->w10 = 0x246;\n"
        "        if (sel == 0x20)\n"
        "            *(int *)&g->w10 = 0x249;\n"
        "    }\n",
        None,
    ),
    # X4: arm order swap + an opacity fence on a named zero for CdControlB's 3rd arg
    "X4_default_middle_zfence": (
        "    switch (sel) {\n" + C0 + DEFARM + C20 + "    }\n",
        "        { int z = 0; __asm__(\"\" : \"=r\"(z) : \"0\"(z)); CdControlB(9, 0, z); }\n",
    ),
    # X5: baseline switch + the zero fence only
    "X5_zfence_only": (
        SW,
        "        { int z = 0; __asm__(\"\" : \"=r\"(z) : \"0\"(z)); CdControlB(9, 0, z); }\n",
    ),
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
assert SW.encode("ascii") in base and CTRLB_OLD.encode("ascii") in base
try:
    for name in (sys.argv[1:] or list(VARIANTS)):
        sw, ctrl = VARIANTS[name]
        new = base.replace(SW.encode("ascii"), sw.encode("ascii"), 1)
        if ctrl:
            new = new.replace(CTRLB_OLD.encode("ascii"), ctrl.encode("ascii"), 1)
        tmp = TU + ".tmp"
        open(tmp, "wb").write(new)
        assert os.path.getsize(tmp) > 20000
        os.replace(tmp, TU)
        print("%-22s %s" % (name, gate("CdRead")), flush=True)
finally:
    open(TU, "wb").write(base)
    print("restored", os.path.getsize(TU))
