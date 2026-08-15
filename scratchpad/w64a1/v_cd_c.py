TU = "recon/game/psx/hud.cpp"
FN = "Hud_BuildCdPlayer__Fii"

OLD = "  if (Hud_gCdScrollTitle < Hud_BuildString(title,0,0,0,0,true) + 0x4c) {\n"
SCROLL = "    int scroll = Hud_gCdScrollTitle;\n"

W1 = ("  {\n"
      "  int tw = Hud_BuildString(title,0,0,0,0,true) + 0x4c;\n"
      "  if (Hud_gCdScrollTitle < tw) {\n")
W1S = SCROLL + "    __asm__(\"\" : : \"r\"(tw), \"r\"(tw));\n"
W2S = SCROLL + "    __asm__(\"\" : : \"r\"(tw));\n"

# closing brace for the extra scope: attach after the else-if block
CLOSE_OLD = ("  else if (Hud_gCdLastTick + 0x80 < ticks) {\n"
             "    Hud_gCdActive = 0;\n"
             "  }\n")
CLOSE_NEW = ("  else if (Hud_gCdLastTick + 0x80 < ticks) {\n"
             "    Hud_gCdActive = 0;\n"
             "  }\n  }\n")

VARIANTS = [
    ("CONTROL", []),
    ("W1 tw + 2-op fence", [(OLD, W1, 1), (SCROLL, W1S, 1), (CLOSE_OLD, CLOSE_NEW, 1)]),
    ("W2 tw + 1-op fence", [(OLD, W1, 1), (SCROLL, W2S, 1), (CLOSE_OLD, CLOSE_NEW, 1)]),
    ("W3 tw no fence", [(OLD, W1, 1), (CLOSE_OLD, CLOSE_NEW, 1)]),
]
