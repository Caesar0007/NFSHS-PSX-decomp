TU = "recon/game/psx/hud.cpp"
FN = "Hud_BuildCdPlayer__Fii"

S1_OLD = ("    Hud_BuildString(strscrolltitle,(x + dx + 10) - (Hud_gCdScrollTitle - 0x4c),y + 0xa,\n"
          "               0xbebe,0,false);\n")
S2_OLD = ("      Hud_BuildString(strscrolltitle,(x + dx + 0x16) - (Hud_gCdScrollTitle - 0x4c),y + 3,\n"
          "                 0xbebe,0,false);\n")


def s1(expr):
    return (S1_OLD, "    Hud_BuildString(strscrolltitle,%s,y + 0xa,\n"
            "               0xbebe,0,false);\n" % expr, 1)


def s2(expr):
    return (S2_OLD, "      Hud_BuildString(strscrolltitle,%s,y + 3,\n"
            "                 0xbebe,0,false);\n" % expr, 1)


P1 = "(x + (dx + 10)) - (Hud_gCdScrollTitle - 0x4c)"
P2 = "(x + (dx + 0x16)) - (Hud_gCdScrollTitle - 0x4c)"

VARIANTS = [
    ("CONTROL", []),
    ("site1 paren only", [s1(P1)]),
    ("site2 paren only", [s2(P2)]),
    ("site1 dx+K+x", [s1("(dx + 10 + x) - (Hud_gCdScrollTitle - 0x4c)")]),
    ("site2 dx+K+x", [s2("(dx + 0x16 + x) - (Hud_gCdScrollTitle - 0x4c)")]),
]
