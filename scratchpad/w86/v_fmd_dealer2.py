A = '  __asm__("" : "+r"(commandPtr), "+r"(state));\n'
B = '  __asm__("" : "+r"(menuDefinitions));\n'
C = '  __asm__("" : : "r"(cmdType));\n'
cp_abs = '  commandPtr = (tMenuCommand *)((int)commandPtr & ((int)commandPtr | state));\n'
st_abs = '  state &= (state | (int)commandPtr);\n'
st_abs2 = '  state &= (state | (int)&command);\n'
md_abs = '  menuDefinitions = (tGlobalMenuDefs *)((int)menuDefinitions & ((int)menuDefinitions | (int)carSelectScreen));\n'
ct_abs = '  cmdType &= (cmdType | (int)menuDefinitions);\n'

VARIANTS = [
    ("BC_abs", [(B, md_abs), (C, ct_abs)]),
    ("BC_abs_A_st", [(A, st_abs), (B, md_abs), (C, ct_abs)]),
    ("BC_abs_A_cp", [(A, cp_abs), (B, md_abs), (C, ct_abs)]),
    ("BC_abs_A_cpst", [(A, cp_abs + st_abs), (B, md_abs), (C, ct_abs)]),
    ("BC_abs_A_stcp", [(A, st_abs + cp_abs), (B, md_abs), (C, ct_abs)]),
    ("BC_abs_A_st2", [(A, st_abs2), (B, md_abs), (C, ct_abs)]),
    ("BC_abs_A_drop", [(A, ""), (B, md_abs), (C, ct_abs)]),
]
