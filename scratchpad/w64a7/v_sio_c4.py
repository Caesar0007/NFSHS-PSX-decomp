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

# --- cluster-1 dials: demote pseudo 85 (_padSioRegs value, refs2/live4 pri .5)
#     below pseudo 86 (the HImode ctrl constant, refs3/live6 pri .5) ---
CTRL_BASEFIRST = """    {
        volatile unsigned short *ctrl = (volatile unsigned short *)(_padSioRegs + 0x0a);
        *ctrl = (_padSioChan != 0) ? 0x3003 : 0x1003;
    }"""
CTRL_BASELOC = """    {
        unsigned char *sio = _padSioRegs;
        *(volatile unsigned short *)(sio + 0x0a) =
            (_padSioChan != 0) ? 0x3003 : 0x1003;
    }"""
CTRL_FENCE_AFTER = """    JOY_CTRL = (_padSioChan != 0) ? 0x3003 : 0x1003;
    __asm__("" : : "r"(_padSioRegs));"""
CTRL_CFENCE = """    {
        int c = (_padSioChan != 0) ? 0x3003 : 0x1003;
        JOY_CTRL = (unsigned short)c;
        __asm__("" : : "r"(c));
    }"""
CTRL_CFENCE2 = """    {
        unsigned short c = (_padSioChan != 0) ? 0x3003 : 0x1003;
        JOY_CTRL = c;
        __asm__("" : : "r"(c));
    }"""

BASE = [(FIRST_A, C_IDX), (TAIL_A, TAIL_L)]

VARIANTS = [
    ("A control", []),
    ("BASE cast+launder", BASE),
    ("D1 base-ptr-first ctrl", BASE + [(CTRL_A, CTRL_BASEFIRST)]),
    ("D2 base local", BASE + [(CTRL_A, CTRL_BASELOC)]),
    ("D3 fence on _padSioRegs after", BASE + [(CTRL_A, CTRL_FENCE_AFTER)]),
    ("D4 int c + fence", BASE + [(CTRL_A, CTRL_CFENCE)]),
    ("D5 u16 c + fence", BASE + [(CTRL_A, CTRL_CFENCE2)]),
]
