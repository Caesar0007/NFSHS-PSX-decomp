TU = "recon/game/psx/hud.cpp"
FN = "Hud_Init__Fv"

XW1_3C = "    x = x + w1;\n    w2 = 0x3c;\n"
UNHOIST_1D = ("    w2 = 0x1d;\n"
              "    Hud_BuildSprite2(gSprt1 + 6,0x6b,x,y);\n"
              "    x = x + w1;\n")
UNHOIST_1D_NEW = ("    Hud_BuildSprite2(gSprt1 + 6,0x6b,x,y);\n"
                  "    x = x + w1;\n"
                  "    w2 = 0x1d;\n")
SPR8 = "    Hud_BuildSprite2(gSprt1 + 8,0x69,x,y);\n"

VARIANTS = [
    ("CONTROL", []),
    ("A5 3c-before-x+=w1", [(XW1_3C, "    w2 = 0x3c;\n    x = x + w1;\n", 1)]),
    ("A7 un-hoist 1d only", [(UNHOIST_1D, UNHOIST_1D_NEW, 1)]),
    ("A8 swap: 1d down, 3c up",
     [(UNHOIST_1D, UNHOIST_1D_NEW, 1),
      (SPR8, "    w2 = 0x3c;\n" + SPR8, 1),
      (XW1_3C, "    x = x + w1;\n", 1)]),
]
