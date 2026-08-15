TU = "recon/game/psx/hud.cpp"
FN = "Hud_BuildMapMarkers__Fi"
F = "      __asm__(\"\" : \"=r\"(pktcell) : \"0\"(pktcell));\n"

COP_CUR = ("      pktcell = (u_char **)0x1F800004;   /* one addr materialization per iter"
           " (shared by read+bump) -- keeps the 0x1F800004 constant un-hoisted like retail */\n"
           + F +
           "      sprt = (SPRT *)*pktcell;\n"
           "      pal = Render_gPalettePtr;\n"
           "      ((Hud_PTag *)sprt)->addr = ((Hud_PTag *)pal)->addr;\n"
           "      ((Hud_PTag *)pal)->addr = (u_int)sprt;\n"
           "      *pktcell = (u_char *)sprt + 0x14;\n")
COP_HDR = ("      pktcell = (u_char **)0x1F800004;   /* one addr materialization per iter"
           " (shared by read+bump) -- keeps the 0x1F800004 constant un-hoisted like retail */\n")
COP_BODY = ("      sprt = (SPRT *)*pktcell;\n"
            "      pal = Render_gPalettePtr;\n"
            "      ((Hud_PTag *)sprt)->addr = ((Hud_PTag *)pal)->addr;\n"
            "      ((Hud_PTag *)pal)->addr = (u_int)sprt;\n"
            "      *pktcell = (u_char *)sprt + 0x14;\n")

RACE_CUR = ("      pktcell = (u_char **)0x1F800004;   /* see cop loop */\n"
            "      sprt = (SPRT *)*pktcell;\n" + F +
            "      pal = Render_gPalettePtr;\n"
            "      ((Hud_PTag *)sprt)->addr = ((Hud_PTag *)pal)->addr;\n"
            "      ((Hud_PTag *)pal)->addr = (u_int)sprt;\n"
            "      *pktcell = (u_char *)sprt + 0x14;\n")
RACE_HDR = "      pktcell = (u_char **)0x1F800004;   /* see cop loop */\n"

VARIANTS = [
    ("CONTROL cop=B race=A", []),
    ("cop=E race=A", [(COP_CUR, COP_HDR + COP_BODY + F, 1)]),
    ("cop=A race=A", [(COP_CUR, COP_HDR + "      sprt = (SPRT *)*pktcell;\n" + F
                       + COP_BODY.replace("      sprt = (SPRT *)*pktcell;\n", "", 1), 1)]),
    ("cop=B race=E", [(RACE_CUR, RACE_HDR + COP_BODY + F, 1)]),
    ("cop=E race=E", [(COP_CUR, COP_HDR + COP_BODY + F, 1),
                      (RACE_CUR, RACE_HDR + COP_BODY + F, 1)]),
]
