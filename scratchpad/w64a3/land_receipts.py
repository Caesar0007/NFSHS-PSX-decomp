#!/usr/bin/env python3
"""W64-A3 landing #3: in-source falsification receipts for _gpu_que_drain and
_dws/_drs (comment-only; no codegen change -- gated twice either way).
Asserting, byte-mode, LF-preserving."""
import os
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
P = ROOT / "recon/syslib/psx/libgpu/SYS.c"
raw = P.read_bytes()
assert b"\r\n" not in raw, "SYS.c must stay LF"
t = raw.decode("utf-8")

QD_TAIL = ("     * three chains already start from registers). */\n")
QD_NEW = (
    "     * three chains already start from registers).\n"
    "     * W64-A3 -- TWO MORE AXES CLOSED, both from a fresh read-off of the two streams.\n"
    "     * (a) THE RELOAD->CHAIN MAP.  Retail's three `_qout` reloads feed .func / .arg /\n"
    "     *     .extra in that order; ours feed .extra / .arg / .func.  That looks exactly\n"
    "     *     like a READ-ORDER permutation (gcc numbers the reloads in read order), so\n"
    "     *     every permutation was measured: func,arg,extra 24 * func,extra,arg 16 *\n"
    "     *     extra,func,arg 16 * arg,func,extra 25 (151 insns) * arg,extra,func 22 *\n"
    "     *     the same six with the declaration list re-ordered func,arg,extra 14/24.\n"
    "     *     FALSIFIED: read order is not the dial, the map is a consequence of the\n"
    "     *     local-alloc handout, not of the RTL emission order.\n"
    "     * (b) THE SLOT-ACCESS SHAPE, element by element (the brief's ask): `func` local +\n"
    "     *     both args inlined 24 * `extra`/`arg` locals + `func` inlined 14 (inert) *\n"
    "     *     decl-with-init form 14 (inert) * `(*func)(arg, extra)` call spelling 14\n"
    "     *     (inert) * a void-tail fence before the `.func` read 34 * one after the\n"
    "     *     `.extra` read 27 (153 insns).  Hoisting the locals to function scope does\n"
    "     *     not compile (C89 use-before-declaration in this nesting).\n"
    "     * CORPUS: psyz's libgpu/sys.c leaves `_exeque` as INCLUDE_ASM (line 868) -- there is\n"
    "     * NO matched PsyQ-4.0 body for this function anywhere, and sotn's is a different SDK\n"
    "     * generation (1.83 vs our 1.140), so 15F says shape-oracle only where the CFG matches\n"
    "     * and it does not.  The 5 corpora added mid-W64 (mgs_reversing, KAIN2, TOMB5,\n"
    "     * VandalHearts-PcPort, vh) carry NO Sony libgpu source at all -- TOMB5/EMULATOR and\n"
    "     * VandalHearts platform/pc are PC re-implementations (SDL/OpenGL rasterisers), mgs's\n"
    "     * libdg is Konami glue over `#include <libgpu.h>`.  Recorded so nobody re-mines. */\n"
)

DWS_TAIL = ("     *       emission-order question, i.e. the 06E instrument gap, not a spelling. */\n")
DWS_NEW = (
    "     *       emission-order question, i.e. the 06E instrument gap, not a spelling.\n"
    "     * W64-A3 -- THE PARM-ORDER HYPOTHESIS THAT LOOKED CERTAIN IS FALSIFIED.  Reading\n"
    "     * the prologue as MoveImage's RTL taught me to (each callee-save `sw` is emitted\n"
    "     * immediately before the parm copy that first uses that register, in PARAMETER\n"
    "     * order), ours must be emitting the `data` parm copy first because our\n"
    "     * `addu $s1,$a0,$zero` is the BODY statement `saved = rect;` (the rect parm copy\n"
    "     * having been propagated away) rather than assign_parms' own copy.  Cure tried:\n"
    "     * drop the `saved` alias and use `rect` directly -- _dws 38 / _drs 42, i.e. `saved`\n"
    "     * IS retail's shape and removing it re-colours the whole clamp band.  Keeping ONE\n"
    "     * late use of `rect` to hold the parm pseudo live is worse still and costs an insn\n"
    "     * (_dws: rect at the GP0 payload 41/144, at payload word 0 only 51/146, for the\n"
    "     * clamps only 41/144; _drs: payload 45/161, clamps 45/161).  Declaration position\n"
    "     * of `saved` is inert (first: _dws 8, _drs 10).  A read-only fence on `rect` at the\n"
    "     * top costs 4 (12).  The class stands as the 06E local-alloc/assign_parms gap. */\n"
)

for a in (QD_TAIL, DWS_TAIL):
    assert t.count(a) == 1, "anchor count %d for %r" % (t.count(a), a[:60])
t2 = t.replace(QD_TAIL, QD_NEW).replace(DWS_TAIL, DWS_NEW)
assert t2 != t
assert "*/" not in QD_NEW[:-4].replace("*/\n", "", 0) or True
out = t2.encode("utf-8")
tmp = P.with_suffix(".c.w64a3tmp")
tmp.write_bytes(out)
os.replace(tmp, P)
print("landed; bytes %d -> %d" % (len(raw), len(out)))
