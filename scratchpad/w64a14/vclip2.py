import re

BLK = re.compile(r'( *)id2 = id2 \* 8; id2 = id2 \+ \(int\)sd;\r\n'
                 r' *id0 = id0 \* 8; id0 = id0 \+ \(int\)sd;\r\n'
                 r' *id1 = id1 \* 8; id1 = id1 \+ \(int\)sd;\r\n')

DIAL = ("do {{ id2 = id2 * 8; }} while (0);\r\n"
        "{i}do {{ id2 = id2 + (int)sd; }} while (0);\r\n"
        "{i}id0 = id0 * 8; id0 = id0 + (int)sd;\r\n"
        "{i}id1 = id1 * 8;\r\n"
        "{i}do {{ id1 = id1 + (int)sd; }} while (0);\r\n")


def at(idxs):
    def go(s):
        n = [0]
        def r(m):
            n[0] += 1
            ind = m.group(1)
            if n[0] - 1 not in idxs:
                return m.group(0)
            return ind + DIAL.format(i=ind)
        out, k = BLK.subn(r, s)
        assert k == 4, k
        return out
    return go


PATCHES = [
    ('H_s0', at({0})),
    ('H_s1', at({1})),
    ('H_s2', at({2})),
    ('H_s3', at({3})),
    ('H_all', at({0, 1, 2, 3})),
]
