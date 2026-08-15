TU = "recon/game/psx/hud.cpp"
FN = "Hud_RenderHudView__Fv"

S2 = "  ((Hud_PTag *)pal)->addr = (u_int)&tSs1_3[0x38];\n"

WORD = ("  *(u_int *)pal = *(u_int *)pal & 0xff000000 |"
        " (u_int)&tSs1_3[0x38] & 0xffffff;\n")
WORD_T = ("  { u_int pw = *(u_int *)pal;\n"
          "    *(u_int *)pal = pw & 0xff000000 | (u_int)&tSs1_3[0x38] & 0xffffff; }\n")
WORD_F = ("  { u_int pw = *(u_int *)pal;\n"
          "    __asm__ (\"\" : \"=r\"(pw) : \"0\"(pw));\n"
          "    *(u_int *)pal = pw & 0xff000000 | (u_int)&tSs1_3[0x38] & 0xffffff; }\n")
WORD_F2 = ("  { u_int pw = *(u_int *)pal;\n"
           "    u_int ph = pw & 0xff000000;\n"
           "    __asm__ (\"\" : \"=r\"(ph) : \"0\"(ph));\n"
           "    *(u_int *)pal = ph | (u_int)&tSs1_3[0x38] & 0xffffff; }\n")
FENCE_ADDR = ("  { u_int pa = (u_int)&tSs1_3[0x38];\n"
              "    __asm__ (\"\" : \"=r\"(pa) : \"0\"(pa));\n"
              "    ((Hud_PTag *)pal)->addr = pa; }\n")

VARIANTS = [
    ("control", []),
    ("word-RMW spelling", [(S2, WORD, 1)]),
    ("word-RMW + named pw", [(S2, WORD_T, 1)]),
    ("word-RMW + identity fence on pw", [(S2, WORD_F, 1)]),
    ("word-RMW + identity fence on hi", [(S2, WORD_F2, 1)]),
    ("bitfield + identity fence on addr", [(S2, FENCE_ADDR, 1)]),
]
