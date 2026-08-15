TU = "recon/game/psx/hud.cpp"
FN = "Hud_BuildTimeSprites__FP4SPRTPcii"

PRE = "  c = (u_char)*str;\n  while (c != 0) {\n"
IFM = "    if (c == 0x4d) {\n"
CALL = "    Hud_BuildSpriteFromFont(sprt++,(char)c,x,y);\n"
LM = "  langMin = minSep[GameSetup_gData.userSetting.language];\n"

def F(v):
    return '  __asm__ ("" : : "r"(%s));\n' % v

def FB(v):
    return '    __asm__ ("" : : "r"(%s));\n' % v

VARIANTS = [
    ("control", []),
    ("foreign(y) in preheader", [(PRE, F("y") + PRE, 1)]),
    ("foreign(sprt) in preheader", [(PRE, F("sprt") + PRE, 1)]),
    ("foreign(x) in preheader", [(PRE, F("x") + PRE, 1)]),
    ("foreign(y) at loop-body head", [(IFM, FB("y") + IFM, 1)]),
    ("foreign(sprt) at loop-body head", [(IFM, FB("sprt") + IFM, 1)]),
    ("foreign(y) before the call", [(CALL, FB("y") + CALL, 1)]),
    ("foreign(str) in preheader", [(PRE, F("str") + PRE, 1)]),
    ("foreign(y) before langMin", [(LM, F("y") + LM, 1)]),
]
