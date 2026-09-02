L = '  __asm__("" : "=r"(currentItemValue) : "0"(currentItemValue));\n  currentItem = currentItemValue;\n'
T = '(tMenuItem *)'
Y1 = '      __asm__("" : : "r"(yOffset));\n'
CI = '    __asm__("" : : "r"(currentItem));\n'

VARIANTS = [
    ("drop", [(L, '  currentItem = currentItemValue;\n')]),
    ("abs_md", [(L, '  currentItem = %s((int)currentItemValue & ((int)currentItemValue | (int)menuDefs));\n' % T)]),
    ("absor_md", [(L, '  currentItem = %s((int)currentItemValue | ((int)currentItemValue & (int)menuDefs));\n' % T)]),
    ("abs_fe", [(L, '  currentItem = %s((int)currentItemValue & ((int)currentItemValue | (int)FEApp));\n' % T)]),
    ("abs_self_then_copy", [(L, '  currentItemValue = %s((int)currentItemValue & ((int)currentItemValue | (int)menuDefs));\n  currentItem = currentItemValue;\n' % T)]),
    ("ci_drop", [(CI, "")]),
    ("ci_abs", [(CI, '    currentItem = (tMenuItem *)((int)currentItem & ((int)currentItem | (int)menuDefs));\n')]),
]
