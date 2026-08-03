#!/usr/bin/env python3
"""w46-a1 ROUND 6 -- transplant the ce-245 permuter's ONE semantic mutation
(`volatile int vbot;`) into the gate-37 basin.  A volatile local is memory-
resident by construction = a candidate for retail's THIRD stack slot."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from a1_probe import probe
from a1_draw_probes4 import noflr, compose

DRAW = 'DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii'
NL = '\r\n'


def rep(t, a, b):
    assert a in t, 'anchor missing: %r' % a[:70]
    return t.replace(a, b, 1)


def vbot(qual, where):
    """named bottom-V temp; `where`='pre-call' or 'at-use'."""
    def f(t):
        t = rep(t, '    int c3;' + NL,
                   '    int c3;' + NL + '    %s vbot;' % qual + NL)
        t = rep(t, '    prim[0x25] = vh + v;' + NL + '    prim[0x31] = vh + v;',
                   '    prim[0x25] = vbot;' + NL + '    prim[0x31] = vbot;')
        stmt = '    vbot = vh + v;' + NL
        if where == 'pre-call':
            t = rep(t, '    *(short *)(prim + 0xe) = GetClut', stmt +
                    '    *(short *)(prim + 0xe) = GetClut')
        else:
            t = rep(t, '    prim[0x25] = vbot;', stmt + '    prim[0x25] = vbot;')
        return t
    return f


def volv(t):
    return rep(t, '  short    v;' + NL, '  volatile short v;' + NL)


def volvh(t):
    return rep(t, '  short    vh;' + NL, '  volatile short vh;' + NL)


PROBES = [
    ('vol vbot pre',  vbot('volatile int', 'pre-call')),
    ('vol vbot use',  vbot('volatile int', 'at-use')),
    ('vol vbot pre+noflr', compose(vbot('volatile int', 'pre-call'), noflr)),
    ('vol vbot use+noflr', compose(vbot('volatile int', 'at-use'), noflr)),
    ('plain vbot use', vbot('int', 'at-use')),
    ('volatile vh',   volvh),
    ('volatile vh+noflr', compose(volvh, noflr)),
    ('volatile v',    volv),
]

if __name__ == '__main__':
    for name, f in PROBES:
        try:
            r = probe(f, DRAW)
        except Exception as e:
            r = ['ERR %s' % e]
        print('%-20s %s' % (name, ' | '.join(r)))
