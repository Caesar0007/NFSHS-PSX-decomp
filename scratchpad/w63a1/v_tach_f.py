TU = "recon/game/psx/hud.cpp"
FN = "Hud_BuildTach__Fi"

TP3 = "  tp3 = Render_gPalettePtr;\n"
Y1 = "  ((POLY_F3 *)prim2)->y1 = ((POLY_F3 *)prim2)->y1 + 2;\n"
Y0 = "  ((POLY_F3 *)prim2)->y0 = ((POLY_F3 *)prim2)->y0 + 2;\n"
Y2 = "  ((POLY_F3 *)prim2)->y2 = ts1 + 2;\n"
BLOCK = TP3 + Y1 + Y0 + Y2
N = {"tp3": TP3, "y0": Y0, "y1": Y1, "y2": Y2}


def o(*k):
    return [(BLOCK, "".join(N[i] for i in k), 1)]


VARIANTS = [
    ("control tp3,y1,y0,y2", []),
    ("tp3,y0,y1,y2", o("tp3", "y0", "y1", "y2")),
    ("y0,y1,y2,tp3", o("y0", "y1", "y2", "tp3")),
    ("y0,tp3,y1,y2", o("y0", "tp3", "y1", "y2")),
    ("y0,y1,tp3,y2", o("y0", "y1", "tp3", "y2")),
    ("y0,y2,y1,tp3", o("y0", "y2", "y1", "tp3")),
    ("tp3,y0,y2,y1", o("tp3", "y0", "y2", "y1")),
    ("y1,y0,y2,tp3", o("y1", "y0", "y2", "tp3")),
    ("y2,y0,y1,tp3", o("y2", "y0", "y1", "tp3")),
]
