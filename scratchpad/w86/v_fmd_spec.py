F = ('  __asm__("" : : "r"(frontEndState), "r"(manager), "r"(manager), "r"(manager),\n'
     '          "r"(manager), "r"(manager), "r"(manager));\n')
ST = '    __asm__("" : "+r" (selectedTourney));\n'
m_abs = '  manager = (tTournamentManager *)((int)manager & ((int)manager | (int)frontEndState));\n'
f_abs = '  frontEndState = (tfrontEnd *)((int)frontEndState & ((int)frontEndState | (int)manager));\n'
st_abs = '    selectedTourney = (tTourneyInfo *)((int)selectedTourney & ((int)selectedTourney | (int)manager));\n'
st_abs2 = '    selectedTourney = (tTourneyInfo *)((int)selectedTourney & ((int)selectedTourney | amount));\n'

VARIANTS = [
    ("drop", [(F, "")]),
    ("m_abs", [(F, m_abs)]),
    ("f_abs", [(F, f_abs)]),
    ("m_then_f", [(F, m_abs + f_abs)]),
    ("f_then_m", [(F, f_abs + m_abs)]),
    ("m_abs_st_abs", [(F, m_abs), (ST, st_abs)]),
    ("st_abs_only", [(ST, st_abs)]),
    ("st_abs2_only", [(ST, st_abs2)]),
    ("st_drop", [(ST, "")]),
]
