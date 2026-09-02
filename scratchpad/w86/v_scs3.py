Y1 = '      __asm__("" : : "r"(yOffset));\n'
Y2 = '        __asm__("" : : "r"(yOffset));\n'
A1 = '      yOffset &= (yOffset | i);\n'

VARIANTS = [
    ("y2_drop_only", [(Y2, "")]),
    ("y2_abs_j", [(Y2, '        yOffset &= (yOffset | j);\n')]),
    ("y2_abs_j_y1abs", [(Y1, A1), (Y2, '        yOffset &= (yOffset | j);\n')]),
    ("y2_abs_up_y1abs", [(Y1, A1), (Y2, '        yOffset &= (yOffset | (int)carInfo.fUpgrades);\n')]),
    ("y2_absOR_j_y1abs", [(Y1, A1), (Y2, '        yOffset |= (yOffset & j);\n')]),
    ("y2_abs_j2_y1abs", [(Y1, A1), (Y2, '        yOffset &= (yOffset | j);\n        yOffset &= (yOffset | j);\n')]),
]
