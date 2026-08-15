TU = "recon/game/psx/hud.cpp"
FN = "Hud_RenderHudView__Fv"

DECL = "        u_int *tagp;\n"
S2 = "        *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)tagp & otmask;\n"
IF2 = ("          *(u_int *)pal = *(u_int *)pal & 0xff000000 |"
       " (u_int)(gSprt1 + 1) & otmask;\n")

S2_PW = "        pw = *(u_int *)pal;\n        *(u_int *)pal = pw & 0xff000000 | (u_int)tagp & otmask;\n"
IF2_PW = ("          pw = *(u_int *)pal;\n"
          "          *(u_int *)pal = pw & 0xff000000 | (u_int)(gSprt1 + 1) & otmask;\n")

ADD = [(DECL, DECL + "        u_int pw;\n", 1)]

VARIANTS = [
    ("control", []),
    ("pw shared S2 + if-block", ADD + [(S2, S2_PW, 1), (IF2, IF2_PW, 1)]),
    ("pw in S2 + dead ro-fence in if-block",
     ADD + [(S2, S2_PW, 1), (IF2, '          __asm__ ("" : : "r"(pw));\n' + IF2, 1)]),
    ("pw in S2 only (single block control)", ADD + [(S2, S2_PW, 1)]),
]
