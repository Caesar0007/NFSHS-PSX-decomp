FIRST_A = """        int fix = _padFixResult[_padSioChan];"""
FIRST_CAST = """        int fix = *(int *)((_padSioChan << 2) + (int)_padFixResult);"""
FIRST_VOL = """        int fix = *(volatile int *)&_padFixResult[_padSioChan];"""

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
    ("D cast", [(FIRST_A, FIRST_CAST)]),
    ("L launder", [(TAIL_A, TAIL_L)]),
    ("D+L cast+launder", [(FIRST_A, FIRST_CAST), (TAIL_A, TAIL_L)]),
    ("E+L vol+launder", [(FIRST_A, FIRST_VOL), (TAIL_A, TAIL_L)]),
]
