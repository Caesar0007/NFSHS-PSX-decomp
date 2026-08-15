import re

# --- loop-shape: drop the Ghidra byte-offset biv iVar7, index obj->facet by the counter
LOOPHEAD = re.compile(
    r'( *)iVar7 = facetIdx \* 0xc;\r\n'
    r'( *)while\( true \) \{\r\n'
    r'( *)facetIdx = facetIdx - 1;\r\n'
    r' *iVar7 = iVar7 \+ -0xc;\r\n')
FACETASG = re.compile(r'( *)facet = \(int\)obj->facet \+ iVar7;\r\n')

PAT_LG = re.compile(r'( *)id0 = \*\(u_char \*\)\(facet \+ 3\);\r\n *id1 = \*\(u_char \*\)\(facet \+ 4\);\r\n'
                    r' *id2 = \*\(u_char \*\)\(facet \+ 5\);\r\n *'
                    r'if \(\(sd->head\)\.cprim\.MPrimPtr <= \(sd->head\)\.cprim\.PrimPtr\) continue;\r\n')
LOADS = ("id0 = *(u_char *)(facet + 3);\r\n"
         "%sid1 = *(u_char *)(facet + 4);\r\n"
         "%sid2 = *(u_char *)(facet + 5);\r\n")
GUARD = "if ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr) continue;\r\n"


def drop_biv(s):
    out, n = LOOPHEAD.subn(lambda m: '%swhile( true ) {\r\n%sfacetIdx = facetIdx - 1;\r\n'
                           % (m.group(2), m.group(3)), s)
    assert n == 5, ('head', n)
    out, n2 = FACETASG.subn(lambda m: '%sfacet = (int)(obj->facet + facetIdx);\r\n' % m.group(1), out)
    assert n2 == 5, ('asg', n2)
    return out


def swap_loads(s):
    def r(m):
        ind = m.group(1)
        return ind + GUARD + ind + (LOADS % (ind, ind))
    out, n = PAT_LG.subn(r, s)
    assert n == 5, n
    return out


PATCHES = [
    ('A1_dropbiv', drop_biv),
    ('A2_dropbiv+loadsbelow', lambda s: swap_loads(drop_biv(s))),
]
