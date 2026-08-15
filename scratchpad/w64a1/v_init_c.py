TU = "recon/game/psx/hud.cpp"
FN = "Hud_Init__Fv"

OLD_B = ("    x = x + w1;\n"
         "    Hud_BuildG4(HudG4 + 2,1,x,y,w2,10,0,0x707070,0,0x707070);\n")
OLD_C = ("    x = x + w2;\n"
         "    Hud_BuildF4(HudF4 + 3,1,x,y + 7,7,3,0x707070);\n")

VARIANTS = [
    ("CONTROL", []),
    ("B1 x+=w1 inline", [(OLD_B,
        "    Hud_BuildG4(HudG4 + 2,1,x += w1,y,w2,10,0,0x707070,0,0x707070);\n", 1)]),
    ("B2 swap operands", [(OLD_B,
        "    x = w1 + x;\n"
        "    Hud_BuildG4(HudG4 + 2,1,x,y,w2,10,0,0x707070,0,0x707070);\n", 1)]),
    ("B3 void fence between", [(OLD_B,
        "    x = x + w1;\n"
        "    __asm__(\"\" : : \"i\"(0));\n"
        "    Hud_BuildG4(HudG4 + 2,1,x,y,w2,10,0,0x707070,0,0x707070);\n", 1)]),
    ("B4 ro-fence on x after", [(OLD_B,
        "    x = x + w1;\n"
        "    Hud_BuildG4(HudG4 + 2,1,x,y,w2,10,0,0x707070,0,0x707070);\n"
        "    __asm__(\"\" : : \"r\"(x));\n", 1)]),
    ("B5 arg0 in a local", [(OLD_B,
        "    pG4tmp = HudG4 + 2;\n"
        "    x = x + w1;\n"
        "    Hud_BuildG4(pG4tmp,1,x,y,w2,10,0,0x707070,0,0x707070);\n", 1)]),
    ("C1 x+=w2 inline", [(OLD_C,
        "    Hud_BuildF4(HudF4 + 3,1,x += w2,y + 7,7,3,0x707070);\n", 1)]),
    ("C2 swap operands", [(OLD_C,
        "    x = w2 + x;\n"
        "    Hud_BuildF4(HudF4 + 3,1,x,y + 7,7,3,0x707070);\n", 1)]),
    ("C3 void fence between", [(OLD_C,
        "    x = x + w2;\n"
        "    __asm__(\"\" : : \"i\"(0));\n"
        "    Hud_BuildF4(HudF4 + 3,1,x,y + 7,7,3,0x707070);\n", 1)]),
]
