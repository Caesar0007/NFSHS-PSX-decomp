import sys, os
sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))), "tools"))
import fast

SRC = "recon/game/psx/draww.cpp"
FN = "DrawW_BuildSpikeBelt__FP13DRender_tViewiP11Draw_DCache"

OLD = (b"  { int t;\r\n"
       b"    t = (signed char)BWorldSm_slices[slice].forward[0]; t++; t--; fx = (u_short)(t >> 1);\r\n"
       b"    t = (signed char)BWorldSm_slices[slice].forward[1]; t++; t--; fy = (u_short)(t >> 1);\r\n"
       b"    t = (signed char)BWorldSm_slices[slice].forward[2]; t++; t--; fz = (u_short)(t >> 1); }\r\n")


def blk(body):
    return [(OLD, body)]


A = (b"  { int t;\r\n"
     b"    t = (signed char)BWorldSm_slices[slice].forward[0]; t++; t--; t >>= 1; fx = (u_short)t;\r\n"
     b"    t = (signed char)BWorldSm_slices[slice].forward[1]; t++; t--; t >>= 1; fy = (u_short)t;\r\n"
     b"    t = (signed char)BWorldSm_slices[slice].forward[2]; t++; t--; t >>= 1; fz = (u_short)t; }\r\n")

B = (b"  { int tx, ty, tz;\r\n"
     b"    tx = (signed char)BWorldSm_slices[slice].forward[0]; tx++; tx--; tx >>= 1; fx = (u_short)tx;\r\n"
     b"    ty = (signed char)BWorldSm_slices[slice].forward[1]; ty++; ty--; ty >>= 1; fy = (u_short)ty;\r\n"
     b"    tz = (signed char)BWorldSm_slices[slice].forward[2]; tz++; tz--; tz >>= 1; fz = (u_short)tz; }\r\n")

C = (b"  { int tx, ty, tz;\r\n"
     b"    tx = (signed char)BWorldSm_slices[slice].forward[0]; tx++; tx--;\r\n"
     b"    ty = (signed char)BWorldSm_slices[slice].forward[1]; ty++; ty--;\r\n"
     b"    tz = (signed char)BWorldSm_slices[slice].forward[2]; tz++; tz--;\r\n"
     b"    tx >>= 1; fx = (u_short)tx;\r\n"
     b"    ty >>= 1; fy = (u_short)ty;\r\n"
     b"    tz >>= 1; fz = (u_short)tz; }\r\n")

D = (b"  { int tx, ty, tz;\r\n"
     b"    tx = (signed char)BWorldSm_slices[slice].forward[0]; tx++; tx--;\r\n"
     b"    ty = (signed char)BWorldSm_slices[slice].forward[1]; ty++; ty--;\r\n"
     b"    tx >>= 1; fx = (u_short)tx;\r\n"
     b"    tz = (signed char)BWorldSm_slices[slice].forward[2]; tz++; tz--;\r\n"
     b"    ty >>= 1; fy = (u_short)ty;\r\n"
     b"    tz >>= 1; fz = (u_short)tz; }\r\n")

variants = {
    "A_one_temp_inplace": blk(A),
    "B_three_temps_inplace": blk(B),
    "C_loads_first_then_shifts": blk(C),
    "D_oracle_interleave": blk(D),
}
VARIANTS = variants

if __name__ == "__main__":
    fast.run(SRC, FN, "DrawW_BuildSpikeBelt", variants, gval="4", minrefs=4, dump=False)
