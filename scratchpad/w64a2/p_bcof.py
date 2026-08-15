import sys, os
sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))), "tools"))
import fast

SRC = "recon/game/psx/draww.cpp"
FN = "DrawW_BuildCustomObjectFacets__FP13DRender_tViewP11Draw_DCacheP13Trk_SimObjectP5Groupi"

SIG_OLD = b"int DrawW_BuildCustomObjectFacets(DRender_tView *Vi,Draw_DCache *sd,Trk_SimObject *simObjs,Group *group,int zClipSq)"
SIG_NEW = b"int DrawW_BuildCustomObjectFacets(DRender_tView *Vi_a,Draw_DCache *sd_a,Trk_SimObject *simObjs_a,Group *group,int zClipSq)"

DECL_OLD = b"  Trk_CollideBoomInst * objCollideBoomInstance;\n"
INIT_OLD = b"  groupBase_p = (int)(group + 1);\n"


def V(decls, inits):
    return [(SIG_OLD, SIG_NEW),
            (DECL_OLD, decls.encode() + DECL_OLD),
            (INIT_OLD, inits.encode() + INIT_OLD)]


D3 = "  DRender_tView *Vi;\n  Draw_DCache *sd;\n  Trk_SimObject *simObjs;\n"

variants = {
    "base": (b"@@nosuch@@", b"x"),
    "copy3_order_123": V(D3, "  Vi = Vi_a;\n  sd = sd_a;\n  simObjs = simObjs_a;\n"),
    "copy3_order_321": V(D3, "  simObjs = simObjs_a;\n  sd = sd_a;\n  Vi = Vi_a;\n"),
    "copy3_order_231": V(D3, "  sd = sd_a;\n  simObjs = simObjs_a;\n  Vi = Vi_a;\n"),
    "copy_sd_only": V("  Draw_DCache *sd;\n", "  sd = sd_a;\n"),
}
# fix up the sd-only variant: it must not rename Vi/simObjs
variants["copy_sd_only"] = [
    (SIG_OLD, b"int DrawW_BuildCustomObjectFacets(DRender_tView *Vi,Draw_DCache *sd_a,Trk_SimObject *simObjs,Group *group,int zClipSq)"),
    (DECL_OLD, b"  Draw_DCache *sd;\n" + DECL_OLD),
    (INIT_OLD, b"  sd = sd_a;\n" + INIT_OLD),
]

fast.run(SRC, FN, "DrawW_BuildCustomObjectFacets", variants, gval="4", minrefs=3, dump=False)
