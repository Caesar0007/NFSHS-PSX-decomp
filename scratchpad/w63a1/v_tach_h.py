TU = "recon/game/psx/hud.cpp"
FN = "Hud_BuildTach__Fi"

Y2P = "  ((POLY_F3 *)prim2)->y2 = ts1 + 2;\n"
F1 = '  __asm__ ("" : : "r"(ts1));\n'
F2 = '  __asm__ ("" : : "r"(ts1), "r"(ts1));\n'
TP3 = "  tp3 = Render_gPalettePtr;\n"
LINK = "  ((Hud_PTag *)&gSprt1[2])->addr = ((Hud_PTag *)tp3)->addr;\n"

VARIANTS = [
    ("control", []),
    ("fence-1 after y2+2", [(Y2P, Y2P + F1, 1)]),
    ("fence-2 after y2+2", [(Y2P, Y2P + F2, 1)]),
    ("fence-1 before the link block", [(LINK, F1 + LINK, 1)]),
    ("fence-1 right before y2+2", [(Y2P, F1 + Y2P, 1)]),
    ("fence-1 after tp3", [(TP3, TP3 + F1, 1)]),
]
