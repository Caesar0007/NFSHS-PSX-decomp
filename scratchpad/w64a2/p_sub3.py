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

# (b) retail's own dependency graph: n1 kept, the NEW n computed early off n1,
#     v8's index taken by MUTATING n1 in place (retail's `addiu a3,a3,3`).
B = (b"    v4 = &r_div->v[n];\r\n"
     b"    {\r\n"
     b"      short n1 = n + 1;\r\n"
     b"      n = n1 + 4;\r\n"
     b"      v5 = &r_div->v[n1];\r\n"
     b"      v6 = &r_div->v[(short)(n1 + 1)];\r\n"
     b"      v7 = &r_div->v[(short)(n1 + 2)];\r\n"
     b"      n1 = n1 + 3;\r\n"
     b"      v8 = &r_div->v[n1];\r\n"
     b"    }\r\n")

# (c) same but n1 NOT mutated (v8 from n1+3)
C = (b"    v4 = &r_div->v[n];\r\n"
     b"    {\r\n"
     b"      short n1 = n + 1;\r\n"
     b"      n = n1 + 4;\r\n"
     b"      v5 = &r_div->v[n1];\r\n"
     b"      v6 = &r_div->v[(short)(n1 + 1)];\r\n"
     b"      v7 = &r_div->v[(short)(n1 + 2)];\r\n"
     b"      v8 = &r_div->v[(short)(n1 + 3)];\r\n"
     b"    }\r\n")

# (d) 3<->4 qty boundary: one extra genuinely-distinct block temp
D = (b"    v4 = &r_div->v[n];\r\n"
     b"    n = n + 1;\r\n"
     b"    {\r\n"
     b"      short q = n + 2;\r\n"
     b"      v5 = &r_div->v[n];\r\n"
     b"      v6 = &r_div->v[(short)(n + 1)];\r\n"
     b"      v7 = &r_div->v[q];\r\n"
     b"      v8 = &r_div->v[(short)(q + 1)];\r\n"
     b"    }\r\n"
     b"    n = n + 4;\r\n")

variants = {}
for tag, body in (("B_n1_mutated", B), ("C_n1_plain", C), ("D_extra_qty", D)):
    variants[tag] = [(OLD, body)]
# (e) foreign-operand fences INSIDE the chain to demote n1's qty
for n in (1, 2, 3):
    ops = b", ".join([b'"r"(r_div)'] * n)
    variants["E_fence%d" % n] = [(OLD, OLD.replace(
        b"    v5 = &r_div->v[n];\r\n",
        b'    __asm__("" : : ' + ops + b');\r\n    v5 = &r_div->v[n];\r\n'))]
VARIANTS = variants

if __name__ == "__main__":
    fast.run(SRC, FN, "DrawW_SubdividFacet", variants, gval="4", minrefs=4, dump=False)
