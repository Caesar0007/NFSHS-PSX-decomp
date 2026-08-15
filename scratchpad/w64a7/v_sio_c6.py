FIRST_A = """        int fix = _padFixResult[_padSioChan];"""
C_IDX = """        int fix = *(int *)((_padSioChan << 2) + (int)_padFixResult);"""
C_IDX_FB = """        int *fb = _padFixResult;
        int fix = *(int *)((_padSioChan << 2) + (int)_padFixResult);"""
C_IDX_FBL = """        int *fb = _padFixResult;
        int fix = *(int *)((_padSioChan << 2) + (int)_padFixResult);
        __asm__("" : "=r"(fb) : "0"(fb));"""
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
SET_A = """    setRC2wait(info[0xe8] == 8 ? 0x50 : 0x91);
    JOY_CTRL = (_padSioChan != 0) ? 0x3003 : 0x1003;"""
W_BOTH = """    do {
        setRC2wait(info[0xe8] == 8 ? 0x50 : 0x91);
        JOY_CTRL = (_padSioChan != 0) ? 0x3003 : 0x1003;
    } while (0);"""

LOOP_A = """        if (fix >= 0) {
            if (fix > 0) {
                do {
                    --_padFixResult[_padSioChan];
                    _padFuncRecvAuto(*(unsigned char **)(info + 0xc) +
                                     _padFixResult[_padSioChan] * 0xf0);
                } while (_padFixResult[_padSioChan] > 0);
            }
            if (_padFixResult[_padSioChan] == 0) {
                _padFixResult[_padSioChan] = -1;
                _padFuncRecvAuto(info);
                _padFuncClrCmdNo(info);
            }
        }"""
LOOP_FB = """        if (fix >= 0) {
            if (fix > 0) {
                do {
                    --fb[_padSioChan];
                    _padFuncRecvAuto(*(unsigned char **)(info + 0xc) +
                                     fb[_padSioChan] * 0xf0);
                } while (fb[_padSioChan] > 0);
            }
            if (fb[_padSioChan] == 0) {
                fb[_padSioChan] = -1;
                _padFuncRecvAuto(info);
                _padFuncClrCmdNo(info);
            }
        }"""

BASE = [(FIRST_A, C_IDX), (TAIL_A, TAIL_L), (CTRL_A, W1)]

VARIANTS = [
    ("W1 base (=20)", BASE),
    ("X1 +fb plain", [(FIRST_A, C_IDX_FB), (TAIL_A, TAIL_L), (CTRL_A, W1),
                      (LOOP_A, LOOP_FB)]),
    ("X2 +fb laundered", [(FIRST_A, C_IDX_FBL), (TAIL_A, TAIL_L), (CTRL_A, W1),
                          (LOOP_A, LOOP_FB)]),
    ("X3 wrapper over setRC2wait+ctrl",
     [(FIRST_A, C_IDX), (TAIL_A, TAIL_L), (SET_A, W_BOTH)]),
]
