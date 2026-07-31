# -*- coding: utf-8 -*-
p = 'recon/game/psx/draww.cpp'
s = open(p, encoding='utf-8').read()
old = """    sVar12 = (short)((int)((u_int)(u_char)rightN[0] << 0x18) >> 0x1b);
    sVar13 = (short)((int)((u_int)(u_char)rightN[1] << 0x18) >> 0x1b);
    sVar14 = (short)((int)((u_int)(u_char)rightN[2] << 0x18) >> 0x1b);
    sVar7 = pCoord->x;
    sVar8 = pCoord->y;
    sVar9 = pCoord->z;
"""
new = """    /* SYM inner block names six shorts: x,y,z (= pts->x/y/z, oracle $v1/$a0/$a1) and
       wx,wy,wz (= the 5-bit sign-extended right-normal bytes, oracle $t0/$t1/$a3).
       The oracle issues ALL SIX loads first and only then the three sll/sra extends. */
    sVar7 = pCoord->x;
    sVar8 = pCoord->y;
    sVar9 = pCoord->z;
    sVar12 = (short)((int)((u_int)(u_char)rightN[0] << 0x18) >> 0x1b);
    sVar13 = (short)((int)((u_int)(u_char)rightN[1] << 0x18) >> 0x1b);
    sVar14 = (short)((int)((u_int)(u_char)rightN[2] << 0x18) >> 0x1b);
"""
assert old in s
s = s.replace(old, new, 1)
open(p, 'w', encoding='utf-8').write(s)
print('ok')
