TU = "recon/game/psx/hud.cpp"
FN = "Hud_Init__Fv"

W1LINE = "    w1 = HudPmx_gShapes[0x6b].width;\n"
SPR8 = "    Hud_BuildSprite2(gSprt1 + 8,0x69,x,y);\n"
XW1_3C = "    x = x + w1;\n    w2 = 0x3c;\n"

G4_2 = ("    x = x + w1;\n"
        "    Hud_BuildG4(HudG4 + 2,1,x,y,w2,10,0,0x707070,0,0x707070);\n")
G4_2N = "    Hud_BuildG4(HudG4 + 2,1,x = x + w1,y,w2,10,0,0x707070,0,0x707070);\n"

F4_3 = ("    x = x + w2;\n"
        "    Hud_BuildF4(HudF4 + 3,1,x,y + 7,7,3,0x707070);\n")
F4_3N = "    Hud_BuildF4(HudF4 + 3,1,x = x + w2,y + 7,7,3,0x707070);\n"

TAIL_OLD = ("  currentSpriteColor = 0x808080;\n"
            "  currentSpriteTransparent = 1;\n"
            "  spriteReplay = gSprite0;\n"
            "  i = 0;\n"
            "  baseX = g1Player[0xd].x;\n"
            "  baseY = g1Player[0xd].y;\n")
TAIL_SLD = ("  spriteReplay = gSprite0;\n"
            "  baseX = g1Player[0xd].x;\n"
            "  baseY = g1Player[0xd].y;\n"
            "  currentSpriteColor = 0x808080;\n"
            "  currentSpriteTransparent = 1;\n"
            "  i = 0;\n")
TAIL_SLD2 = ("  spriteReplay = gSprite0;\n"
             "  baseX = g1Player[0xd].x;\n"
             "  baseY = g1Player[0xd].y;\n"
             "  currentSpriteColor = 0x808080;\n"
             "  currentSpriteTransparent = 1;\n")
LOOPHEAD_OLD = "  HudBustedOverlay = 0;\n  do {\n"
LOOPHEAD_NEW = "  HudBustedOverlay = 0;\n  i = 0;\n  do {\n"

VARIANTS = [
    ("CONTROL", []),
    # -- site A: w2 = 0x3c placement (retail SLD 1025 groups it with the w1 width load)
    ("A1 3c-after-w1load", [(W1LINE, W1LINE + "    w2 = 0x3c;\n", 1),
                            (XW1_3C, "    x = x + w1;\n", 1)]),
    ("A2 3c-before-w1load", [(W1LINE, "    w2 = 0x3c;\n" + W1LINE, 1),
                             (XW1_3C, "    x = x + w1;\n", 1)]),
    ("A3 3c-before-spr8", [(SPR8, "    w2 = 0x3c;\n" + SPR8, 1),
                           (XW1_3C, "    x = x + w1;\n", 1)]),
    # -- site B: x += w1 as the inline 3rd argument of HudG4+2
    ("B  G4_2-inline-x", [(G4_2, G4_2N, 1)]),
    # -- site C: x += w2 as the inline 3rd argument of HudF4+3
    ("C  F4_3-inline-x", [(F4_3, F4_3N, 1)]),
    # -- site D: retail SLD statement order in the replay-sprite preamble
    ("D1 tail-SLD-order", [(TAIL_OLD, TAIL_SLD, 1)]),
    ("D2 tail-SLD-i-at-loop", [(TAIL_OLD, TAIL_SLD2, 1),
                               (LOOPHEAD_OLD, LOOPHEAD_NEW, 1)]),
]
