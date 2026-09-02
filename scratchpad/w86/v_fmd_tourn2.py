F = ('  __asm__("" : : "r"(manager), "r"(manager), "r"(manager), "r"(manager),\n'
     '          "r"(manager), "r"(manager));\n')
TIER = "  frontEndState->tier = '\0';\n"
TOURN = '  tourn = &manager->fDefinition->fTournaments[\n'
def m(w): return f'  manager = (tTournamentManager *)((int)manager & ((int)manager | (int){w}));\n'
def f(w): return f'  frontEndState = (tfrontEnd *)((int)frontEndState & ((int)frontEndState | (int){w}));\n'
VARIANTS=[
 ("m_fes_afterTier", [(F,""),(TIER, TIER + m('frontEndState'))]),
 ("m_fes_beforeTourn", [(F,""),(TOURN, m('frontEndState') + TOURN)]),
 ("m_fes_x2_split", [(F, m('frontEndState')),(TIER, TIER + m('frontEndState'))]),
 ("fes_m_pre", [(F, f('manager'))]),
 ("fes_m_afterTier", [(F,""),(TIER, TIER + f('manager'))]),
 ("m_fes_or", [(F, '  manager = (tTournamentManager *)((int)manager | ((int)manager & (int)frontEndState));\n')]),
 ("m_fesbase", [(F, m('frontEndBase'))]),
 ("m_cmd", [(F, m('&command'))]),
 ("both_m_fes_and_fes_m", [(F, m('frontEndState') + f('manager'))]),
 ("m_fes_pre_tierlast", [(F, m('frontEndState')),(TIER, "")]),
]
