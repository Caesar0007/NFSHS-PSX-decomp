V = '  player = *(volatile u_char *)&FEApp->fInputPlayer;\n'
MG = '  __asm__("" : "+r"(mgr));\n'
PN = '             ({ __asm__("" : "+r"(playerNum) : "r"(fWinner)); playerNum; }));\n'

VARIANTS = [
    ("v_plain", [(V, '  player = FEApp->fInputPlayer;\n')]),
    ("v_abs_defs", [(V, '  player = FEApp->fInputPlayer & (FEApp->fInputPlayer | (u_int)(int)menuDefs[0]);\n')]),
    ("v_abs_fe", [(V, '  player = FEApp->fInputPlayer & (FEApp->fInputPlayer | (u_int)(int)FEApp);\n')]),
    ("v_absOR_fe", [(V, '  player = FEApp->fInputPlayer | (FEApp->fInputPlayer & (u_int)(int)FEApp);\n')]),
    ("award_mgrdrop_pnabs", [(MG, ""), (PN, '             (playerNum & (playerNum | (int)&carManager)));\n')]),
    ("award_mgrabs_pnabs", [(MG, '  mgr = (tCarManager *)((int)mgr & ((int)mgr | (int)&frontEnd));\n'),
                            (PN, '             (playerNum & (playerNum | (int)&carManager)));\n')]),
    ("award_pnabs_cm", [(PN, '             (playerNum & (playerNum | (int)&carManager)));\n')]),
    ("award_mgrabs_only", [(MG, '  mgr = (tCarManager *)((int)mgr & ((int)mgr | (int)&frontEnd));\n')]),
]
