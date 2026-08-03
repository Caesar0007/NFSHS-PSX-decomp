#!/usr/bin/env python3
"""w46-a1 ROUND 7 -- retail's `v` has TWO homes: register $t4 (feeds prim[0xd] /
prim[0x19]) AND a byte stack slot 0x20(sp) reloaded into $t7 for the `vh + v`
bottom row.  Model that as TWO source variables (the w40 uncoalesced-temp
identity: the copy must OUTLIVE its source)."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from a1_probe import probe
from a1_draw_probes4 import noflr, compose

DRAW = 'DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii'
NL = '\r\n'


def rep(t, a, b):
    assert a in t, 'anchor missing: %r' % a[:70]
    return t.replace(a, b, 1)


def vb(ty, where):
    """second v variable feeding ONLY the vh+v bottom row."""
    def f(t):
        t = rep(t, '  short    w1;' + NL, '  short    w1;' + NL + '  %s vb;' % ty + NL)
        t = rep(t, '    prim[0x25] = vh + v;' + NL + '    prim[0x31] = vh + v;',
                   '    prim[0x25] = vh + vb;' + NL + '    prim[0x31] = vh + vb;')
        stmt = '  vb = v;' + NL
        if where == 'pre-loop':
            k = t.index('void DrawGouraudShape(tTexture_ShapeInfo *shp')
            j = t.index('  i = 0;' + NL, k)
            t = t[:j] + stmt + t[j:]
        else:   # both arms
            t = rep(t, '  v = (byte)shp->shapey;' + NL,
                       '  v = (byte)shp->shapey;' + NL + stmt)
        return t
    return f


PROBES = [
    ('vb short pre',   vb('short', 'pre-loop')),
    ('vb u_char pre',  vb('u_char', 'pre-loop')),
    ('vb int pre',     vb('int', 'pre-loop')),
    ('vb short pre+noflr', compose(vb('short', 'pre-loop'), noflr)),
    ('vb u_char pre+noflr', compose(vb('u_char', 'pre-loop'), noflr)),
    ('vb int pre+noflr', compose(vb('int', 'pre-loop'), noflr)),
]

if __name__ == '__main__':
    for name, f in PROBES:
        try:
            r = probe(f, DRAW)
        except Exception as e:
            r = ['ERR %s' % e]
        print('%-22s %s' % (name, ' | '.join(r)))
