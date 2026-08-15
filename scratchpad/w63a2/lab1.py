"""w63-a2 DEVICE LAB step 1: reproduce the w61-a2 fence basin on
DrawW_SubdividFacet and read prim's allocno row off the REAL CC1PLPSX."""
import sys, os
sys.path.insert(0, r"C:/Temp/nfs4-decomp/tools")
import fast

SRC = "recon/game/psx/draww.cpp"
FN = "DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss"

CALL = b"    DrawW_AddSubdividPrimGT4(prim,v0,v1,v2,v3,sd);\n    return;\n"

V = {
    "base": (CALL, CALL),
    "fence": (CALL,
              b"    DrawW_AddSubdividPrimGT4(prim,v0,v1,v2,v3,sd);\n"
              b"    __asm__(\"\" : : \"r\"(prim));\n    return;\n"),
}

DUMPFN = "DrawW_SubdividFacet(struct"

fast.run(SRC, FN, DUMPFN, V, gval="4", minrefs=3)
