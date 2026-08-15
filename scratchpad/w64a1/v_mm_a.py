TU = "recon/game/psx/hud.cpp"
FN = "Hud_BuildMapMarkers__Fi"

COP = ("      pktcell = (u_char **)0x1F800004;   /* one addr materialization per iter"
       " (shared by read+bump) -- keeps the 0x1F800004 constant un-hoisted like retail */\n"
       "      sprt = (SPRT *)*pktcell;\n")
RACE = ("      pktcell = (u_char **)0x1F800004;   /* see cop loop */\n"
        "      sprt = (SPRT *)*pktcell;\n")

IDF = "      __asm__(\"\" : \"=r\"(pktcell) : \"0\"(pktcell));\n"
ROF = "      __asm__(\"\" : : \"r\"(pktcell));\n"

COP_ID = COP.replace("      sprt = (SPRT *)*pktcell;\n", IDF + "      sprt = (SPRT *)*pktcell;\n")
RACE_ID = RACE.replace("      sprt = (SPRT *)*pktcell;\n", IDF + "      sprt = (SPRT *)*pktcell;\n")
COP_RO = COP.replace("      sprt = (SPRT *)*pktcell;\n", ROF + "      sprt = (SPRT *)*pktcell;\n")
RACE_RO = RACE.replace("      sprt = (SPRT *)*pktcell;\n", ROF + "      sprt = (SPRT *)*pktcell;\n")

# race loop through the shared scratchpad macro (a structurally different tree)
RACE_MACRO = ("      pktcell = &Render_gPacketPtr;   /* see cop loop */\n"
              "      sprt = (SPRT *)*pktcell;\n")

VARIANTS = [
    ("CONTROL", []),
    ("F1 idfence race only", [(RACE, RACE_ID, 1)]),
    ("F2 idfence cop only", [(COP, COP_ID, 1)]),
    ("F3 idfence both", [(COP, COP_ID, 1), (RACE, RACE_ID, 1)]),
    ("F4 rofence both", [(COP, COP_RO, 1), (RACE, RACE_RO, 1)]),
    ("F5 race via macro addr", [(RACE, RACE_MACRO, 1)]),
]
