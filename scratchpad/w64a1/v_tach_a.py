TU = "recon/game/psx/hud.cpp"
FN = "Hud_BuildTach__Fi"

Y_OLD = ("  ((POLY_F3 *)prim2)->y1 = ((POLY_F3 *)prim2)->y1 + 2;\n"
         "  ((POLY_F3 *)prim2)->y0 = ((POLY_F3 *)prim2)->y0 + 2;\n")
Y_SWAP = ("  ((POLY_F3 *)prim2)->y0 = ((POLY_F3 *)prim2)->y0 + 2;\n"
          "  ((POLY_F3 *)prim2)->y1 = ((POLY_F3 *)prim2)->y1 + 2;\n")

F_OLD = "  __asm__ (\"\" : : \"r\"(ts1));\n"
F_2 = "  __asm__ (\"\" : : \"r\"(ts1), \"r\"(ts1));\n"
F_3 = "  __asm__ (\"\" : : \"r\"(ts1), \"r\"(ts1), \"r\"(ts1));\n"

C_OLD = ("  if (player != 0) {\n"
         "    clut = clut | (x + 0x75);\n"
         "  }\n"
         "  else {\n"
         "    clut = clut | (x + 0x1d);\n")
C_U1 = ("  xd = x + 0x1d;\n"
        "  if (player != 0) {\n"
        "    clut = clut | (xd + 0x58);\n"
        "  }\n"
        "  else {\n"
        "    clut = clut | xd;\n")
C_U2 = ("  xd = x + 0x1d;\n"
        "  if (player != 0) {\n"
        "    clut = clut | (x + 0x75);\n"
        "  }\n"
        "  else {\n"
        "    clut = clut | xd;\n")
DECL_OLD = "  clut = *(u_long *)tachNeedle_p;\n"
DECL_NEW = "  int xd;\n\n  clut = *(u_long *)tachNeedle_p;\n"

VARIANTS = [
    ("CONTROL", []),
    ("T1 y0 before y1", [(Y_OLD, Y_SWAP, 1)]),
    ("T2 fence 2 operands", [(F_OLD, F_2, 1)]),
    ("T3 fence 3 operands", [(F_OLD, F_3, 1)]),
    ("T4 T1+T2", [(Y_OLD, Y_SWAP, 1), (F_OLD, F_2, 1)]),
    ("U1 xd used both arms", [(DECL_OLD, DECL_NEW, 1), (C_OLD, C_U1, 1)]),
    ("U2 xd else-arm only", [(DECL_OLD, DECL_NEW, 1), (C_OLD, C_U2, 1)]),
]
