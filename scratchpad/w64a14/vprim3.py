import re

PAT_LG = re.compile(r'( *)id0 = \*\(u_char \*\)\(facet \+ 3\);\r\n *id1 = \*\(u_char \*\)\(facet \+ 4\);\r\n'
                    r' *id2 = \*\(u_char \*\)\(facet \+ 5\);\r\n *'
                    r'if \(\(sd->head\)\.cprim\.MPrimPtr <= \(sd->head\)\.cprim\.PrimPtr\) continue;\r\n')
LOADS = ("id0 = *(u_char *)(facet + 3);\r\n"
         "%sid1 = *(u_char *)(facet + 4);\r\n"
         "%sid2 = *(u_char *)(facet + 5);\r\n")
GUARD = "if ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr) continue;\r\n"
FUSED = re.compile(r'( *)id0 = id0 \* 8 \+ \(int\)sd;\r\n *id1 = id1 \* 8 \+ \(int\)sd;\r\n'
                   r' *id2 = id2 \* 8 \+ \(int\)sd;\r\n')
FACETASG = re.compile(r'( *)facet = \(int\)\(obj->facet \+ facetIdx\);\r\n')


def swap_loads(s):
    def r(m):
        ind = m.group(1)
        return ind + GUARD + ind + (LOADS % (ind, ind))
    out, n = PAT_LG.subn(r, s); assert n == 5, n
    return out


def split_morph(s):
    def r(m):
        ind = m.group(1)
        return (ind + "id0 = id0 * 8; id0 = id0 + (int)sd;\r\n"
                + ind + "id1 = id1 * 8; id1 = id1 + (int)sd;\r\n"
                + ind + "id2 = id2 * 8; id2 = id2 + (int)sd;\r\n")
    out, n = FUSED.subn(r, s); assert n == 5, n
    return out


def drop_ivar7(s):
    out = s.replace("  int iVar7;\r\n", "", 1)
    assert out != s
    return out


def int_counter(s):
    out = s.replace("  u_int facetIdx;\r\n  int loopDoneTag;\r\n",
                    "  int facetIdx;\r\n  int loopDoneTag;\r\n", 1)
    assert out != s
    out2 = out.replace("facetIdx = (u_int)obj->numFacet;", "facetIdx = (int)(u_int)obj->numFacet;", 1)
    out2 = out2.replace("if (facetIdx == 0xffffffff) {", "if (facetIdx == -1) {")
    out2 = out2.replace("if (facetIdx == 0xffffffff) break;", "if (facetIdx == -1) break;")
    return out2


def facet_typed(s):
    out, n = FACETASG.subn(lambda m: '%sfacet = (int)(obj->facet) + facetIdx * 12;\r\n' % m.group(1), s)
    assert n == 5, n
    return out


PATCHES = [
    ('B0_drop_unused_iVar7', drop_ivar7),
    ('B1_loads_below_guard', swap_loads),
    ('B2_split_morph', split_morph),
    ('B3_split+loadsbelow', lambda s: split_morph(swap_loads(s))),
    ('B4_int_counter', int_counter),
    ('B5_facet_bytemul', facet_typed),
]
