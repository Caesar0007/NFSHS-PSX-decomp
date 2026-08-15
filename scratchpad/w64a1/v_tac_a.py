TU = "recon/game/psx/hud.cpp"
FN = "Hud_RenderTacView__Fv"

E_OLD = "  if (-1 < DashHUD_view[0]) {\n"
E_NEW = "  if (-1 < *(int *)&DashHUD_gInfo) {\n"
B_OLD = "          (dh = (int *)&DashHUD_gInfo, dh[j + 7] != 0)) {\n"
B_NEW = "          (dh = DashHUD_view, dh[j + 7] != 0)) {\n"
T_OLD = "      dh = DashHUD_view;\n    } while (j <= dh[0]);\n"
T_NEW = "      dh = (int *)&DashHUD_gInfo;\n    } while (j <= dh[0]);\n"

E = [(E_OLD, E_NEW, 1)]
B = [(B_OLD, B_NEW, 1)]
T = [(T_OLD, T_NEW, 1)]

VARIANTS = [
    ("CONTROL  E=v B=g T=v", []),
    ("E=g B=g T=v", E),
    ("E=v B=v T=v", B),
    ("E=g B=v T=v", E + B),
    ("E=v B=g T=g", T),
    ("E=g B=g T=g", E + T),
    ("E=v B=v T=g", B + T),
    ("E=g B=v T=g", E + B + T),
]
