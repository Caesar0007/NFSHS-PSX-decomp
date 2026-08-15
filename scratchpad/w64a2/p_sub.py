import sys, os
sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))), "tools"))
import fast

SRC = "recon/game/psx/draww.cpp"
FN = "DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss"

RDIV = b"  Draw_SubdivStruct *r_div;   /* SYM: REG $s0, fn scope */"
V4DECL = b"    Draw_SVertex *v4;   /* SYM: REG $s3 */\r\n"
PRIMDECL = b"    POLY_GT4 *prim;   /* SYM: REG $s3 */\r\n"
PRIMSET = (b"    prim = (POLY_GT4 *)(sd->head).cprim.PrimPtr;\r\n"
           b"    /* OT-link, EA DMPSX-analog FIXED-REG TEMPLATE (fastmovf.c family")
ASMCALL = (b'        : : "r"(prim), "r"(sd), "r"(&sd->otz)\r\n'
           b'        : "$12", "$13", "$14", "memory");\r\n'
           b'    DrawW_AddSubdividPrimGT4(prim,v0,v1,v2,v3,sd);')

CARRIER = b"  Draw_SVertex *v4;   /* SYM: REG $s3 -- 12D staging carrier */"


def stage(first):
    return [
        (V4DECL, b""),
        (RDIV, (CARRIER + b"\r\n" + RDIV) if first else (RDIV + b"\r\n" + CARRIER)),
        (PRIMDECL, b""),
        (PRIMSET, b"    v4 = (Draw_SVertex *)(sd->head).cprim.PrimPtr;\r\n"
                  b"    /* OT-link, EA DMPSX-analog FIXED-REG TEMPLATE (fastmovf.c family"),
        (ASMCALL, b'        : : "r"(v4), "r"(sd), "r"(&sd->otz)\r\n'
                  b'        : "$12", "$13", "$14", "memory");\r\n'
                  b'    DrawW_AddSubdividPrimGT4((POLY_GT4 *)v4,v0,v1,v2,v3,sd);'),
    ]


variants = {
    "stage_v4_after_rdiv": stage(False),
    "stage_v4_first": stage(True),
}
VARIANTS = variants

if __name__ == "__main__":
    fast.run(SRC, FN, "DrawW_SubdividFacet", variants, gval="4", minrefs=3, dump=False)
