TU = "recon/game/psx/hud.cpp"
FN = "Hud_Init__Fv"

# --- base: D2 (retail SLD statement order in the replay-sprite preamble)
TAIL_OLD = ("  currentSpriteColor = 0x808080;\n"
            "  currentSpriteTransparent = 1;\n"
            "  spriteReplay = gSprite0;\n"
            "  i = 0;\n"
            "  baseX = g1Player[0xd].x;\n"
            "  baseY = g1Player[0xd].y;\n")
TAIL_SLD2 = ("  spriteReplay = gSprite0;\n"
             "  baseX = g1Player[0xd].x;\n"
             "  baseY = g1Player[0xd].y;\n"
             "  currentSpriteColor = 0x808080;\n"
             "  currentSpriteTransparent = 1;\n")
LOOPHEAD_OLD = "  HudBustedOverlay = 0;\n  do {\n"
LOOPHEAD_NEW = "  HudBustedOverlay = 0;\n  i = 0;\n  do {\n"
D2 = [(TAIL_OLD, TAIL_SLD2, 1), (LOOPHEAD_OLD, LOOPHEAD_NEW, 1)]

# --- site A anchors (unique two-line context)
SPR7_W1 = ("    Hud_BuildSprite2(gSprt1 + 7,0x7d,x,y);\n"
           "    w1 = HudPmx_gShapes[0x6b].width;\n")
XW1_3C = "    x = x + w1;\n    w2 = 0x3c;\n"
SPR8 = "    Hud_BuildSprite2(gSprt1 + 8,0x69,x,y);\n"

A1 = [(SPR7_W1, SPR7_W1 + "    w2 = 0x3c;\n", 1), (XW1_3C, "    x = x + w1;\n", 1)]
A2 = [(SPR7_W1, "    Hud_BuildSprite2(gSprt1 + 7,0x7d,x,y);\n    w2 = 0x3c;\n"
       "    w1 = HudPmx_gShapes[0x6b].width;\n", 1),
      (XW1_3C, "    x = x + w1;\n", 1)]
A3 = [(SPR8, "    w2 = 0x3c;\n" + SPR8, 1), (XW1_3C, "    x = x + w1;\n", 1)]
# A4: keep it where it is but fuse it onto the x+=w1 statement line (line-note only)
A4 = [(XW1_3C, "    x = x + w1; w2 = 0x3c;\n", 1)]

G4_2 = ("    x = x + w1;\n"
        "    Hud_BuildG4(HudG4 + 2,1,x,y,w2,10,0,0x707070,0,0x707070);\n")
G4_2N = "    Hud_BuildG4(HudG4 + 2,1,x = x + w1,y,w2,10,0,0x707070,0,0x707070);\n"
F4_3 = ("    x = x + w2;\n"
        "    Hud_BuildF4(HudF4 + 3,1,x,y + 7,7,3,0x707070);\n")
F4_3N = "    Hud_BuildF4(HudF4 + 3,1,x = x + w2,y + 7,7,3,0x707070);\n"
B = [(G4_2, G4_2N, 1)]
C = [(F4_3, F4_3N, 1)]

VARIANTS = [
    ("D2 (base)", D2),
    ("D2+A1 3c-after-w1load", D2 + A1),
    ("D2+A2 3c-before-w1load", D2 + A2),
    ("D2+A3 3c-before-spr8", D2 + A3),
    ("D2+A4 3c-fused-on-xw1", D2 + A4),
    ("D2+B", D2 + B),
    ("D2+C", D2 + C),
    ("D2+B+C", D2 + B + C),
]
