TU = "recon/game/psx/hud.cpp"
FN = "Hud_BuildMapMarkers__Fi"

COP_B = ("      pktcell = (u_char **)0x1F800004;   /* one addr materialization per iter"
         " (shared by read+bump) -- keeps the 0x1F800004 constant un-hoisted like retail */\n"
         "      __asm__(\"\" : \"=r\"(pktcell) : \"0\"(pktcell));\n"
         "      sprt = (SPRT *)*pktcell;\n")
COP_A = ("      pktcell = (u_char **)0x1F800004;   /* one addr materialization per iter"
         " (shared by read+bump) -- keeps the 0x1F800004 constant un-hoisted like retail */\n"
         "      sprt = (SPRT *)*pktcell;\n"
         "      __asm__(\"\" : \"=r\"(pktcell) : \"0\"(pktcell));\n")
RACE_B = ("      pktcell = (u_char **)0x1F800004;   /* see cop loop */\n"
          "      __asm__(\"\" : \"=r\"(pktcell) : \"0\"(pktcell));\n"
          "      sprt = (SPRT *)*pktcell;\n")
RACE_A = ("      pktcell = (u_char **)0x1F800004;   /* see cop loop */\n"
          "      sprt = (SPRT *)*pktcell;\n"
          "      __asm__(\"\" : \"=r\"(pktcell) : \"0\"(pktcell));\n")
# fence at the very end of the packet block (after the cursor bump)
COP_E = ("      pktcell = (u_char **)0x1F800004;   /* one addr materialization per iter"
         " (shared by read+bump) -- keeps the 0x1F800004 constant un-hoisted like retail */\n"
         "      sprt = (SPRT *)*pktcell;\n")
RACE_E = ("      pktcell = (u_char **)0x1F800004;   /* see cop loop */\n"
          "      sprt = (SPRT *)*pktcell;\n")

VARIANTS = [
    ("CONTROL cop=B race=B", []),
    ("cop=B race=A", [(RACE_B, RACE_A, 1)]),
    ("cop=A race=B", [(COP_B, COP_A, 1)]),
    ("cop=A race=A", [(COP_B, COP_A, 1), (RACE_B, RACE_A, 1)]),
]
