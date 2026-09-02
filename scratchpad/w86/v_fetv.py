F1 = '      u_int rgbMask = 0xffffff;\n      __asm__("" : : "r"(rgbMask), "r"(rgbMask));\n'
D1 = '      u_int rgbMask = 0xffffff;\n'


def abs_(v, q, n=1):
    return ''.join('      %s &= (%s | (u_int)(int)%s);\n' % (v, v, q) for _ in range(n))


def absor(v, q, n=1):
    return ''.join('      %s |= (%s & (u_int)(int)%s);\n' % (v, v, q) for _ in range(n))


VARIANTS = [("drop", [(F1, D1)])]
for q in ('texture', 'packetPtrSlot'):
    for n in (1, 2, 3):
        VARIANTS.append(("abs_%s_%d" % (q, n), [(F1, D1 + abs_('rgbMask', q, n))]))
    VARIANTS.append(("absor_%s_1" % q, [(F1, D1 + absor('rgbMask', q, 1))]))
