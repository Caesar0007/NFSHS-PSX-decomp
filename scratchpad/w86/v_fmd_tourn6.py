F = ('  __asm__("" : : "r"(manager), "r"(manager), "r"(manager), "r"(manager),\n'
     '          "r"(manager), "r"(manager));\n')
M1 = '  manager = &tournamentManager;\n'
M2 = '  frontEndState = frontEndBase;\n'
ABS = '  manager = (tTournamentManager *)((int)manager & ((int)manager | (int)frontEndState));\n'
ABSF = '  frontEndState = (tfrontEnd *)((int)frontEndState & ((int)frontEndState | (int)manager));\n'
DECLFE = '  tfrontEnd *frontEndState;\n'
DECLMG = '  tTournamentManager *manager;\n'

VARIANTS = [
    ("swapinit_abs", [(M1 + M2, M2 + M1), (F, ABS)]),
    ("swapinit_fence", [(M1 + M2, M2 + M1)]),
    ("abs_then_fe", [(M1 + M2 + F, M1 + ABS + M2)]),
    ("fe_abs_after", [(M1 + M2 + F, M1 + M2 + ABS + ABSF)]),
    ("absF_only", [(F, ABSF)]),
    ("abs_and_absF", [(F, ABS + ABSF)]),
    ("absF_and_abs", [(F, ABSF + ABS)]),
    ("fenceplus_absF", [(F, F + ABSF)]),
]
