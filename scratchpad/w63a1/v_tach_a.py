TU = "recon/game/psx/hud.cpp"
FN = "Hud_BuildTach__Fi"

# offset -> POLY_F3 member
M = {"0xc": "x1", "0xe": "y1", "0x10": "x2", "0x12": "y2", "10": "y0", "8": "x0"}


def s(p, off, rhs):
    return "  *(short *)(%s + %s) = %s;\n" % (p, off, rhs)


def f(p, off, rhs):
    return "  ((POLY_F3 *)%s)->%s = %s;\n" % (p, M[off], rhs)


GROUP = [("prim", "0xc", "ts3"), ("prim2", "0xc", "ts3"),
         ("prim", "0xe", "ts4"), ("prim2", "0xe", "ts4"),
         ("prim", "0x10", "ts1"), ("prim2", "0x10", "ts1"),
         ("prim", "0x12", "ts1"), ("prim2", "0x12", "ts1")]

TAIL = [
    ("  *(short *)(prim2 + 0xe) = *(short *)(prim2 + 0xe) + 2;\n",
     "  ((POLY_F3 *)prim2)->y1 = ((POLY_F3 *)prim2)->y1 + 2;\n", 1),
    ("  *(short *)(prim2 + 10) = *(short *)(prim2 + 10) + 2;\n",
     "  ((POLY_F3 *)prim2)->y0 = ((POLY_F3 *)prim2)->y0 + 2;\n", 1),
    ("  *(short *)(prim2 + 0x12) = ts1 + 2;\n",
     "  ((POLY_F3 *)prim2)->y2 = ts1 + 2;\n", 1),
]

GRP_EDITS = [(s(p, o, r), f(p, o, r), 1) for (p, o, r) in GROUP]
PRIM_ONLY = [(s(p, o, r), f(p, o, r), 1) for (p, o, r) in GROUP if p == "prim"]

VARIANTS = [
    ("control", []),
    ("POLY_F3 fields: vertex group", GRP_EDITS),
    ("POLY_F3 fields: vertex group + tail", GRP_EDITS + TAIL),
    ("POLY_F3 fields: prim only", PRIM_ONLY),
    ("POLY_F3 fields: tail only", TAIL),
]
