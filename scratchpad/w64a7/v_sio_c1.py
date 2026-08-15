FIRST_A = """        int fix = _padFixResult[_padSioChan];"""
C_IDX = """        int fix = *(int *)((_padSioChan << 2) + (int)_padFixResult);"""
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

CTRL_A = """    JOY_CTRL = (_padSioChan != 0) ? 0x3003 : 0x1003;"""
CTRL_NAMED = """    {
        unsigned short c = (_padSioChan != 0) ? 0x3003 : 0x1003;
        JOY_CTRL = c;
    }"""
CTRL_INT = """    {
        int c = (_padSioChan != 0) ? 0x3003 : 0x1003;
        JOY_CTRL = (unsigned short)c;
    }"""
CTRL_IFELSE = """    if (_padSioChan != 0)
        JOY_CTRL = 0x3003;
    else
        JOY_CTRL = 0x1003;"""
CTRL_BARE = """    JOY_CTRL = _padSioChan ? 0x3003 : 0x1003;"""

BASE = [(FIRST_A, C_IDX), (TAIL_A, TAIL_L)]

VARIANTS = [
    ("A control", []),
    ("base (cast+launder)", BASE),
    ("+ctrl named u16", BASE + [(CTRL_A, CTRL_NAMED)]),
    ("+ctrl named int", BASE + [(CTRL_A, CTRL_INT)]),
    ("+ctrl if/else", BASE + [(CTRL_A, CTRL_IFELSE)]),
    ("+ctrl bare cond", BASE + [(CTRL_A, CTRL_BARE)]),
]
