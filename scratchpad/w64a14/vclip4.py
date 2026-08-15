import re

ZBLK = re.compile(r'( *)\(sd->vt0\)\.z = z0;\r\n( *)\(sd->vt1\)\.z = z1;\r\n( *)\(sd->vt2\)\.z = z2;\r\n')

BLK = re.compile(r'( *)id2 = id2 \* 8; id2 = id2 \+ \(int\)sd;\r\n'
                 r' *id0 = id0 \* 8; id0 = id0 \+ \(int\)sd;\r\n'
                 r' *id1 = id1 \* 8; id1 = id1 \+ \(int\)sd;\r\n')
DIAL = ("do {{ id2 = id2 * 8; }} while (0);\r\n"
        "{i}do {{ id2 = id2 + (int)sd; }} while (0);\r\n"
        "{i}id0 = id0 * 8; id0 = id0 + (int)sd;\r\n"
        "{i}id1 = id1 * 8;\r\n"
        "{i}do {{ id1 = id1 + (int)sd; }} while (0);\r\n")


def dial_at(idxs):
    def go(s):
        n = [0]
        def r(m):
            n[0] += 1
            ind = m.group(1)
            if n[0] - 1 not in idxs:
                return m.group(0)
            return ind + DIAL.format(i=ind)
        out, k = BLK.subn(r, s); assert k == 4, k
        return out
    return go


def zfence_at(idxs):
    def go(s):
        n = [0]
        def r(m):
            n[0] += 1
            if n[0] - 1 not in idxs:
                return m.group(0)
            return m.group(0) + m.group(1) + '__asm__("" : : "i"(0));\r\n'
        out, k = ZBLK.subn(r, s); assert k == 4, k
        return out
    return go


PATCHES = [
    ('J_zfence_all', zfence_at({0, 1, 2, 3})),
    ('J_zfence_s0', zfence_at({0})),
    ('J_dial02_zfence_all', lambda s: zfence_at({0, 1, 2, 3})(dial_at({0, 2})(s))),
    ('J_dial02', dial_at({0, 2})),
]
