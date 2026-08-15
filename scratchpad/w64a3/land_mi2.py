#!/usr/bin/env python3
"""W64-A3 landing #2: MoveImage 4 -> PASS 46/46 (E1).
Two named locals restore retail's sched2 LUID order: `srcxy` (the src word,
read before the driver table) and `drv` (the GEnv_drv pointer, read once).
Asserting, byte-mode, LF-preserving."""
import os
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
P = ROOT / "recon/syslib/psx/libgpu/SYS.c"
raw = P.read_bytes()
assert b"\r\n" not in raw, "SYS.c must stay LF"
t = raw.decode("utf-8")

DECL = "    short *r = (short *)rect;\n    u_long *p;\n"
DECL_NEW = ("    short *r = (short *)rect;\n    u_long *p;\n"
            "    u_long srcxy;\n    GpuTbl *drv;\n")
ANCHOR = "    p = &_move_prim[2];\n"
ANCHOR_NEW = (ANCHOR
              + "    srcxy = *(u_long *)rect;\n"
                "    drv = GEnv_drv;\n")
S0 = "    p[0] = *(u_long *)rect;                      /* src xy */\n"
S0_NEW = "    p[0] = srcxy;                                /* src xy */\n"
RET = "    return GEnv_drv->que_push((QueFunc)GEnv_drv->dma_chain, p - 2, 0x14, 0);\n"
RET_NEW = "    return drv->que_push((QueFunc)drv->dma_chain, p - 2, 0x14, 0);\n"

HEAD = "    /* MATCH: PAYLOAD-ANCHOR POINTER (w51-a1, landed WITH the cc1_272 lane wiring).\n"
SEAL = (
    "    /* MATCH (W64-A3, SEALED 46/46) -- TWO landings, both mechanism-first.\n"
    "     * (1) THE FENCE POSITION WAS THE CFG (see the block at the fence below):\n"
    "     *     reorg's stop_search_p returns 1 at any asm, so the opacity fence at the\n"
    "     *     BODY-thread head starved guard2's target-thread steal.  9 -> 4, 46/46.\n"
    "     * (2) THE LAST 4 WERE A sched2 LUID TIE, not coloring: retail emits the src\n"
    "     *     word load `lw $a1,0($s0)` and THEN the driver-table load `lui/lw $a3`,\n"
    "     *     before `addiu $a2,$zero,0x14`.  Both are loads of equal priority, so\n"
    "     *     sched.c breaks the tie on LUID = RTL order = SOURCE order.  Naming the\n"
    "     *     two values (`srcxy` then `drv`, in that order, right after the anchor)\n"
    "     *     puts them in retail's order -> PASS.  Measured ladder in this basin:\n"
    "     *     nothing 4 * `drv` alone after the anchor 2 * `drv` after p[0]/p[1]/the\n"
    "     *     fence/p[2] 4 each * `GpuTbl *drv = GEnv_drv;` decl-init 35 (49 insns) *\n"
    "     *     a named `dc` for dma_chain only 14 * `srcxy` alone (no `drv`) 4 *\n"
    "     *     `drv` BEFORE `srcxy` 2 (the order IS the dial) * p[1]-store-before-p[0]\n"
    "     *     on top of `drv` 24 * a read-only fence on `drv` 9 (45 insns, loses the\n"
    "     *     reorg steal again -- an asm right after the anchor re-starves guard2).\n"
    "     * The historical falsification map below is kept as the record of what did NOT\n"
    "     * work; it was all aimed at a register handout that was in fact already right.\n"
    "     *\n"
    "     * MATCH: PAYLOAD-ANCHOR POINTER (w51-a1, landed WITH the cc1_272 lane wiring).\n"
)

for a, c in ((DECL, 1), (ANCHOR, 1), (S0, 1), (RET, 1), (HEAD, 1)):
    assert t.count(a) == c, "anchor count %d for %r" % (t.count(a), a[:60])
t2 = (t.replace(DECL, DECL_NEW).replace(ANCHOR, ANCHOR_NEW)
       .replace(S0, S0_NEW).replace(RET, RET_NEW).replace(HEAD, SEAL))
assert t2 != t
out = t2.encode("utf-8")
tmp = P.with_suffix(".c.w64a3tmp")
tmp.write_bytes(out)
os.replace(tmp, P)
print("landed; bytes %d -> %d" % (len(raw), len(out)))
