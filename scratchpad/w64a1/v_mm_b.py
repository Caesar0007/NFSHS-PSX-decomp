TU = "recon/game/psx/hud.cpp"
FN = "Hud_BuildMapMarkers__Fi"

# race-loop call sites (3) and the cop-loop site (1)
R1 = "Hud_BuildSprite(sprt,0x79,mapx + x + -3 & 0xffff,mapy - z & 0xffff,currentSpriteColor,0);"
R1N = "Hud_BuildSprite(sprt,0x79,0x16 + x + -3 & 0xffff,mapy - z & 0xffff,currentSpriteColor,0);"
R2 = "        Hud_BuildSprite(sprt,0x79,mapx + x + -3 & 0xffff,mapy - z & 0xffff,\n"
R2N = "        Hud_BuildSprite(sprt,0x79,0x16 + x + -3 & 0xffff,mapy - z & 0xffff,\n"
R3 = "        Hud_BuildSprite(sprt,0x7a,mapx + x + -2 & 0xffff,mapy - z & 0xffff,\n"
R3N = "        Hud_BuildSprite(sprt,0x7a,0x16 + x + -2 & 0xffff,mapy - z & 0xffff,\n"
C1 = "      Hud_BuildSprite(sprt,0x7a,mapx + x + -2 & 0xffff,mapy - z & 0xffff,currentSpriteColor,0);"
C1N = "      Hud_BuildSprite(sprt,0x7a,0x16 + x + -2 & 0xffff,mapy - z & 0xffff,currentSpriteColor,0);"

# fence position in the race loop
RACE_F = ("      pktcell = (u_char **)0x1F800004;   /* see cop loop */\n"
          "      __asm__(\"\" : \"=r\"(pktcell) : \"0\"(pktcell));\n"
          "      sprt = (SPRT *)*pktcell;\n")
RACE_F_AFTER = ("      pktcell = (u_char **)0x1F800004;   /* see cop loop */\n"
                "      sprt = (SPRT *)*pktcell;\n"
                "      __asm__(\"\" : \"=r\"(pktcell) : \"0\"(pktcell));\n")

VARIANTS = [
    ("CONTROL (F3 base)", []),
    ("M1 literal all 4", [(R1, R1N, 1), (R2, R2N, 1), (R3, R3N, 1), (C1, C1N, 1)]),
    ("M2 literal race 3", [(R1, R1N, 1), (R2, R2N, 1), (R3, R3N, 1)]),
    ("M3 literal cop only", [(C1, C1N, 1)]),
    ("M4 race fence after sprt", [(RACE_F, RACE_F_AFTER, 1)]),
]
