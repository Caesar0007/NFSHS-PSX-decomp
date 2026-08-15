TU = "recon/game/psx/hud.cpp"
FN = "Hud_RenderHudView__Fv"

TAGP = "        tagp = (u_int *)((int)gTPage0 + tpageOff);\n"
S1 = "        *tagp = *tagp & 0xff000000 | *(u_int *)pal & otmask;\n"
S2 = "        *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)tagp & otmask;\n"

VARIANTS = [
    ("control", []),
    # addr24-EARLY: give (u_int)tagp & otmask its own temp before the first RMW
    ("addr24-early temp",
     [(S1, "        { u_int a24 = (u_int)tagp & otmask;\n" + S1 +
       "        *(u_int *)pal = *(u_int *)pal & 0xff000000 | a24; }\n", 1), (S2, "", 1)]),
    # addr24 temp AFTER the first RMW
    ("addr24-late temp",
     [(S2, "        { u_int a24 = (u_int)tagp & otmask;\n"
           "        *(u_int *)pal = *(u_int *)pal & 0xff000000 | a24; }\n", 1)]),
    # name the tagp read of statement 1
    ("named tagword in S1",
     [(S1, "        { u_int tw = *tagp;\n"
           "        *tagp = tw & 0xff000000 | *(u_int *)pal & otmask; }\n", 1)]),
    # read-only fence on the pal pointer after S2
    ("ro-fence on pal after S2",
     [(S2, S2 + '        __asm__ ("" : : "r"(pal));\n', 1)]),
    # read-only fence on tagp after S2
    ("ro-fence on tagp after S2",
     [(S2, S2 + '        __asm__ ("" : : "r"(tagp));\n', 1)]),
    # void fence between the two RMWs
    ("void fence between S1/S2", [(S2, '        __asm__ ("" : : "i"(0));\n' + S2, 1)]),
    # tagp materialised as a plain int address
    ("tagp via int",
     [(TAGP, "        { int tpa = (int)gTPage0 + tpageOff; tagp = (u_int *)tpa; }\n", 1)]),
    # S2 reading the pal word through a second pointer local
    ("S2 through palw ptr",
     [(S2, "        { u_int *palw = (u_int *)pal;\n"
           "        *palw = *palw & 0xff000000 | (u_int)tagp & otmask; }\n", 1)]),
    # no-op re-mask of the loaded pal word (ref inflator, w44)
    ("S2 remask pal word",
     [(S2, "        *(u_int *)pal = (*(u_int *)pal & 0xff000000) & 0xff000000"
           " | (u_int)tagp & otmask;\n", 1)]),
]
