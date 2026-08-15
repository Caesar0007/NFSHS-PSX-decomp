"""w63a6 _read_issue -- the TAIL-ANCHOR POSITION angle named in the w62-a6 receipt.

side_by_side (re-gated 15 diffs, ours 119 / oracle 122, 3 SHORT):
    retail  jal CdPosToInt ; [slot] addu a0,v0 | lui a0 ; addiu a0   (la _read_int)
            | lui s0 ; addiu s0 (la _cdr)  | jal CdReadyCallback ; [slot] sw v0,32(s0)
    ours    the `lui s0` half is STOLEN backwards into an earlier jal's delay slot
            (retail keeps a nop there) and `addiu s0` lands after the a0 pair.
The receipt's untested shape: split the sector value into its own local so the anchor
is minted AFTER the CdPosToInt result exists.
"""
import os, subprocess, sys

ROOT = r"C:\Temp\nfs4-decomp"
TU = os.path.join(ROOT, "recon", "syslib", "psx", "libcd", "cdread.c")
BAK = os.path.join(ROOT, "scratchpad", "w63a6", "cdread.c.base_20260815.bak")

BLOCK = (
    "    g = &_cdr;                      /* MATCH: TAIL ANCHOR ($s0) -- one `la` for the whole tail */\n"
    '    __asm__("" : "=r"(g) : "0"(g));\n'
    "    *(int *)&g->w20 = CdPosToInt((CdlLOC *)CdLastPos());             /* start sector */\n"
)

DECL = "    volatile CdrEnv *g;\n"

VARIANTS = {
    # Y1: split the sector value out; anchor minted after the call
    "Y1_sect_local": (
        DECL + "    int sect;\n",
        "    sect = CdPosToInt((CdlLOC *)CdLastPos());\n"
        "    g = &_cdr;\n"
        '    __asm__("" : "=r"(g) : "0"(g));\n'
        "    *(int *)&g->w20 = sect;\n",
    ),
    # Y2: same, plus a void barrier immediately before the anchor
    "Y2_sect_local_void": (
        DECL + "    int sect;\n",
        "    sect = CdPosToInt((CdlLOC *)CdLastPos());\n"
        '    __asm__("" : : "i"(0));\n'
        "    g = &_cdr;\n"
        '    __asm__("" : "=r"(g) : "0"(g));\n'
        "    *(int *)&g->w20 = sect;\n",
    ),
    # Y3: keep the current order but add a void barrier before the anchor
    "Y3_void_before_anchor": (
        DECL,
        '    __asm__("" : : "i"(0));\n'
        "    g = &_cdr;\n"
        '    __asm__("" : "=r"(g) : "0"(g));\n'
        "    *(int *)&g->w20 = CdPosToInt((CdlLOC *)CdLastPos());\n",
    ),
    # Y4: sector local, no identity fence on the anchor
    "Y4_sect_local_nofence": (
        DECL + "    int sect;\n",
        "    sect = CdPosToInt((CdlLOC *)CdLastPos());\n"
        "    g = &_cdr;\n"
        "    *(int *)&g->w20 = sect;\n",
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
assert BLOCK.encode("ascii") in base and DECL.encode("ascii") in base
try:
    for name in (sys.argv[1:] or list(VARIANTS)):
        decl, blk = VARIANTS[name]
        new = base.replace(BLOCK.encode("ascii"), blk.encode("ascii"), 1)
        new = new.replace(DECL.encode("ascii"), decl.encode("ascii"), 1)
        tmp = TU + ".tmp"
        open(tmp, "wb").write(new)
        assert os.path.getsize(tmp) > 20000
        os.replace(tmp, TU)
        print("%-24s %s" % (name, gate("_read_issue")), flush=True)
finally:
    open(TU, "wb").write(base)
    print("restored", os.path.getsize(TU))
