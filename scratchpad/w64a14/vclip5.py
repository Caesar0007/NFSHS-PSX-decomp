import re

CR = chr(13) + chr(10)

ZBLK = re.compile(r'( *)\(sd->vt0\)\.z = z0;\r\n( *)\(sd->vt1\)\.z = z1;\r\n( *)\(sd->vt2\)\.z = z2;\r\n')
ZLOADS = re.compile(r'( *)u_short z0 = \*\(u_short \*\)\(id0 \+ 0xd4\);\r\n'
                    r' *u_short z1 = \*\(u_short \*\)\(id1 \+ 0xd4\);\r\n'
                    r' *u_short z2 = \*\(u_short \*\)\(id2 \+ 0xd4\);\r\n')
BLK = re.compile(r'( *)id2 = id2 \* 8; id2 = id2 \+ \(int\)sd;\r\n'
                 r' *id0 = id0 \* 8; id0 = id0 \+ \(int\)sd;\r\n'
                 r' *id1 = id1 \* 8; id1 = id1 \+ \(int\)sd;\r\n')
DIAL = ("do {{ id2 = id2 * 8; }} while (0);" + CR +
        "{i}do {{ id2 = id2 + (int)sd; }} while (0);" + CR +
        "{i}id0 = id0 * 8; id0 = id0 + (int)sd;" + CR +
        "{i}id1 = id1 * 8;" + CR +
        "{i}do {{ id1 = id1 + (int)sd; }} while (0);" + CR)
FENCE = '__asm__("" : : "i"(0));' + CR


def dial_at(idxs):
    def go(s):
        n = [0]
        def r(m):
            n[0] += 1
            if n[0] - 1 not in idxs:
                return m.group(0)
            return m.group(1) + DIAL.format(i=m.group(1))
        out, k = BLK.subn(r, s); assert k == 4, k
        return out
    return go


def _fence_after(pat, idxs, nexp=4):
    def go(s):
        n = [0]
        def r(m):
            n[0] += 1
            if n[0] - 1 not in idxs:
                return m.group(0)
            return m.group(0) + m.group(1) + FENCE
        out, k = pat.subn(r, s); assert k == nexp, k
        return out
    return go


PATCHES = [
    ('K_zfence_mid', _fence_after(ZLOADS, {0, 1, 2, 3})),
    ('K_zfence_both', lambda s: _fence_after(ZBLK, {0, 1, 2, 3})(_fence_after(ZLOADS, {0, 1, 2, 3})(s))),
    ('K_dial02_zfence_mid', lambda s: _fence_after(ZLOADS, {0, 1, 2, 3})(dial_at({0, 2})(s))),
]
