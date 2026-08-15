TU = "recon/game/psx/hud.cpp"
FN = "Hud_BuildCdPlayer__Fii"

ARMS_OLD = ("    if (index == 0) {\n"
            "      sprintf(strindex,\"- -\");\n"
            "      artist = (char *)0x0;\n"
            "      title = TextSys_Word(0x44);\n"
            "    }\n"
            "    else if (index == -2) {\n"
            "      sprintf(strindex,\"- -\");\n"
            "      artist = (char *)0x0;\n"
            "      title = TextSys_Word(0x45);\n"
            "    }\n"
            "    else {\n"
            "      sprintf(strindex,\"- -\");\n"
            "      artist = (char *)0x0;\n"
            "      if (title != (char *)0x0) goto HudCdPlay_nullStringFallback;\n"
            "      title = TextSys_Word(0x46);\n"
            "    }\n")
ARMS_HOIST_A = ("    artist = (char *)0x0;\n"
                "    if (index == 0) {\n"
                "      sprintf(strindex,\"- -\");\n"
                "      title = TextSys_Word(0x44);\n"
                "    }\n"
                "    else if (index == -2) {\n"
                "      sprintf(strindex,\"- -\");\n"
                "      title = TextSys_Word(0x45);\n"
                "    }\n"
                "    else {\n"
                "      sprintf(strindex,\"- -\");\n"
                "      if (title != (char *)0x0) goto HudCdPlay_nullStringFallback;\n"
                "      title = TextSys_Word(0x46);\n"
                "    }\n")
ARMS_HOIST_AS = ("    sprintf(strindex,\"- -\");\n"
                 "    artist = (char *)0x0;\n"
                 "    if (index == 0) {\n"
                 "      title = TextSys_Word(0x44);\n"
                 "    }\n"
                 "    else if (index == -2) {\n"
                 "      title = TextSys_Word(0x45);\n"
                 "    }\n"
                 "    else {\n"
                 "      if (title != (char *)0x0) goto HudCdPlay_nullStringFallback;\n"
                 "      title = TextSys_Word(0x46);\n"
                 "    }\n")

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


VARIANTS = [
    ("CONTROL", []),
    ("P1 hoist artist", [(ARMS_OLD, ARMS_HOIST_A, 1)]),
    ("P2 hoist artist+sprintf", [(ARMS_OLD, ARMS_HOIST_AS, 1)]),
    ("E1 x+(dx+K) parens",
     [s1("(x + (dx + 10)) - (Hud_gCdScrollTitle - 0x4c)"),
      s2("(x + (dx + 0x16)) - (Hud_gCdScrollTitle - 0x4c)")]),
    ("E2 dx+K+x",
     [s1("(dx + 10 + x) - (Hud_gCdScrollTitle - 0x4c)"),
      s2("(dx + 0x16 + x) - (Hud_gCdScrollTitle - 0x4c)")]),
    ("E3 fold-escape 0x4c-scroll+expr",
     [s1("0x4c - Hud_gCdScrollTitle + (x + dx + 10)"),
      s2("0x4c - Hud_gCdScrollTitle + (x + dx + 0x16)")]),
    ("E4 (x+dx+K)+(0x4c-scroll)",
     [s1("(x + dx + 10) + (0x4c - Hud_gCdScrollTitle)"),
      s2("(x + dx + 0x16) + (0x4c - Hud_gCdScrollTitle)")]),
    ("E5 x+(dx+K)-scroll+0x4c",
     [s1("x + (dx + 10) - Hud_gCdScrollTitle + 0x4c"),
      s2("x + (dx + 0x16) - Hud_gCdScrollTitle + 0x4c")]),
]
