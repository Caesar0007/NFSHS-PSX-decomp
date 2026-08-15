TU = "recon/game/psx/hud.cpp"
FN = "Hud_BuildTach__Fi"

X0 = "    *(short *)((u_char *)tp9 + 8) = 0xe - (short)x;\n"
RGB = "    *(u_long *)((u_char *)tp9 + 4) = color + 0x484848 | 0x42000000;\n"
Y0 = "    *(short *)((u_char *)tp9 + 10) = 0xe - (short)y;\n"
Y1 = "    *(short *)((u_char *)tp9 + 0xe) = (short)sin1;\n"
X1 = "    *(u_short *)((u_char *)tp9 + 0xc) = (u_short)cos1;\n"
BLOCK = X0 + RGB + Y0 + Y1 + X1
VF = '    __asm__ ("" : : "i"(0));\n'

N = {"x0": X0, "rgb": RGB, "y0": Y0, "y1": Y1, "x1": X1, "vf": VF}


def o(*k):
    return [(BLOCK, "".join(N[i] for i in k), 1)]


VARIANTS = [
    ("control x0,rgb,y0,y1,x1", []),
    ("vf after rgb", o("x0", "rgb", "vf", "y0", "y1", "x1")),
    ("vf after y0", o("x0", "rgb", "y0", "vf", "y1", "x1")),
    ("vf after x0", o("x0", "vf", "rgb", "y0", "y1", "x1")),
    ("vf after y1", o("x0", "rgb", "y0", "y1", "vf", "x1")),
    ("order x0,y0,rgb,y1,x1", o("x0", "y0", "rgb", "y1", "x1")),
    ("order rgb,x0,y0,y1,x1", o("rgb", "x0", "y0", "y1", "x1")),
    ("order x0,rgb,y0,x1,y1", o("x0", "rgb", "y0", "x1", "y1")),
    ("order x0,y0,y1,x1,rgb", o("x0", "y0", "y1", "x1", "rgb")),
    ("tp9 y1 as POLY_F3 member",
     [(Y1, "    ((POLY_F3 *)tp9)->y1 = (short)sin1;\n", 1)]),
    ("tp9 y1+x1 as POLY_F3 members",
     [(Y1, "    ((POLY_F3 *)tp9)->y1 = (short)sin1;\n", 1),
      (X1, "    ((POLY_F3 *)tp9)->x1 = (u_short)cos1;\n", 1)]),
]
