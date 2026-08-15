import re
CR = chr(13) + chr(10)

LG = re.compile(r'( *)id2 = \*\(u_char \*\)\(facet \+ 5\);\r\n'
                r' *id0 = \*\(u_char \*\)\(facet \+ 3\);\r\n'
                r' *id1 = \*\(u_char \*\)\(facet \+ 4\);\r\n'
                r' *if \(\(sd->head\)\.cprim\.MPrimPtr <= \(sd->head\)\.cprim\.PrimPtr\) continue;\r\n')


def swap(idxs, nexp=4):
    def go(s):
        n = [0]
        def r(m):
            n[0] += 1
            i = m.group(1)
            if n[0] - 1 not in idxs:
                return m.group(0)
            return (i + "if ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr) continue;" + CR
                    + i + "id2 = *(u_char *)(facet + 5);" + CR
                    + i + "id0 = *(u_char *)(facet + 3);" + CR
                    + i + "id1 = *(u_char *)(facet + 4);" + CR)
        out, k = LG.subn(r, s); assert k == nexp, k
        return out
    return go


PATCHES = [
    ('M_swap_all', swap({0, 1, 2, 3})),
    ('M_swap_s0', swap({0})),
    ('M_swap_s1', swap({1})),
    ('M_swap_s2', swap({2})),
    ('M_swap_s3', swap({3})),
]
