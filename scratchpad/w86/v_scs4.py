Y1 = '      __asm__("" : : "r"(yOffset));\n'
Y2 = '        __asm__("" : : "r"(yOffset));\n'
A1 = '      yOffset &= (yOffset | i);\n'
A2 = '        yOffset &= (yOffset | i);\n'

VARIANTS = [
    ("y2_abs_i_keepy1", [(Y2, A2)]),
    ("both_abs_i", [(Y1, A1), (Y2, A2)]),
    ("y1_abs_i_only", [(Y1, A1)]),
    ("y2_abs_i_x2_keepy1", [(Y2, A2 + A2)]),
]
