F = ('  __asm__("" : : "r"(manager), "r"(manager), "r"(manager), "r"(manager),\n'
     '          "r"(manager), "r"(manager));\n')
ST = '    __asm__("" : "+r" (selectedTourney));\n'
AMT = '  amount = tourn->fEntranceFee;\n'
def mabs(w,n): return ''.join(f'  manager = (tTournamentManager *)((int)manager & ((int)manager | (int){w}));\n' for _ in range(n))
VARIANTS=[("drop_mgr",[(F,"")]), ("drop_st",[(ST,"")]), ("drop_both",[(F,""),(ST,"")])]
for n in (1,2,4,6):
    VARIANTS.append((f"absMgr_fes{n}", [(F, mabs('frontEndState',n))]))
for n in (1,2,4,6):
    VARIANTS.append((f"absMgr_tourn{n}", [(F,""), (AMT, mabs('tourn',n) + AMT)]))
VARIANTS.append(("absSt_tourn", [(ST, '    selectedTourney = (tTourneyInfo *)((int)selectedTourney & ((int)selectedTourney | (int)manager));\n')]))
VARIANTS.append(("absSt_amount", [(ST, '    selectedTourney = (tTourneyInfo *)((int)selectedTourney & ((int)selectedTourney | (int)amount));\n')]))
