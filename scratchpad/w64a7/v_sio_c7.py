FIRST_A = """        int fix = _padFixResult[_padSioChan];"""
C_IDX = """        int fix = *(int *)((_padSioChan << 2) + (int)_padFixResult);"""
C_VOL = """        int fix = *(volatile int *)&_padFixResult[_padSioChan];"""
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

BAUD_A = """    JOY_BAUD = 0x88;
    setRC2wait(info[0xe8] == 8 ? 0x50 : 0x91);
    JOY_CTRL = (_padSioChan != 0) ? 0x3003 : 0x1003;"""
W_BAUD = """    JOY_BAUD = 0x88;
    setRC2wait(info[0xe8] == 8 ? 0x50 : 0x91);
    do {
        JOY_CTRL = (_padSioChan != 0) ? 0x3003 : 0x1003;
        {"""
FIXOPEN = """    /* drain any queued auto-mode recv fix-ups for this channel */
    {
        int fix = *(int *)((_padSioChan << 2) + (int)_padFixResult);"""

BASE = [(FIRST_A, C_IDX), (TAIL_A, TAIL_L), (CTRL_A, W1)]

VARIANTS = [
    ("W1 base (=20)", BASE),
    ("Y1 vol first-read + W1", [(FIRST_A, C_VOL), (TAIL_A, TAIL_L), (CTRL_A, W1)]),
    ("Y2 W1 without launder", [(FIRST_A, C_IDX), (CTRL_A, W1)]),
    ("Y3 W1 without cast", [(TAIL_A, TAIL_L), (CTRL_A, W1)]),
]
