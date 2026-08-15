import re

LOADS = ("id0 = *(u_char *)(facet + 3);\r\n"
         "%sid1 = *(u_char *)(facet + 4);\r\n"
         "%sid2 = *(u_char *)(facet + 5);\r\n")
GUARD = "if ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr) continue;\r\n"

PAT = re.compile(r'( *)id0 = \*\(u_char \*\)\(facet \+ 3\);\r\n *id1 = \*\(u_char \*\)\(facet \+ 4\);\r\n'
                 r' *id2 = \*\(u_char \*\)\(facet \+ 5\);\r\n *'
                 r'if \(\(sd->head\)\.cprim\.MPrimPtr <= \(sd->head\)\.cprim\.PrimPtr\) continue;\r\n')

FUSED = re.compile(r'( *)id0 = id0 \* 8 \+ \(int\)sd;\r\n *id1 = id1 \* 8 \+ \(int\)sd;\r\n'
                   r' *id2 = id2 \* 8 \+ \(int\)sd;\r\n')


def swap_loads(s):
    def r(m):
        ind = m.group(1)
        return ind + GUARD + ind + (LOADS % (ind, ind))
    out, n = PAT.subn(r, s)
    assert n == 5, n
    return out


def split_morph(s):
    def r(m):
        ind = m.group(1)
        return (ind + "id0 = id0 * 8; id0 = id0 + (int)sd;\r\n"
                + ind + "id1 = id1 * 8; id1 = id1 + (int)sd;\r\n"
                + ind + "id2 = id2 * 8; id2 = id2 + (int)sd;\r\n")
    out, n = FUSED.subn(r, s)
    assert n == 5, n
    return out


PATCHES = [
    ('P1_loads_below_guard', swap_loads),
    ('P2_loads_below+split', lambda s: split_morph(swap_loads(s))),
    ('P3_split_only_ctl', split_morph),
]
