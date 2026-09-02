P = ('            bool pulled = done;\n'
     '            __asm__("" : "=r"(pulled) : "0"(pulled));\n')
VL = '    __asm__("" : "+r"(shifted), "+r"(x));\n'
HL = '    __asm__("" : "+r"(shifted));\n'

VARIANTS = [
    ("pulled_drop", [(P, '            bool pulled = done;\n')]),
    ("pulled_abs_i", [(P, '            bool pulled = (bool)((int)done & ((int)done | i));\n')]),
    ("pulled_abs_fn", [(P, '            bool pulled = (bool)((int)done & ((int)done | filenum));\n')]),
    ("pulled_absOR", [(P, '            bool pulled = (bool)((int)done | ((int)done & filenum));\n')]),
    ("vl_drop", [(VL, "")]),
    ("vl_abs", [(VL, '    shifted &= (shifted | (unsigned int)x);\n')]),
    ("vl_abs2", [(VL, '    shifted &= (shifted | (unsigned int)x);\n    x &= (x | (int)shifted);\n')]),
    ("hl_drop", [(HL, "")]),
    ("hl_abs", [(HL, '    shifted &= (shifted | (unsigned int)test);\n')]),
    ("hl_abs_pos", [(HL, '    shifted &= (shifted | (unsigned int)pos);\n')]),
]
