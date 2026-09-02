NL = chr(10)
GUARD = ('        if (uVar8 != 8) {' + NL +
         '          /* SYM-CODEGEN-CARRIER: nearLocation -- passing fLocation directly is' + NL)
G_EIGHT = ('        {' + NL +
           '        int eight = 8;' + NL +
           '        if (uVar8 != eight) {' + NL +
           '          eight = 0;' + NL +
           '          /* SYM-CODEGEN-CARRIER: nearLocation -- passing fLocation directly is' + NL)
G_EIGHT2 = ('        {' + NL +
            '        int eight = 8;' + NL +
            '        if (uVar8 != eight) {' + NL +
            '          eight = (int)pSVar10;' + NL +
            '          /* SYM-CODEGEN-CARRIER: nearLocation -- passing fLocation directly is' + NL)
CLOB = '          __asm__("" : "+r"(branchVoice) : : "$2");' + NL
BV = '          branchVoice = pSVar10;' + NL
# the site-1 arm ends before the second `if (uVar8 != 8)` block; close the extra brace there
ARMEND = ('        }' + NL +
          '        /* MATCH strict closure, second duplicated STS arm; see first site. */' + NL)
ARMEND2 = ('        }' + NL +
           '        }' + NL +
           '        /* MATCH strict closure, second duplicated STS arm; see first site. */' + NL)

VARIANTS = [
    ("eight_deadzero_noclob", [(GUARD, G_EIGHT), (ARMEND, ARMEND2), (BV + CLOB, BV)]),
    ("eight_deadptr_noclob", [(GUARD, G_EIGHT2), (ARMEND, ARMEND2), (BV + CLOB, BV)]),
    ("eight_deadzero_keepclob", [(GUARD, G_EIGHT), (ARMEND, ARMEND2)]),
]
