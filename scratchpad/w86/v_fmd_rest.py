SS = '      __asm__("" : "+r" (screenState));\n'
TH = '  __asm__("" : "+r" (this_00));\n'
MG = '  __asm__("" : "+r"(mgr));\n'
FE = '    __asm__("" : : "m"(FEApp));\n'
PN = '             ({ __asm__("" : "+r"(playerNum) : "r"(fWinner)); playerNum; }));\n'

ss_abs = '      screenState &= (screenState | (int)menuDefinitions);\n'
ss_abs2 = '      screenState &= (screenState | (int)carSelectScreen);\n'
th_abs = '  this_00 = (tDialogMessage *)((int)this_00 & ((int)this_00 | (int)&carInfo));\n'
mg_abs = '  mgr = (tCarManager *)((int)mgr & ((int)mgr | (int)mgr));\n'
pn_abs = '             (playerNum & (playerNum | (int)fWinner)));\n'
pn_abs2 = '             (playerNum | (playerNum & (int)fWinner)));\n'

VARIANTS = [
    ("ss_drop", [(SS, "")]),
    ("ss_abs_md", [(SS, ss_abs)]),
    ("ss_abs_cs", [(SS, ss_abs2)]),
    ("th_drop", [(TH, "")]),
    ("th_abs", [(TH, th_abs)]),
    ("mg_drop", [(MG, "")]),
    ("mg_abs_self", [(MG, mg_abs)]),
    ("fe_drop", [(FE, "")]),
    ("pn_abs", [(PN, pn_abs)]),
    ("pn_abs2", [(PN, pn_abs2)]),
    ("pn_drop", [(PN, '             playerNum);\n')]),
]
