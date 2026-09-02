NL = chr(10)
F = '    __asm__ __volatile__("");  /* MATCH: Rage Racer CD_dmastart barrier -- keep the DICR read-back serial */' + NL

VARIANTS = [
    ("drop", [(F, "")]),
    ("abs_dummy", [(F, '    dummy &= (dummy | (int)ch);' + NL)]),
    ("abs_dummy2", [(F, ('    dummy &= (dummy | (int)ch);' + NL) * 2)]),
]
