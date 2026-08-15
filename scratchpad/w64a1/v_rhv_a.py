TU = "recon/game/psx/hud.cpp"
FN = "Hud_RenderHudView__Fv"

OLD = ("        u_char *pal;\n"
       "        u_int *tagp;\n"
       "\n"
       "        pal = Render_gPalettePtr;\n"
       "        tagp = (u_int *)((int)gTPage0 + tpageOff);\n"
       "        *tagp = *tagp & 0xff000000 | *(u_int *)pal & otmask;\n"
       "        *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)tagp & otmask;\n")

HEAD = ("        u_char *pal;\n"
        "        u_int *tagp;\n"
        "        u_int pw;\n"
        "\n"
        "        pal = Render_gPalettePtr;\n"
        "        tagp = (u_int *)((int)gTPage0 + tpageOff);\n"
        "        *tagp = *tagp & 0xff000000 | *(u_int *)pal & otmask;\n")

R1 = HEAD + ("        pw = *(u_int *)pal;\n"
             "        *(u_int *)pal = pw & 0xff000000 | (u_int)tagp & otmask;\n"
             "        __asm__(\"\" : : \"r\"(pw));\n")
R2 = HEAD + ("        pw = *(u_int *)pal;\n"
             "        *(u_int *)pal = pw & 0xff000000 | (u_int)tagp & otmask;\n"
             "        __asm__(\"\" : : \"r\"(pw), \"r\"(pw));\n")
R3 = HEAD + ("        pw = *(u_int *)pal;\n"
             "        __asm__(\"\" : : \"r\"(pw));\n"
             "        *(u_int *)pal = pw & 0xff000000 | (u_int)tagp & otmask;\n")
# read-only fence on the un-named loaded word via a dead second read
R4 = (OLD + "        __asm__(\"\" : : \"r\"(*(u_int *)pal));\n")

VARIANTS = [
    ("CONTROL", []),
    ("R1 pw + rofence after", [(OLD, R1, 1)]),
    ("R2 pw + 2-op rofence after", [(OLD, R2, 1)]),
    ("R3 pw + rofence before", [(OLD, R3, 1)]),
    ("R4 rofence on reloaded word", [(OLD, R4, 1)]),
]
