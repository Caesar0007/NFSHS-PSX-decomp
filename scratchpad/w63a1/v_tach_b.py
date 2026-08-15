TU = "recon/game/psx/hud.cpp"
FN = "Hud_BuildTach__Fi"

M = {"0xc": "x1", "0xe": "y1", "0x10": "x2", "0x12": "y2", "10": "y0", "8": "x0"}


def s(p, off, rhs):
    return "  *(short *)(%s + %s) = %s;\n" % (p, off, rhs)


def f(p, off, rhs):
    return "  ((POLY_F3 *)%s)->%s = %s;\n" % (p, M[off], rhs)


GROUP = [("prim", "0xc", "ts3"), ("prim2", "0xc", "ts3"),
         ("prim", "0xe", "ts4"), ("prim2", "0xe", "ts4"),
         ("prim", "0x10", "ts1"), ("prim2", "0x10", "ts1"),
         ("prim", "0x12", "ts1"), ("prim2", "0x12", "ts1")]
GRP = [(s(p, o, r), f(p, o, r), 1) for (p, o, r) in GROUP]

TAIL = [
    ("  *(short *)(prim2 + 0xe) = *(short *)(prim2 + 0xe) + 2;\n",
     "  ((POLY_F3 *)prim2)->y1 = ((POLY_F3 *)prim2)->y1 + 2;\n", 1),
    ("  *(short *)(prim2 + 10) = *(short *)(prim2 + 10) + 2;\n",
     "  ((POLY_F3 *)prim2)->y0 = ((POLY_F3 *)prim2)->y0 + 2;\n", 1),
    ("  *(short *)(prim2 + 0x12) = ts1 + 2;\n",
     "  ((POLY_F3 *)prim2)->y2 = ts1 + 2;\n", 1),
]

TP9_XY = [
    ("    *(short *)((u_char *)tp9 + 8) = 0xe - (short)x;\n",
     "    ((POLY_F3 *)tp9)->x0 = 0xe - (short)x;\n", 1),
    ("    *(short *)((u_char *)tp9 + 10) = 0xe - (short)y;\n",
     "    ((POLY_F3 *)tp9)->y0 = 0xe - (short)y;\n", 1),
    ("    *(short *)((u_char *)tp9 + 0xe) = (short)sin1;\n",
     "    ((POLY_F3 *)tp9)->y1 = (short)sin1;\n", 1),
    ("    *(u_short *)((u_char *)tp9 + 0xc) = (u_short)cos1;\n",
     "    ((POLY_F3 *)tp9)->x1 = (u_short)cos1;\n", 1),
]
TP9_CODE = [("    ((u_char *)tp9)[3] = 3;\n", "    ((POLY_F3 *)tp9)->code = 3;\n", 1)]
TP9_RGB = [("    *(u_long *)((u_char *)tp9 + 4) = color + 0x484848 | 0x42000000;\n",
            "    *(u_long *)&((POLY_F3 *)tp9)->r0 = color + 0x484848 | 0x42000000;\n", 1)]
PRIMCODE = [("  prim[7] = prim[7] & 0xfd;\n",
             "  ((POLY_F3 *)prim)->code = ((POLY_F3 *)prim)->code & 0xfd;\n", 1)]

BASE = GRP + TAIL

VARIANTS = [
    ("control", []),
    ("BASE (grp+tail)", BASE),
    ("BASE + tp9 xy", BASE + TP9_XY),
    ("BASE + tp9 xy + code", BASE + TP9_XY + TP9_CODE),
    ("BASE + tp9 xy + code + rgb", BASE + TP9_XY + TP9_CODE + TP9_RGB),
    ("BASE + tp9 all + prim code", BASE + TP9_XY + TP9_CODE + TP9_RGB + PRIMCODE),
    ("BASE + prim code", BASE + PRIMCODE),
]
