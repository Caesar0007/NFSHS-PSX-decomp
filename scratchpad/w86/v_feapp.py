N = '            __asm__("" : : "r"(needToSetChildMenu));\n'
C = '          __asm__("" : : "r"(&command[0]));\n'
T = '      __asm__("" : : "r"(currentTicks));\n'

VARIANTS = [
    ("n_drop", [(N, "")]),
    ("n_abs_i", [(N, '            needToSetChildMenu = (bool)((int)needToSetChildMenu | ((int)needToSetChildMenu & i));\n')]),
    ("n_abs_i_and", [(N, '            needToSetChildMenu = (bool)((int)needToSetChildMenu & ((int)needToSetChildMenu | i));\n')]),
    ("t_drop", [(T, "")]),
    ("t_abs_tick", [(T, '      currentTicks &= (currentTicks | tick);\n')]),
    ("t_abs_tick2", [(T, '      currentTicks &= (currentTicks | tick);\n      currentTicks &= (currentTicks | tick);\n')]),
    ("c_drop", [(C, "")]),
]
