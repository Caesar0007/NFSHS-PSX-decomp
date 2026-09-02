BS = chr(92)
F = ('  __asm__("" : : "r"(manager), "r"(manager), "r"(manager), "r"(manager),\n'
     '          "r"(manager), "r"(manager));\n')
M = '  manager = (tTournamentManager *)((int)manager & ((int)manager | (int)frontEndState));\n'
TIER = "  frontEndState->tier = '" + BS + "0';\n"
TOURN = ('  tourn = &manager->fDefinition->fTournaments[\n'
         '      (uint)manager->fDefinition->fTiers[0].fTournOffset +\n'
         '      (uint)(byte)frontEndState->tournament];\n')
AMT = '  amount = tourn->fEntranceFee;\n'
GUARD = '  if (0 < amount) {\n'

VARIANTS = [
    ("abs_tierAfterAmt", [(F, M), (TIER, ""), (AMT, AMT + TIER)]),
    ("fenc_tierAfterAmt", [(TIER, ""), (AMT, AMT + TIER)]),
    ("abs_tierAfterGuard", [(F, M), (TIER, ""), (GUARD, GUARD + "  " + TIER)]),
    ("abs_tierAfterAmt_absAfterTier", [(F, ""), (TIER, ""), (AMT, AMT + TIER + M)]),
    ("abs_tierAfterAmt_absBeforeTier", [(F, ""), (TIER, ""), (AMT, AMT + M + TIER)]),
    ("abs_tierAfterAmt_x2", [(F, M), (TIER, ""), (AMT, AMT + TIER + M)]),
    ("nofence_tierAfterAmt", [(F, ""), (TIER, ""), (AMT, AMT + TIER)]),
]
