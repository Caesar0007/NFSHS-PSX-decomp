ST = '    __asm__("" : "+r" (selectedTourney));\n'
st_abs = '    selectedTourney = (tTourneyInfo *)((int)selectedTourney & ((int)selectedTourney | (int)manager));\n'
st_abs2 = '    selectedTourney = (tTourneyInfo *)((int)selectedTourney & ((int)selectedTourney | amount));\n'
st_abs3 = '    selectedTourney = (tTourneyInfo *)((int)selectedTourney | ((int)selectedTourney & (int)manager));\n'
st_abs4 = '    selectedTourney = (tTourneyInfo *)((int)selectedTourney & ((int)selectedTourney | (int)tourn));\n'
st_abs5 = '    selectedTourney = (tTourneyInfo *)((int)selectedTourney & ((int)selectedTourney | (int)frontEndState));\n'

VARIANTS = [
    ("tourn_st_drop", [(ST, "")]),
    ("tourn_st_abs_mgr", [(ST, st_abs)]),
    ("tourn_st_abs_amt", [(ST, st_abs2)]),
    ("tourn_st_absOR", [(ST, st_abs3)]),
    ("tourn_st_abs_tourn", [(ST, st_abs4)]),
    ("tourn_st_abs_fes", [(ST, st_abs5)]),
]
