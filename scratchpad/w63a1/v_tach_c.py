TU = "recon/game/psx/hud.cpp"
FN = "Hud_BuildTach__Fi"

TP3 = "  tp3 = Render_gPalettePtr;\n"
Y1 = "  ((POLY_F3 *)prim2)->y1 = ((POLY_F3 *)prim2)->y1 + 2;\n"
Y0 = "  ((POLY_F3 *)prim2)->y0 = ((POLY_F3 *)prim2)->y0 + 2;\n"
Y2 = "  ((POLY_F3 *)prim2)->y2 = ts1 + 2;\n"
Y2R = "  ((POLY_F3 *)prim2)->y2 = ((POLY_F3 *)prim2)->y2 + 2;\n"
BLOCK = TP3 + Y1 + Y0 + Y2

NAMES = {"tp3": TP3, "y0": Y0, "y1": Y1, "y2": Y2, "y2r": Y2R}


def order(*keys):
    return [(BLOCK, "".join(NAMES[k] for k in keys), 1)]


VARIANTS = [
    ("control  tp3,y1,y0,y2", []),
    ("tp3,y0,y1,y2", order("tp3", "y0", "y1", "y2")),
    ("y0,y1,y2,tp3", order("y0", "y1", "y2", "tp3")),
    ("y0,tp3,y1,y2", order("y0", "tp3", "y1", "y2")),
    ("y0,y1,tp3,y2", order("y0", "y1", "tp3", "y2")),
    ("tp3,y0,y1,y2r", order("tp3", "y0", "y1", "y2r")),
    ("y0,y1,y2r,tp3", order("y0", "y1", "y2r", "tp3")),
    ("y0,tp3,y1,y2r", order("y0", "tp3", "y1", "y2r")),
    ("tp3,y1,y0,y2r", order("tp3", "y1", "y0", "y2r")),
    ("tp3,y2,y0,y1", order("tp3", "y2", "y0", "y1")),
]
