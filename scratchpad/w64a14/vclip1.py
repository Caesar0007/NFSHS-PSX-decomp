import re

HEAD = re.compile(r'( *)iVar11 = facetIdx \* 0xc;\r\n'
                  r'( *)while\( true \) \{\r\n'
                  r'( *)facetIdx = facetIdx - 1;\r\n'
                  r' *iVar11 = iVar11 \+ -0xc;\r\n')
ASG = re.compile(r'( *)(int )?facet = \(int\)obj->facet \+ iVar11;\r\n')


def drop_biv(s):
    out, n = HEAD.subn(lambda m: '%swhile( true ) {\r\n%sfacetIdx = facetIdx - 1;\r\n'
                       % (m.group(2), m.group(3)), s)
    assert n == 5, ('head', n)
    out, n2 = ASG.subn(lambda m: '%s%sfacet = (int)(obj->facet + facetIdx);\r\n'
                       % (m.group(1), m.group(2) or ''), out)
    assert n2 == 5, ('asg', n2)
    return out


def drop_decl(s):
    out = s.replace("  int iVar11;\r\n", "", 2)
    return out


PATCHES = [
    ('G_clip_dropbiv', drop_biv),
]
