"""w63-a2 DEVICE LAB step 2 -- SubdividFacet `prim`.

FINDING FROM lab1: prim is p383, a BLOCK-LOCAL qty in block 62 (base refs=3
live=3 -> $a0; +tail read fence refs=4 live=10 -> $s0).  The w62-a2 receipt's
p90 (refs 6 / live 54 / GLOBAL / $s0) is a DIFFERENT pseudo -- its row is
identical in both variants, so the whole "prim must fall below p187's .1274"
razor was aimed at the wrong allocno.

local-alloc.c:2204-2215 find_free_reg: for a call-crossing qty `used` starts as
call_used_reg_set and then ORs regs_live_at[] over the qty's span -- only HARD
regs.  Nothing in block 62 holds $s0/$s1/$s2, so a block-local prim can ONLY be
$s0.  => retail's prim was a GLOBAL allocno.  This batch probes promotion.
"""
import sys
sys.path.insert(0, r"C:/Temp/nfs4-decomp/tools")
import fast

SRC = "recon/game/psx/draww.cpp"
FN = "DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss"
DUMPFN = "DrawW_SubdividFacet(struct"

LOAD = b"    prim = (POLY_GT4 *)(sd->head).cprim.PrimPtr;\n"
CALL = b"    DrawW_AddSubdividPrimGT4(prim,v0,v1,v2,v3,sd);\n    return;\n"
FENCE = (b"    DrawW_AddSubdividPrimGT4(prim,v0,v1,v2,v3,sd);\n"
         b"    __asm__(\"\" : : \"r\"(prim));\n    return;\n")
IDL = LOAD + b"    __asm__(\"\" : \"=r\"(prim) : \"0\"(prim));\n"

V = {
    "1_fence(ctl)": (CALL, FENCE),
    "2_idlaunder": (LOAD, IDL),
    "3_idl+fence": [(LOAD, IDL), (CALL, FENCE)],
    "4_idl_x2": (LOAD, IDL + b"    __asm__(\"\" : \"=r\"(prim) : \"0\"(prim));\n"),
}

fast.run(SRC, FN, DUMPFN, V, gval="4", minrefs=3)
