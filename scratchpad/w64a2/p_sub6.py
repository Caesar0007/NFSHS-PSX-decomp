import sys, os
sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))), "tools"))
import fast

SRC = "recon/game/psx/draww.cpp"
FN = "DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss"

HEAD = b"    v4 = &r_div->v[n];\r\n    n = n + 1;\r\n"
CHAIN = (b"      short q = n + 1;\r\n"
         b"      v5 = &r_div->v[n];\r\n"
         b"      v6 = &r_div->v[q];\r\n"
         b"      v7 = &r_div->v[(short)(q + 1)];\r\n"
         b"      v8 = &r_div->v[(short)(q + 2)];\r\n")

P1 = b"    v4 = &r_div->v[n++];\r\n"
P2 = b"    { short i0 = n; n = n + 1; v4 = &r_div->v[i0]; }\r\n"
P3 = (b"      short q = n + 1;\r\n"
      b"      short q1;\r\n"
      b"      v5 = &r_div->v[n];\r\n"
      b"      q1 = q + 1;\r\n"
      b"      v6 = &r_div->v[q];\r\n"
      b"      v7 = &r_div->v[q1];\r\n"
      b"      v8 = &r_div->v[(short)(q1 + 1)];\r\n")

variants = {
    "P1_postinc": [(HEAD, P1)],
    "P2_i0_temp": [(HEAD, P2)],
    "P3_pipelined_q1": [(CHAIN, P3)],
    "P4_both": [(HEAD, P1), (CHAIN, P3)],
}
VARIANTS = variants

if __name__ == "__main__":
    fast.run(SRC, FN, "DrawW_SubdividFacet", variants, gval="4", minrefs=4, dump=False)
