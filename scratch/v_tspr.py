TU = 'recon/game/psx/hud.cpp'
FNS = 'Hud_BuildTimeSprites__FP4SPRTPcii'

LOOP = """  c = (u_char)*str;
  while (c != 0) {
    if (c == 0x4d) {
      c = langMin;
    }
    if (c == 0x53) {
      c = langSec;
    }
    w = (signed char)((charactertbl *)Font_Getcharacter(c))->advance + 1;
    Hud_BuildSpriteFromFont(sprt++,(char)c,x,y);
    str = str + 1;
    x = x + w;
    c = (u_char)*str;
  }
"""

VARIANTS = [
    # U1: langMin/langSec read INSIDE the loop (kills the s5/s6 hoist, frees 2 callee regs)
    ('U1 sep lookups inside the loop', [
        ("""  langMin = minSep[GameSetup_gData.userSetting.language];
  langSec = secSep[GameSetup_gData.userSetting.language];
""", ""),
        (LOOP, LOOP.replace("    if (c == 0x4d) {\n      c = langMin;\n    }\n",
                            "    if (c == 0x4d) {\n      c = minSep[GameSetup_gData.userSetting.language];\n    }\n")
                   .replace("    if (c == 0x53) {\n      c = langSec;\n    }\n",
                            "    if (c == 0x53) {\n      c = secSep[GameSetup_gData.userSetting.language];\n    }\n"))]),
    # U2: S-test first (0x53 hoisted first -> born earlier -> longer live)
    ('U2 S-test first', [
        (LOOP, """  c = (u_char)*str;
  while (c != 0) {
    if (c == 0x53) {
      c = langSec;
    }
    if (c == 0x4d) {
      c = langMin;
    }
    w = (signed char)((charactertbl *)Font_Getcharacter(c))->advance + 1;
    Hud_BuildSpriteFromFont(sprt++,(char)c,x,y);
    str = str + 1;
    x = x + w;
    c = (u_char)*str;
  }
""")]),
    # U3: y gets one extra loop-weighted reference (a semantic no-op re-add)
    ('U3 y extra ref (y+0*w)', [
        (LOOP, LOOP.replace("Hud_BuildSpriteFromFont(sprt++,(char)c,x,y);",
                            "Hud_BuildSpriteFromFont(sprt++,(char)c,x,y | (y & 0));"))]),
    # U4: y forwarded through a named local born just before the loop
    ('U4 named y copy before the loop', [
        (LOOP, "  {\n  int yy;\n  yy = y;\n" + LOOP.replace(",x,y);", ",x,yy);") + "  }\n")]),
]
