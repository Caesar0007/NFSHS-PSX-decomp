import re, sys
from fr import frame

hdr = open('hdr.txt', errors='replace').read()
body = open('fnbody.txt', errors='replace').read()

SIO = '(*(volatile unsigned short *)(_padSioRegs + 0x0a))'
STAT = '(*(volatile unsigned short *)(_padSioRegs + 0x04))'
D8 = '(*(volatile unsigned char *)(_padSioRegs))'
IST = '(*(volatile unsigned int *)(_padIntRegs + 0x00))'

def mk(b, tag):
    open('v.i', 'w').write(hdr + '\n' + b + '\n')
    print('%-40s %s' % (tag, frame('v.i', '_padInitSioMode')))

mk(body, 'BASE')

# 1. drop the head stores
b = body
for pat in [SIO + ' = 0x40;', SIO + ' = 0;',
            '(*(volatile unsigned short *)(_padSioRegs + 0x08)) = 0xd;',
            '(*(volatile unsigned short *)(_padSioRegs + 0x0e)) = 0x88;']:
    assert pat in b, pat
b2 = b
for pat in [SIO + ' = 0x40;', SIO + ' = 0;',
            '(*(volatile unsigned short *)(_padSioRegs + 0x08)) = 0xd;',
            '(*(volatile unsigned short *)(_padSioRegs + 0x0e)) = 0x88;']:
    b2 = b2.replace(pat, ';')
mk(b2, 'no head stores')

# 2. drop setRC2wait ternary
b2 = b.replace('setRC2wait(info[0xe8] == 8 ? 0x50 : 0x91);', 'setRC2wait(0x50);')
mk(b2, 'setRC2wait const')

# 3. drop JOY_CTRL select ternary
b2 = b.replace(SIO + ' = (_padSioChan != 0) ? 0x3003 : 0x1003;', SIO + ' = 0x3003;')
mk(b2, 'ctrl select const')

# 4. drop the fix block
i0 = b.index('    {\n        int fix')
i1 = b.index('    if (((*(volatile unsigned short *)(_padSioRegs + 0x04)) & 0x200) != 0) {')
b2 = b[:i0] + b[i1:]
mk(b2, 'no fix block')

# 5. drop the big STAT block
i1 = b.index('    if (((*(volatile unsigned short *)(_padSioRegs + 0x04)) & 0x200) != 0) {')
i2 = b.index('    if (info[0x50] == 0)')
b2 = b[:i1] + b[i2:]
mk(b2, 'no STAT block')

# 6. drop the tail
b2 = b[:i2] + '    return 1;\n}\n'
mk(b2, 'no tail')
