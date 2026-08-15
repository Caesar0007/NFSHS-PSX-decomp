FIRST_A = """        int fix = _padFixResult[_padSioChan];"""
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

# cast first-read + a laundered base local carrying the loop accesses
CAST_FB = """        int *fb = _padFixResult;
        int fix = *(int *)((_padSioChan << 2) + (int)_padFixResult);
        __asm__("" : "=r"(fb) : "0"(fb));"""
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
LOOP_FB2 = """        if (fix >= 0) {
            if (fix > 0) {
                do {
                    --fb[_padSioChan];
                    _padFuncRecvAuto(*(unsigned char **)(info + 0xc) +
                                     fb[_padSioChan] * 0xf0);
                } while (fb[_padSioChan] > 0);
            }
            if (_padFixResult[_padSioChan] == 0) {
                _padFixResult[_padSioChan] = -1;
                _padFuncRecvAuto(info);
                _padFuncClrCmdNo(info);
            }
        }"""
CAST_ONLY = """        int fix = *(int *)((_padSioChan << 2) + (int)_padFixResult);"""

VARIANTS = [
    ("A control", []),
    ("K cast+fb-launder(all)+L",
     [(FIRST_A, CAST_FB), (LOOP_A, LOOP_FB), (TAIL_A, TAIL_L)]),
    ("K2 cast+fb-launder(loop only)+L",
     [(FIRST_A, CAST_FB), (LOOP_A, LOOP_FB2), (TAIL_A, TAIL_L)]),
    ("K3 cast+fb-nolaunder(all)+L",
     [(FIRST_A, "        int *fb = _padFixResult;\n" + CAST_ONLY),
      (LOOP_A, LOOP_FB), (TAIL_A, TAIL_L)]),
]
