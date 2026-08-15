TU = "recon/game/psx/hud.cpp"
FN = "Hud_BuildNumbers__Fi"

A_OLD = "    x = ((int)g1Player[1].x + (int)g1Player[0xc].x + 4) + w1 * 2;\n"
B_OLD = "    ten = speed / 10 + hun * -10;\n"
C_OLD = "      x = x - 1 - (int)HudPmx_gShapes[hun + 0x2c].width;\n"
D_OLD = "    y = (int)g1Player[1].y + (int)g1Player[0xc].y + splitY;\n"

VARIANTS = [
    ("CONTROL", []),
    ("A1 w1*2 first", [(A_OLD, "    x = w1 * 2 + ((int)g1Player[1].x + (int)g1Player[0xc].x + 4);\n", 1)]),
    ("A2 flat, +4 last", [(A_OLD, "    x = (int)g1Player[1].x + (int)g1Player[0xc].x + w1 * 2 + 4;\n", 1)]),
    ("B1 hun*-10 first", [(B_OLD, "    ten = hun * -10 + speed / 10;\n", 1)]),
    ("B2 minus form", [(B_OLD, "    ten = speed / 10 - hun * 10;\n", 1)]),
    ("C1 width before -1", [(C_OLD, "      x = x - (int)HudPmx_gShapes[hun + 0x2c].width - 1;\n", 1)]),
    ("C2 -1 folded paren", [(C_OLD, "      x = (x - 1) - (int)HudPmx_gShapes[hun + 0x2c].width;\n", 1)]),
    ("D1 splitY first", [(D_OLD, "    y = splitY + (int)g1Player[1].y + (int)g1Player[0xc].y;\n", 1)]),
]
