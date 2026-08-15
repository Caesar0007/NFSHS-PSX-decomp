TU = "recon/game/psx/hud.cpp"
FN = "Hud_BuildTach__Fi"

X0 = "    *(short *)((u_char *)tp9 + 8) = 0xe - (short)x;\n"
RGB = "    *(u_long *)((u_char *)tp9 + 4) = color + 0x484848 | 0x42000000;\n"
Y0 = "    *(short *)((u_char *)tp9 + 10) = 0xe - (short)y;\n"
Y1 = "    *(short *)((u_char *)tp9 + 0xe) = (short)sin1;\n"
X1 = "    *(u_short *)((u_char *)tp9 + 0xc) = (u_short)cos1;\n"
CODE = "    ((u_char *)tp9)[3] = 3;\n"
BLOCK = CODE + X0 + RGB + Y0 + Y1 + X1

N = {"x0": X0, "rgb": RGB, "y0": Y0, "y1": Y1, "x1": X1, "code": CODE}


def o(*k):
    return [(BLOCK, "".join(N[i] for i in k), 1)]


VARIANTS = [
    ("control code,x0,rgb,y0,y1,x1", []),
    ("code,rgb,x0,y0,y1,x1", o("code", "rgb", "x0", "y0", "y1", "x1")),
    ("rgb,code,x0,y0,y1,x1", o("rgb", "code", "x0", "y0", "y1", "x1")),
    ("code,rgb,x0,y0,x1,y1", o("code", "rgb", "x0", "y0", "x1", "y1")),
    ("code,rgb,y0,x0,y1,x1", o("code", "rgb", "y0", "x0", "y1", "x1")),
    ("code,rgb,x0,y1,y0,x1", o("code", "rgb", "x0", "y1", "y0", "x1")),
    ("code,rgb,x0,x1,y0,y1", o("code", "rgb", "x0", "x1", "y0", "y1")),
    ("code,rgb,x1,y1,x0,y0", o("code", "rgb", "x1", "y1", "x0", "y0")),
    ("rgb,x0,y0,y1,x1,code", o("rgb", "x0", "y0", "y1", "x1", "code")),
    ("code,x0,y0,rgb,y1,x1", o("code", "x0", "y0", "rgb", "y1", "x1")),
]
