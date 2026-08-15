FIRST_A = """        int fix = _padFixResult[_padSioChan];"""
FP0 = """        int *fp0 = &_padFixResult[_padSioChan];
        int fix = *fp0;
        __asm__("" : : "r"(fp0));"""
C_IDX = """        int fix = *(int *)((_padSioChan << 2) + (int)_padFixResult);"""
CHANT = """        int fix;
        {
            int c = _padSioChan;
            fix = *(int *)((c << 2) + (int)_padFixResult);
        }"""
TAIL_A = """    if (info[0x36] != 0)
        return 0;
    return 1;
}"""
TAIL_L = """    if (info[0x36] != 0)
        return 0;
    {
        int one = 1;
        __asm__("" : "=r"(one) : "0"(one));
        return one;
    }
}"""

VARIANTS = [
    ("A control", []),
    ("F fp0+fence", [(FIRST_A, FP0)]),
    ("F+L fp0+fence+launder", [(FIRST_A, FP0), (TAIL_A, TAIL_L)]),
    ("H chantemp+cast", [(FIRST_A, CHANT)]),
    ("H+L chantemp+cast+launder", [(FIRST_A, CHANT), (TAIL_A, TAIL_L)]),
]
