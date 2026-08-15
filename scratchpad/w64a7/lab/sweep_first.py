from fr import frame

hdr = open('hdr.txt', errors='replace').read()
body = open('fnbody.txt', errors='replace').read()
i0 = body.index('    {\n        int fix')
i1 = body.index('    if (((*(volatile unsigned short *)(_padSioRegs + 0x04)) & 0x200) != 0) {')
PRE, ORIG, POST = body[:i0], body[i0:i1], body[i1:]

TAIL = '''        if (fix >= 0) {
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
'''


def mk(fixblk, tag):
    open('v.i', 'w').write(hdr + '\n' + PRE + fixblk + POST + '\n')
    print('%-46s %s' % (tag, frame('v.i', '_padInitSioMode')))


mk(ORIG, 'ORIG')

FIRST = {
    'b split decl': '    {\n        int fix;\n        fix = _padFixResult[_padSioChan];\n',
    'c elem-ptr first only':
        '    {\n        int *fp0 = &_padFixResult[_padSioChan];\n        int fix = *fp0;\n',
    'd cast-int first only':
        '    {\n        int fix = *(int *)((_padSioChan << 2) + (int)_padFixResult);\n',
    'e volatile first':
        '    {\n        int fix = *(volatile int *)&_padFixResult[_padSioChan];\n',
    'f chan-local first only':
        '    {\n        int c0 = _padSioChan;\n        int fix = _padFixResult[c0];\n',
    'g base-ptr first only':
        '    {\n        int *fb = _padFixResult;\n        int fix = fb[_padSioChan];\n',
}
for k, v in FIRST.items():
    mk(v + TAIL, k)

# no-local form: three direct reads
NOLOC = '''    {
        if (_padFixResult[_padSioChan] >= 0) {
            if (_padFixResult[_padSioChan] > 0) {
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
'''
mk(NOLOC, 'h no local')
