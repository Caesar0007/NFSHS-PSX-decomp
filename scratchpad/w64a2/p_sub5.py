import sys, os
sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))), "tools"))
import fast

SRC = "recon/game/psx/draww.cpp"
FN = "DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss"

OLD = (b"    v4 = &r_div->v[n];\r\n"
       b"    n = n + 1;\r\n"
       b"    v5 = &r_div->v[n];\r\n"
       b"    v6 = &r_div->v[(short)(n + 1)];\r\n"
       b"    v7 = &r_div->v[(short)(n + 2)];\r\n"
       b"    v8 = &r_div->v[(short)(n + 3)];\r\n"
       b"    n = n + 4;\r\n")

def mk(inner):
    return (b"    v4 = &r_div->v[n];\r\n    n = n + 1;\r\n    {\r\n"
            + inner + b"    }\r\n    n = n + 4;\r\n")

D1 = mk(b"      short q = n + 2;\r\n"
        b"      v5 = &r_div->v[n];\r\n"
        b"      v6 = &r_div->v[(short)(n + 1)];\r\n"
        b"      v7 = &r_div->v[q];\r\n"
        b"      v8 = &r_div->v[(short)(q + 1)];\r\n")
D2 = mk(b"      short q = n + 1;\r\n"
        b"      v5 = &r_div->v[n];\r\n"
        b"      v6 = &r_div->v[q];\r\n"
        b"      v7 = &r_div->v[(short)(q + 1)];\r\n"
        b"      v8 = &r_div->v[(short)(q + 2)];\r\n")
D3 = mk(b"      short q = n + 2;\r\n"
        b"      short p = n + 3;\r\n"
        b"      v5 = &r_div->v[n];\r\n"
        b"      v6 = &r_div->v[(short)(n + 1)];\r\n"
        b"      v7 = &r_div->v[q];\r\n"
        b"      v8 = &r_div->v[p];\r\n")
D4 = mk(b"      short q = n + 2;\r\n"
        b"      v5 = &r_div->v[n];\r\n"
        b"      v6 = &r_div->v[(short)(n + 1)];\r\n"
        b"      v7 = &r_div->v[q];\r\n"
        b"      q = q + 1;\r\n"
        b"      v8 = &r_div->v[q];\r\n")

variants = {"D1_q_n2": [(OLD, D1)], "D2_q_n1": [(OLD, D2)],
            "D3_two_extra": [(OLD, D3)], "D4_q_mutated": [(OLD, D4)]}
VARIANTS = variants

if __name__ == "__main__":
    fast.run(SRC, FN, "DrawW_SubdividFacet", variants, gval="4", minrefs=4, dump=False)
