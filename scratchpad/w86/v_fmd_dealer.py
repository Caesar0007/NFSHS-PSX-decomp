A = '  __asm__("" : "+r"(commandPtr), "+r"(state));\n'
B = '  __asm__("" : "+r"(menuDefinitions));\n'
C = '  __asm__("" : : "r"(cmdType));\n'

# absorption spellings (semantic no-ops: x & (x|y) == x, x | (x&y) == x)
cp_abs = '  commandPtr = (tMenuCommand *)((int)commandPtr & ((int)commandPtr | state));\n'
st_abs = '  state &= (state | (int)commandPtr);\n'
md_abs = '  menuDefinitions = (tGlobalMenuDefs *)((int)menuDefinitions & ((int)menuDefinitions | (int)carSelectScreen));\n'
ct_abs = '  cmdType &= (cmdType | (int)menuDefinitions);\n'
ct_abs2 = '  cmdType &= (cmdType | (int)commandPtr);\n'

VARIANTS = [
    ("dropA", [(A, "")]),
    ("dropB", [(B, "")]),
    ("dropC", [(C, "")]),
    ("dropAll", [(A, ""), (B, ""), (C, "")]),
    ("A->abs_both", [(A, cp_abs + st_abs)]),
    ("A->abs_cp", [(A, cp_abs)]),
    ("A->abs_st", [(A, st_abs)]),
    ("B->abs", [(B, md_abs)]),
    ("C->abs_md", [(C, ct_abs)]),
    ("C->abs_cp", [(C, ct_abs2)]),
    ("ABC->abs", [(A, cp_abs + st_abs), (B, md_abs), (C, ct_abs)]),
    ("BC->abs_keepA", [(B, md_abs), (C, ct_abs)]),
]
