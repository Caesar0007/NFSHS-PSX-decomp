"""w63-a2 DEVICE LAB step 4 -- does the HOIST make `prim` a GLOBAL allocno with
a low enough priority to reach retail's $s3?  (The hoist was falsified in the
w61 receipt on DIFF COUNT alone, never on the allocno row.)"""
import sys
sys.path.insert(0, r"C:/Temp/nfs4-decomp/tools")
import fast

SRC = "recon/game/psx/draww.cpp"
FN = "DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss"
DUMPFN = "DrawW_SubdividFacet(struct"

DECL = b"    POLY_GT4 *prim;   /* SYM: REG $s3 */\n"
DECLH = b"    POLY_GT4 *prim = (POLY_GT4 *)(sd->head).cprim.PrimPtr;\n"
LOAD = b"    prim = (POLY_GT4 *)(sd->head).cprim.PrimPtr;\n"
F1 = b"    __asm__(\"\" : : \"r\"(sd));\n"
CALL = b"    DrawW_AddSubdividPrimGT4(prim,v0,v1,v2,v3,sd);\n    return;\n"
FENCE = (b"    DrawW_AddSubdividPrimGT4(prim,v0,v1,v2,v3,sd);\n"
         b"    __asm__(\"\" : : \"r\"(prim));\n    return;\n")

V = {
    "1_hoist":        [(DECL, DECLH), (LOAD, b"")],
    "2_hoist+f1":     [(DECL, DECLH), (LOAD, F1)],
    "3_hoist+tail":   [(DECL, DECLH), (LOAD, b""), (CALL, FENCE)],
}

fast.run(SRC, FN, DUMPFN, V, gval="4", minrefs=3)
