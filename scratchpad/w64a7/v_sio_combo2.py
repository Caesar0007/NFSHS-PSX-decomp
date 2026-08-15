FIRST_A = """        int fix = _padFixResult[_padSioChan];"""
C_IDX = """        int fix = *(int *)((_padSioChan << 2) + (int)_padFixResult);"""
C_BASE = """        int fix = *(int *)((int)_padFixResult + (_padSioChan << 2));"""

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
    ("Cb base-first cast", [(FIRST_A, C_BASE)]),
    ("Cb+L base-first + launder", [(FIRST_A, C_BASE), (TAIL_A, TAIL_L)]),
    ("Ci+L idx-first + launder", [(FIRST_A, C_IDX), (TAIL_A, TAIL_L)]),
]
