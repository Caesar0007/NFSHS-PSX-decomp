TU = "recon/game/psx/hud.cpp"
FN = "Hud_RenderTacView__Fv"

T_OLD = "      dh = DashHUD_view;\n    } while (j <= dh[0]);\n"
T_G = "      dh = (int *)&DashHUD_gInfo;\n    } while (j <= dh[0]);\n"

COND_OLD = ("      if ((GameSetup_gData.carInfo[j].HudTach != 0) &&\n"
            "          (dh = (int *)&DashHUD_gInfo, dh[j + 7] != 0)) {\n")
COND_NEST = ("      if (GameSetup_gData.carInfo[j].HudTach != 0)\n"
             "      if ((dh = (int *)&DashHUD_gInfo, dh[j + 7] != 0)) {\n")
COND_NEST_LAUNDER = ("      if (GameSetup_gData.carInfo[j].HudTach != 0)\n"
                     "      if ((dh = (int *)&DashHUD_gInfo,\n"
                     "           __asm__(\"\" : \"=r\"(dh) : \"0\"(dh)),\n"
                     "           dh[j + 7] != 0)) {\n")

VARIANTS = [
    ("CONTROL B=g T=v", []),
    ("B=g T=g", [(T_OLD, T_G, 1)]),
    ("B=g T=v nested-if", [(COND_OLD, COND_NEST, 1)]),
    ("B=g T=g nested-if", [(T_OLD, T_G, 1), (COND_OLD, COND_NEST, 1)]),
    ("B=g T=g nested+launder", [(T_OLD, T_G, 1), (COND_OLD, COND_NEST_LAUNDER, 1)]),
    ("B=g T=v nested+launder", [(COND_OLD, COND_NEST_LAUNDER, 1)]),
]
