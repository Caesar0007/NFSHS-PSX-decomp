Y1 = ('      __asm__("" : : "r"(yOffset));\n')
Y2 = ('        __asm__("" : : "r"(yOffset));\n')
SF = '          __asm__("" : "+&r"(shapeFade) : "r"(shapeTicks), "r"(fadeBase));\n'


def y(ind, q, n=1):
    return ''.join('%syOffset &= (yOffset | %s);\n' % (ind, q) for _ in range(n))


VARIANTS = [
    ("y1_drop", [(Y1, "")]),
    ("y1_abs_i", [(Y1, y('      ', 'i'))]),
    ("y1_abs_i2", [(Y1, y('      ', 'i', 2))]),
    ("y1_abs_up", [(Y1, y('      ', '(int)carInfo.fUpgrades'))]),
    ("both_abs_i", [(Y1, y('      ', 'i')), (Y2, y('        ', 'j'))]),
    ("sf_drop", [(SF, "")]),
    ("sf_abs", [(SF, '          shapeFade &= (shapeFade | shapeTicks);\n')]),
    ("sf_abs2", [(SF, '          shapeFade &= (shapeFade | fadeBase);\n')]),
    ("sf_abs3", [(SF, '          shapeFade &= (shapeFade | shapeTicks);\n          shapeFade &= (shapeFade | fadeBase);\n')]),
]
