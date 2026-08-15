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

# retail keeps TWO index temps alive SIMULTANEOUSLY (v1 = n1+1 is born before
# v0 = n1+2 is consumed) -- that is what blocks BOTH $v0 and $v1 over n1's
# window so the ascending find_free_reg scan hands n1 the next free reg, $a3.
G = (b"    v4 = &r_div->v[n];\r\n"
     b"    n = n + 1;\r\n"
     b"    {\r\n"
     b"      short i1 = n + 1;\r\n"
     b"      short i2;\r\n"
     b"      v5 = &r_div->v[n];\r\n"
     b"      i2 = n + 2;\r\n"
     b"      v6 = &r_div->v[i1];\r\n"
     b"      v7 = &r_div->v[i2];\r\n"
     b"      v8 = &r_div->v[(short)(n + 3)];\r\n"
     b"    }\r\n"
     b"    n = n + 4;\r\n")

H = (b"    v4 = &r_div->v[n];\r\n"
     b"    n = n + 1;\r\n"
     b"    {\r\n"
     b"      short i1 = n + 1;\r\n"
     b"      short i2;\r\n"
     b"      v5 = &r_div->v[n];\r\n"
     b"      i2 = n + 2;\r\n"
     b"      v6 = &r_div->v[i1];\r\n"
     b"      n = n + 3;\r\n"
     b"      v7 = &r_div->v[i2];\r\n"
     b"      v8 = &r_div->v[n];\r\n"
     b"    }\r\n"
     b"    n = n + 1;\r\n")

I = (b"    v4 = &r_div->v[n];\r\n"
     b"    n = n + 1;\r\n"
     b"    {\r\n"
     b"      short i1 = n + 1;\r\n"
     b"      short i2 = n + 2;\r\n"
     b"      v5 = &r_div->v[n];\r\n"
     b"      v6 = &r_div->v[i1];\r\n"
     b"      v7 = &r_div->v[i2];\r\n"
     b"      v8 = &r_div->v[(short)(n + 3)];\r\n"
     b"    }\r\n"
     b"    n = n + 4;\r\n")

variants = {"G_pipelined": [(OLD, G)],
            "H_pipelined_inplace_v8": [(OLD, H)],
            "I_both_temps_upfront": [(OLD, I)]}
VARIANTS = variants

if __name__ == "__main__":
    fast.run(SRC, FN, "DrawW_SubdividFacet", variants, gval="4", minrefs=4, dump=False)
