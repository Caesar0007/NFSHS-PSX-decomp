import re, sys
from fr import frame

hdr = open('hdr.txt', errors='replace').read()
body = open('fnbody.txt', errors='replace').read()

i0 = body.index('    {\n        int fix')
i1 = body.index('    if (((*(volatile unsigned short *)(_padSioRegs + 0x04)) & 0x200) != 0) {')
PRE, FIX, POST = body[:i0], body[i0:i1], body[i1:]


def mk(fixblk, tag):
    b = PRE + fixblk + POST
    open('v.i', 'w').write(hdr + '\n' + b + '\n')
    print('%-46s %s' % (tag, frame('v.i', '_padInitSioMode')))


mk(FIX, 'FIX as-is')

V = {}
V['only outer guard'] = '''    {
        int fix = _padFixResult[_padSioChan];
        if (fix >= 0) {
            _padFuncRecvAuto(info);
        }
    }
'''
V['only do-while'] = '''    {
        int fix = _padFixResult[_padSioChan];
        if (fix > 0) {
            do {
                --_padFixResult[_padSioChan];
                _padFuncRecvAuto(*(unsigned char **)(info + 0xc) +
                                 _padFixResult[_padSioChan] * 0xf0);
            } while (_padFixResult[_padSioChan] > 0);
        }
    }
'''
V['only second if'] = '''    {
        int fix = _padFixResult[_padSioChan];
        if (fix >= 0) {
            if (_padFixResult[_padSioChan] == 0) {
                _padFixResult[_padSioChan] = -1;
                _padFuncRecvAuto(info);
                _padFuncClrCmdNo(info);
            }
        }
    }
'''
V['do-while, no *0xf0 index'] = '''    {
        int fix = _padFixResult[_padSioChan];
        if (fix > 0) {
            do {
                --_padFixResult[_padSioChan];
                _padFuncRecvAuto(*(unsigned char **)(info + 0xc));
            } while (_padFixResult[_padSioChan] > 0);
        }
    }
'''
V['do-while, direct arg'] = '''    {
        int fix = _padFixResult[_padSioChan];
        if (fix > 0) {
            do {
                --_padFixResult[_padSioChan];
                _padFuncRecvAuto(info);
            } while (_padFixResult[_padSioChan] > 0);
        }
    }
'''
V['do-while, no fp call'] = '''    {
        int fix = _padFixResult[_padSioChan];
        if (fix > 0) {
            do {
                --_padFixResult[_padSioChan];
                setRC2wait((int)(*(unsigned char **)(info + 0xc) +
                                 _padFixResult[_padSioChan] * 0xf0));
            } while (_padFixResult[_padSioChan] > 0);
        }
    }
'''
V['just fp call once'] = '''    _padFuncRecvAuto(info);
    _padFuncClrCmdNo(info);
'''
V['just RecvAuto once'] = '''    _padFuncRecvAuto(info);
'''
V['just ClrCmdNo once'] = '''    _padFuncClrCmdNo(info);
'''
V['just array RMW'] = '''    _padFixResult[_padSioChan] = -1;
'''
for k, v in V.items():
    mk(v, k)
