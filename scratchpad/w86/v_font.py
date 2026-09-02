NL = chr(10)
P = '                __asm__("" : "=r"(peel) : "0"(peel));' + NL
F = '    __asm__("" : : "i"(0));' + NL

VARIANTS = [
    ("peel_drop", [(P, "")]),
    ("peel_abs_len", [(P, '                peel &= (peel | len);' + NL)]),
    ("peel_absOR_len", [(P, '                peel |= (peel & len);' + NL)]),
    ("peel_abs_buf", [(P, '                peel &= (peel | (int)bufPtr);' + NL)]),
    ("peel_deadre", [(P, ""), ('                if (len != peel) {' + NL, '                if (len != peel) {' + NL + '                    peel = 0;' + NL)]),
    ("void_drop", [(F, "")]),
]
