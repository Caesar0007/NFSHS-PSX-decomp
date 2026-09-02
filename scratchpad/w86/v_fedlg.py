A = ('    long loadedTicks = ::ticks[0];\n'
     '    ticks = loadedTicks;\n'
     '    __asm__("" : "+r"(loadedTicks));\n')
B = '    __asm__("" : : "r"(ticks));\n'

VARIANTS = [
    ("a_drop", [(A, '    long loadedTicks = ::ticks[0];\n    ticks = loadedTicks;\n')]),
    ("a_abs_ft", [(A, '    long loadedTicks = ::ticks[0];\n    ticks = loadedTicks & (loadedTicks | firstTick);\n')]),
    ("a_absOR_ft", [(A, '    long loadedTicks = ::ticks[0];\n    ticks = loadedTicks | (loadedTicks & firstTick);\n')]),
    ("a_abs_this", [(A, '    long loadedTicks = ::ticks[0];\n    ticks = loadedTicks & (loadedTicks | (long)(int)this);\n')]),
    ("b_drop", [(B, "")]),
    ("b_abs_ft", [(B, '    ticks &= (ticks | firstTick);\n')]),
    ("b_abs_ft2", [(B, '    ticks &= (ticks | firstTick);\n    ticks &= (ticks | firstTick);\n')]),
    ("b_abs_nl", [(B, '    ticks &= (ticks | numLetters);\n')]),
    ("both_abs", [(A, '    long loadedTicks = ::ticks[0];\n    ticks = loadedTicks & (loadedTicks | firstTick);\n'), (B, '    ticks &= (ticks | firstTick);\n')]),
]
