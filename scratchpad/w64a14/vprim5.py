import re

FUSED = re.compile(r'( *)id0 = id0 \* 8 \+ \(int\)sd;\r\n( *)id1 = id1 \* 8 \+ \(int\)sd;\r\n'
                   r'( *)id2 = id2 \* 8 \+ \(int\)sd;\r\n')


def split_at(idxs):
    def go(s):
        n = [0]
        def r(m):
            n[0] += 1
            ind = m.group(1)
            if n[0] - 1 not in idxs:
                return m.group(0)
            return (ind + "id0 = id0 * 8; id0 = id0 + (int)sd;\r\n"
                    + ind + "id1 = id1 * 8; id1 = id1 + (int)sd;\r\n"
                    + ind + "id2 = id2 * 8; id2 = id2 + (int)sd;\r\n")
        out, k = FUSED.subn(r, s)
        assert k == 5, k
        return out
    return go



PATCHES = [
    ('D_s1', split_at({1})),
    ('D_s3', split_at({3})),
    ('D_s2_s1', split_at({1,2})),
    ('D_s2_s3', split_at({2,3})),
    ('D_s2_s0', split_at({0,2})),
]
