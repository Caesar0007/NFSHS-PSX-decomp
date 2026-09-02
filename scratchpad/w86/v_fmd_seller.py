A = '  __asm__("" : "+r"(commandPtr), "+r"(state));\n'
B = '  __asm__("" : "+r"(menuDefinitions));\n'
C = '  __asm__("" : : "r"(cmdType));\n'
md_abs = '  menuDefinitions = (tGlobalMenuDefs *)((int)menuDefinitions & ((int)menuDefinitions | (int)carSelectScreen));\n'
ct_abs = '  cmdType &= (cmdType | (int)menuDefinitions);\n'
st_abs = '  state &= (state | (int)commandPtr);\n'
cp_abs = '  commandPtr = (tMenuCommand *)((int)commandPtr & ((int)commandPtr | state));\n'

VARIANTS = [
    ("dealer_recipe", [(A, ""), (B, md_abs), (C, ct_abs)]),
    ("BC_abs_keepA", [(B, md_abs), (C, ct_abs)]),
    ("BC_abs_A_st", [(A, st_abs), (B, md_abs), (C, ct_abs)]),
    ("B_abs_only", [(B, md_abs)]),
    ("dropAll", [(A, ""), (B, ""), (C, "")]),
]
