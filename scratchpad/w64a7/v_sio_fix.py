ANCHOR = """    {
        int fix = _padFixResult[_padSioChan];
        if (fix >= 0) {
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
        }
    }
"""

ELEM = """    {
        int *fp = &_padFixResult[_padSioChan];
        int fix = *fp;
        if (fix >= 0) {
            if (fix > 0) {
                do {
                    --*fp;
                    _padFuncRecvAuto(*(unsigned char **)(info + 0xc) + *fp * 0xf0);
                } while (*fp > 0);
            }
            if (*fp == 0) {
                *fp = -1;
                _padFuncRecvAuto(info);
                _padFuncClrCmdNo(info);
            }
        }
    }
"""

CHANLOC = """    {
        int ch = _padSioChan;
        int fix = _padFixResult[ch];
        if (fix >= 0) {
            if (fix > 0) {
                do {
                    --_padFixResult[ch];
                    _padFuncRecvAuto(*(unsigned char **)(info + 0xc) +
                                     _padFixResult[ch] * 0xf0);
                } while (_padFixResult[ch] > 0);
            }
            if (_padFixResult[ch] == 0) {
                _padFixResult[ch] = -1;
                _padFuncRecvAuto(info);
                _padFuncClrCmdNo(info);
            }
        }
    }
"""

CAST = """    {
        int fix = _padFixResult[_padSioChan];
        if (fix >= 0) {
            if (fix > 0) {
                do {
                    --*(int *)((_padSioChan << 2) + (int)_padFixResult);
                    _padFuncRecvAuto(*(unsigned char **)(info + 0xc) +
                                     *(int *)((_padSioChan << 2) + (int)_padFixResult) * 0xf0);
                } while (*(int *)((_padSioChan << 2) + (int)_padFixResult) > 0);
            }
            if (_padFixResult[_padSioChan] == 0) {
                _padFixResult[_padSioChan] = -1;
                _padFuncRecvAuto(info);
                _padFuncClrCmdNo(info);
            }
        }
    }
"""

VARIANTS = [
    ("A control", ANCHOR),
    ("B elem-ptr local (vars=0 regs=3)", ELEM),
    ("C chan local (vars=0 regs=4)", CHANLOC),
    ("D cast-int addr (vars=0 regs=2)", CAST),
]
