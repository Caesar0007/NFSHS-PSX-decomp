from fr import frame

hdr = open('hdr.txt', errors='replace').read()
body = open('fnbody.txt', errors='replace').read()
i0 = body.index('    {\n        int fix')
i1 = body.index('    if (((*(volatile unsigned short *)(_padSioRegs + 0x04)) & 0x200) != 0) {')
PRE, POST = body[:i0], body[i1:]


def mk(fixblk, tag):
    open('v.i', 'w').write(hdr + '\n' + PRE + fixblk + POST + '\n')
    print('%-52s %s' % (tag, frame('v.i', '_padInitSioMode')))


V = {}
V['dw: dec global-array, empty body'] = '''    if (_padFixResult[_padSioChan] > 0) {
        do {
            --_padFixResult[_padSioChan];
        } while (_padFixResult[_padSioChan] > 0);
    }
'''
V['dw: dec plain global scalar'] = '''    if (_padSioState > 0) {
        do {
            --_padSioState;
        } while (_padSioState > 0);
    }
'''
V['dw: dec array CONST index'] = '''    if (_padFixResult[0] > 0) {
        do {
            --_padFixResult[0];
        } while (_padFixResult[0] > 0);
    }
'''
V['while: dec global-array'] = '''    while (_padFixResult[_padSioChan] > 0) {
        --_padFixResult[_padSioChan];
    }
'''
V['dw: local counter'] = '''    {
        int n = _padFixResult[_padSioChan];
        if (n > 0) {
            do { --n; } while (n > 0);
            _padFixResult[_padSioChan] = n;
        }
    }
'''
V['dw: array idx cached in local'] = '''    {
        int ch = _padSioChan;
        if (_padFixResult[ch] > 0) {
            do {
                --_padFixResult[ch];
            } while (_padFixResult[ch] > 0);
        }
    }
'''
V['dw: pointer to element'] = '''    {
        int *p = &_padFixResult[_padSioChan];
        if (*p > 0) {
            do { --*p; } while (*p > 0);
        }
    }
'''
V['no loop: single dec of array'] = '''    --_padFixResult[_padSioChan];
'''
for k, v in V.items():
    mk(v, k)
