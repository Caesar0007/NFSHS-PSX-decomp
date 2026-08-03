#!/usr/bin/env python3
"""w46-a1 DrawGouraudShape probes, ROUND 2 -- from the gate-67 basin.
Target: retail's THREE memory-homed values (width@16 / vh@24 half / v@32 byte)
and the separate raw-shapey pseudo (`addu t4,v0,zero`)."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from a1_probe import probe

DRAW = 'DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii'
NL = '\r\n'
VDEF = '  v = (byte)shp->shapey;' + NL
VARM = '    v = (byte)shp->shapey - 1;'
DECL = '  short    w1;' + NL


def rep(t, a, b):
    assert a in t, 'anchor missing: %r' % a[:70]
    return t.replace(a, b, 1)


def vraw(ty):
    def f(t):
        t = rep(t, DECL, DECL + '  %s vraw;' % ty + NL)
        t = rep(t, VDEF, '  vraw = (byte)shp->shapey;' + NL + '  v = vraw;' + NL)
        t = rep(t, VARM, '    v = vraw - 1;')
        return t
    return f


def noflr(t):
    i = t.index('  int      deadfrm[2];')
    j = t.index(';', t.index('*/', i)) + 1
    j = t.index(chr(10), j) + 1
    return t[:i] + t[j:]


def vh_int(t):
    return rep(t, '  short    vh;', '  int      vh;')


def vh_before_v(t):
    """swap the v/vh definition order (retail loads shapey FIRST then height)."""
    t = rep(t, VDEF + '  vh = shp->height;' + NL,
               '  vh = shp->height;' + NL + VDEF)
    return t


def compose(*fs):
    def f(t):
        for g in fs:
            t = g(t)
        return t
    return f


PROBES = [
    ('vraw short', vraw('short')),
    ('vraw int', vraw('int')),
    ('vraw u_char', vraw('u_char')),
    ('noflr', noflr),
    ('vh int', vh_int),
    ('vh-before-v', vh_before_v),
    ('vraw+noflr', compose(vraw('short'), noflr)),
    ('vraw+vhint', compose(vraw('short'), vh_int)),
]

if __name__ == '__main__':
    for name, f in PROBES:
        try:
            r = probe(f, DRAW)
        except Exception as e:
            r = ['ERR %s' % e]
        print('%-14s %s' % (name, ' | '.join(r)))
