from fr import frame

hdr = open('hdr.txt', errors='replace').read()
body = open('fnbody.txt', errors='replace').read()
i0 = body.index('    {\n        int fix')
i1 = body.index('    if (((*(volatile unsigned short *)(_padSioRegs + 0x04)) & 0x200) != 0) {')
PRE, ORIG, POST = body[:i0], body[i0:i1], body[i1:]


def mk(fixblk, tag):
    open('v.i', 'w').write(hdr + '\n' + PRE + fixblk + POST + '\n')
    print('%-46s %s' % (tag, frame('v.i', '_padInitSioMode')))


mk(ORIG, 'ORIG')

V = {}
# 1. base pointer local, hoisted out of the whole block
V['base ptr local'] = '''    {
        int *fr = _padFixResult;
        int fix = fr[_padSioChan];
        if (fix >= 0) {
            if (fix > 0) {
                do {
                    --fr[_padSioChan];
                    _padFuncRecvAuto(*(unsigned char **)(info + 0xc) +
                                     fr[_padSioChan] * 0xf0);
                } while (fr[_padSioChan] > 0);
            }
            if (fr[_padSioChan] == 0) {
                fr[_padSioChan] = -1;
                _padFuncRecvAuto(info);
                _padFuncClrCmdNo(info);
            }
        }
    }
'''
# 2. element pointer local
V['elem ptr local'] = '''    {
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
'''
# 3. channel cached in a local
V['chan local'] = '''    {
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
'''
# 4. loop test on a local re-read each iteration
V['local n test'] = '''    {
        int fix = _padFixResult[_padSioChan];
        if (fix >= 0) {
            if (fix > 0) {
                int n;
                do {
                    n = _padFixResult[_padSioChan] - 1;
                    _padFixResult[_padSioChan] = n;
                    _padFuncRecvAuto(*(unsigned char **)(info + 0xc) + n * 0xf0);
                } while (n > 0);
            }
            if (_padFixResult[_padSioChan] == 0) {
                _padFixResult[_padSioChan] = -1;
                _padFuncRecvAuto(info);
                _padFuncClrCmdNo(info);
            }
        }
    }
'''
# 5. while form
V['while form'] = '''    {
        int fix = _padFixResult[_padSioChan];
        if (fix >= 0) {
            while (_padFixResult[_padSioChan] > 0) {
                --_padFixResult[_padSioChan];
                _padFuncRecvAuto(*(unsigned char **)(info + 0xc) +
                                 _padFixResult[_padSioChan] * 0xf0);
            }
            if (_padFixResult[_padSioChan] == 0) {
                _padFixResult[_padSioChan] = -1;
                _padFuncRecvAuto(info);
                _padFuncClrCmdNo(info);
            }
        }
    }
'''
# 6. chan local INSIDE the do body only
V['chan local in body'] = '''    {
        int fix = _padFixResult[_padSioChan];
        if (fix >= 0) {
            if (fix > 0) {
                do {
                    int ch = _padSioChan;
                    --_padFixResult[ch];
                    _padFuncRecvAuto(*(unsigned char **)(info + 0xc) +
                                     _padFixResult[ch] * 0xf0);
                } while (_padFixResult[_padSioChan] > 0);
            }
            if (_padFixResult[_padSioChan] == 0) {
                _padFixResult[_padSioChan] = -1;
                _padFuncRecvAuto(info);
                _padFuncClrCmdNo(info);
            }
        }
    }
'''
# 7. index expr with explicit cast-int addressing
V['cast-int addr'] = '''    {
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
'''
for k, v in V.items():
    mk(v, k)
