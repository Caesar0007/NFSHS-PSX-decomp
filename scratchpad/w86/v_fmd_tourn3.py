F = ('  __asm__("" : : "r"(manager), "r"(manager), "r"(manager), "r"(manager),\n'
     '          "r"(manager), "r"(manager));\n')
TIER = "  frontEndState->tier = '\\0';\n"
TOURNBLK = ('  tourn = &manager->fDefinition->fTournaments[\n'
            '      (uint)manager->fDefinition->fTiers[0].fTournOffset +\n'
            '      (uint)(byte)frontEndState->tournament];\n')
AMT = '  amount = tourn->fEntranceFee;\n'
M = '  manager = (tTournamentManager *)((int)manager & ((int)manager | (int)frontEndState));\n'
VARIANTS=[
 ("abs_tierAfterTourn", [(F, M), (TIER, ""), (AMT, TIER + AMT)]),
 ("abs_tierAfterTournBlk", [(F, M), (TIER, ""), (AMT, TIER + AMT)]),
 ("abs_tierAfterAmt", [(F, M), (TIER, ""), (AMT, AMT + TIER)]),
 ("fence_tierAfterAmt", [(TIER, ""), (AMT, AMT + TIER)]),
 ("abs_after_tier", [(F, ""), (TIER, TIER + M)]),
 ("abs_before_amt", [(F, ""), (AMT, M + AMT)]),
 ("abs_x2_pre_and_tier", [(F, M), (TIER, TIER + M)]),
]
