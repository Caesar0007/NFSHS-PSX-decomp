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

W1 = """    do {
        JOY_CTRL = (_padSioChan != 0) ? 0x3003 : 0x1003;
    } while (0);"""
W2 = """    do { do {
        JOY_CTRL = (_padSioChan != 0) ? 0x3003 : 0x1003;
    } while (0); } while (0);"""
W3 = """    do { do { do {
        JOY_CTRL = (_padSioChan != 0) ? 0x3003 : 0x1003;
    } while (0); } while (0); } while (0);"""

BASE = [(FIRST_A, C_IDX), (TAIL_A, TAIL_L)]

VARIANTS = [
    ("A control", []),
    ("BASE cast+launder", BASE),
    ("W1 depth-1 wrapper on ctrl", BASE + [(CTRL_A, W1)]),
    ("W2 depth-2 wrapper on ctrl", BASE + [(CTRL_A, W2)]),
    ("W3 depth-3 wrapper on ctrl", BASE + [(CTRL_A, W3)]),
    ("W1 only (no cast/launder)", [(CTRL_A, W1)]),
]
