TU = "recon/game/psx/hud.cpp"
FN = "Hud_BuildNumbers__Fi"

OLD = ("    pSprt[37].x0 = (g1Player[0xe].x + g1Player[10].x + HudPmx_gShapes[0x2c].width + -2) -\n"
       "                   HudPmx_gShapes[DashHUD_gInfo.position + 0x2c].width;\n")
TAIL = "HudPmx_gShapes[DashHUD_gInfo.position + 0x2c].width;\n"


def v(expr):
    return (OLD, "    pSprt[37].x0 = %s -\n                   %s" % (expr, TAIL), 1)


VARIANTS = [
    ("CONTROL", []),
    ("V1 w-2 first", [v("(HudPmx_gShapes[0x2c].width - 2 + g1Player[0xe].x + g1Player[10].x)")]),
    ("V2 paren (w-2)", [v("(g1Player[0xe].x + g1Player[10].x + (HudPmx_gShapes[0x2c].width - 2))")]),
    ("V3 no outer paren", [v("HudPmx_gShapes[0x2c].width - 2 + g1Player[0xe].x + g1Player[10].x")]),
    ("V4 split groups", [v("(g1Player[0xe].x + g1Player[10].x) + (HudPmx_gShapes[0x2c].width + -2)")]),
    ("V5 w first then -2 last",
     [v("(HudPmx_gShapes[0x2c].width + g1Player[0xe].x + g1Player[10].x + -2)")]),
]
