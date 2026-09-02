NL = chr(10)
GUARD = ('        if (uVar8 != 8) {' + NL +
         '          /* SYM-CODEGEN-CARRIER: nearLocation -- passing fLocation directly is' + NL)


def g(dead):
    return ('        int eight = 8;' + NL +
            '        if (uVar8 != eight) {' + NL +
            ('          eight = %s;' % dead) + NL +
            '          /* SYM-CODEGEN-CARRIER: nearLocation -- passing fLocation directly is' + NL)


CLOB = '          __asm__("" : "+r"(branchVoice) : : "$2");' + NL
BV = '          branchVoice = pSVar10;' + NL

VARIANTS = [
    ("eight0_noclob", [(GUARD, g('0')), (BV + CLOB, BV)]),
    ("eightPtr_noclob", [(GUARD, g('(int)pSVar10')), (BV + CLOB, BV)]),
    ("eightUV_noclob", [(GUARD, g('(int)uVar8')), (BV + CLOB, BV)]),
    ("eight0_keepclob", [(GUARD, g('0'))]),
]
