"""w63-a2 DEVICE LAB step 3 -- validate THE FOREIGN-OPERAND FENCE as a
zero-insn, zero-own-ref live-range EXTENDER.

flow.c:1399 (`else if (GET_RTX_CLASS (GET_CODE (insn)) == 'i')`) encloses the
REG_LIVE_LENGTH++ at flow.c:1594 => live length counts REAL RTL INSNS ONLY
(NOTE_INSN_BLOCK_*/LOOP_* do NOT count -- that kills the block-scope and
do{}while(0) routes for LIVE, they only move refs).  An empty `__asm__` IS a
class-'i' insn that assembles to ZERO bytes, so it adds +1 to the live length
of EVERY pseudo live across it while adding a ref only to ITS OWN operands.
=> put the fence's operand on a DIFFERENT variable and the target gets
   +1 live / +0 refs / +0 insns.

Witness: DrawW_SubdividFacet's `prim` (p383, block 62, base refs=3 live=3).
"""
import sys
sys.path.insert(0, r"C:/Temp/nfs4-decomp/tools")
import fast

SRC = "recon/game/psx/draww.cpp"
FN = "DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss"
DUMPFN = "DrawW_SubdividFacet(struct"

LOAD = b"    prim = (POLY_GT4 *)(sd->head).cprim.PrimPtr;\n"
F1 = b"    __asm__(\"\" : : \"r\"(sd));\n"

V = {
    "0_base": (LOAD, LOAD),
    "1_fgn1": (LOAD, LOAD + F1),
    "2_fgn3": (LOAD, LOAD + F1 * 3),
    "3_fgn6": (LOAD, LOAD + F1 * 6),
}

fast.run(SRC, FN, DUMPFN, V, gval="4", minrefs=3)
