import sys, os
sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))), "tools"))
import fast

SRC = "recon/game/psx/draww.cpp"
FN = "DrawW_BuildSpikeBelt__FP13DRender_tViewiP11Draw_DCache"
F = b"(signed char)BWorldSm_slices[slice].forward"

OLD = (b"  { int t;\r\n"
       b"    t = " + F + b"[0]; t++; t--; fx = (u_short)(t >> 1);\r\n"
       b"    t = " + F + b"[1]; t++; t--; fy = (u_short)(t >> 1);\r\n"
       b"    t = " + F + b"[2]; t++; t--; fz = (u_short)(t >> 1); }\r\n")

def two(a, b_, c):
    return (b"  { int t; int u;\r\n"
            b"    " + a + b" = " + F + b"[0]; " + a + b"++; " + a + b"--; fx = (u_short)(" + a + b" >> 1);\r\n"
            b"    " + b_ + b" = " + F + b"[1]; " + b_ + b"++; " + b_ + b"--; fy = (u_short)(" + b_ + b" >> 1);\r\n"
            b"    " + c + b" = " + F + b"[2]; " + c + b"++; " + c + b"--; fz = (u_short)(" + c + b" >> 1); }\r\n")

variants = {
  "S1_t_u_t": [(OLD, two(b"t", b"u", b"t"))],
  "S2_t_t_u": [(OLD, two(b"t", b"t", b"u"))],
  "S3_u_t_t": [(OLD, two(b"u", b"t", b"t"))],
}
VARIANTS = variants
if __name__ == "__main__":
    fast.run(SRC, FN, "DrawW_BuildSpikeBelt", variants, gval="4", minrefs=4, dump=False)
