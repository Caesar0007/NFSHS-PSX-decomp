#!/usr/bin/env python3
"""w46-a1 DrawGouraudShape ROUND 4 -- re-probe the parked spellings from the NEW
gate-37 basin (falsifications are BASIN-RELATIVE, w45 law).  Target = retail's
third memory-homed value: width@16(half) / vh@24(half) / v@32(byte), frame 104."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from a1_probe import probe

DRAW = 'DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii'
NL = '\r\n'


def rep(t, a, b):
    assert a in t, 'anchor missing: %r' % a[:70]
    return t.replace(a, b, 1)


def noflr(t):
    i = t.index('  int      deadfrm[2];')
    j = t.index(';', t.index('*/', i)) + 1
    j = t.index(chr(10), j) + 1
    return t[:i] + t[j:]


def vraw(ty):
    def f(t):
        t = rep(t, '  short    w1;' + NL, '  short    w1;' + NL + '  %s vraw;' % ty + NL)
        t = rep(t, '  v = (byte)shp->shapey;' + NL,
                   '  vraw = (byte)shp->shapey;' + NL + '  v = vraw;' + NL)
        t = rep(t, '    v = (byte)shp->shapey - 1;', '    v = vraw - 1;')
        return t
    return f


def vh_int(t):
    return rep(t, '  short    vh;', '  int      vh;')


def v_int(t):
    return rep(t, '  short    v;' + NL, '  int      v;' + NL)


def vbot_named(t):
    """one named bottom-V temp (retail: ONE addu feeding both sb's)."""
    t = rep(t, '    int c3;' + NL, '    int c3;' + NL + '    int vbot;' + NL)
    t = rep(t, '    prim[0x25] = vh + v;' + NL + '    prim[0x31] = vh + v;',
               '    vbot = vh + v;' + NL + '    prim[0x25] = vbot;' + NL +
               '    prim[0x31] = vbot;')
    return t


def rb31(t):
    """mirror read-back on the bottom row."""
    return rep(t, '    prim[0x31] = vh + v;', '    prim[0x31] = prim[0x25];')


def compose(*fs):
    def f(t):
        for g in fs:
            t = g(t)
        return t
    return f


PROBES = [('noflr', noflr), ('vraw short', vraw('short')),
          ('vraw int', vraw('int')), ('vraw u_char', vraw('u_char')),
          ('vh int', vh_int), ('v int', v_int),
          ('vbot named', vbot_named), ('rb31', rb31),
          ('vrawI+noflr', compose(vraw('int'), noflr)),
          ('vrawI+vhint', compose(vraw('int'), vh_int))]

if __name__ == '__main__':
    for name, f in PROBES:
        try:
            r = probe(f, DRAW)
        except Exception as e:
            r = ['ERR %s' % e]
        print('%-14s %s' % (name, ' | '.join(r)))
