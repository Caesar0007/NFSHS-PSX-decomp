TU = "recon/game/psx/hud.cpp"
FN = "Hud_RenderTacView__Fv"

T_OLD = "      dh = DashHUD_view;\n    } while (j <= dh[0]);\n"
T_G = "      dh = (int *)&DashHUD_gInfo;\n    } while (j <= dh[0]);\n"

DO_OLD = "    do {\n      /* MATCH (w44-a5)"
DO_GOTO = "    tacloop:\n    {\n      /* MATCH (w44-a5)"
END_V = "      dh = DashHUD_view;\n    } while (j <= dh[0]);\n"
END_V_GOTO = ("      dh = DashHUD_view;\n    }\n"
              "    if (j <= dh[0]) goto tacloop;\n")
END_G_GOTO = ("      dh = (int *)&DashHUD_gInfo;\n    }\n"
              "    if (j <= dh[0]) goto tacloop;\n")

COND_OLD = ("      if ((GameSetup_gData.carInfo[j].HudTach != 0) &&\n"
            "          (dh = (int *)&DashHUD_gInfo, dh[j + 7] != 0)) {\n")
COND_LAUNDER = ("      if (GameSetup_gData.carInfo[j].HudTach != 0) {\n"
                "      dh = (int *)&DashHUD_gInfo;\n"
                "      __asm__(\"\" : \"=r\"(dh) : \"0\"(dh));\n"
                "      if (dh[j + 7] != 0) {\n")
BODY_END_OLD = "        Draw_StopRenderingView(*(int *)(j4 + (int)Hud_gTacView));\n      }\n"
BODY_END_NEW = "        Draw_StopRenderingView(*(int *)(j4 + (int)Hud_gTacView));\n      }\n      }\n"

VARIANTS = [
    ("CONTROL B=g T=v do-while", []),
    ("goto-loop T=v", [(DO_OLD, DO_GOTO, 1), (END_V, END_V_GOTO, 1)]),
    ("goto-loop T=g", [(DO_OLD, DO_GOTO, 1), (END_V, END_G_GOTO, 1)]),
    ("T=g + nested-if launder",
     [(T_OLD, T_G, 1), (COND_OLD, COND_LAUNDER, 1), (BODY_END_OLD, BODY_END_NEW, 1)]),
    ("T=v + nested-if launder",
     [(COND_OLD, COND_LAUNDER, 1), (BODY_END_OLD, BODY_END_NEW, 1)]),
]
