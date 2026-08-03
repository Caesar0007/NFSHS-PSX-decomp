#!/usr/bin/env python3
"""w46-a1 DrawGouraudShape ROUND 5 -- make `v` a genuine QImode memory-homed value
(retail spills it `sb t4,0x20(sp)` / reloads `lbu t7,0x20(sp)`), which would supply
the THIRD stack slot the deadfrm filler is currently faking."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from a1_probe import probe
from a1_draw_probes4 import noflr, compose

DRAW = 'DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii'
NL = '\r\n'


def rep(t, a, b):
    assert a in t, 'anchor missing: %r' % a[:70]
    return t.replace(a, b, 1)


def v_ty(ty):
    def f(t):
        return rep(t, '  short    v;' + NL, '  %-8s v;' % ty + NL)
    return f


def vh_ty(ty):
    def f(t):
        return rep(t, '  short    vh;' + NL, '  %-8s vh;' % ty + NL)
    return f


PROBES = [
    ('v u_char', v_ty('u_char')),
    ('v byte', v_ty('byte')),
    ('v u_char+noflr', compose(v_ty('u_char'), noflr)),
    ('v byte+noflr', compose(v_ty('byte'), noflr)),
    ('vh u_short', vh_ty('ushort')),
    ('vh u_short+noflr', compose(vh_ty('ushort'), noflr)),
    ('v uc + vh us', compose(v_ty('u_char'), vh_ty('ushort'))),
    ('v uc+vh us+noflr', compose(v_ty('u_char'), vh_ty('ushort'), noflr)),
]

if __name__ == '__main__':
    for name, f in PROBES:
        try:
            r = probe(f, DRAW)
        except Exception as e:
            r = ['ERR %s' % e]
        print('%-18s %s' % (name, ' | '.join(r)))
