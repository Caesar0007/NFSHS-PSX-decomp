#!/usr/bin/env python3
"""w46-a1 DrawGouraudShape probes on the gate-83 basin (retail-exact handout)."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from a1_probe import probe

DRAW = 'DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii'
NL = '\r\n'


def rep(t, a, b, n=1):
    assert t.count(a) >= 1, 'anchor missing: %r' % a[:60]
    return t.replace(a, b, n)


# ---- A: vraw -- retail keeps the raw shapey in its own pseudo (w40 uncoalesced-temp
#         identity: the COPY must outlive its source).
def A(t):
    t = rep(t, '  short    w1;' + NL,
               '  short    w1;' + NL + '  short    vraw;' + NL)
    t = rep(t, '  v = (byte)shp->shapey;' + NL,
               '  vraw = (byte)shp->shapey;' + NL + '  v = vraw;' + NL)
    t = rep(t, '    v = (byte)shp->shapey - 1;', '    v = vraw - 1;')
    return t


# ---- B: texX operand order -- retail issues the (i*bpp)/16 divide chain BEFORE the
#         shapex load (its lhu carries a load-delay nop).
def B(t):
    return rep(t,
        '    texX = (uint)(ushort)shp->shapex + (i * bpp) / 16;',
        '    texX = (i * bpp) / 16 + (uint)(ushort)shp->shapex;')


# ---- B2: same, as its own statement (statement split = lower luid, issues first)
def B2(t):
    return rep(t,
        '    texX = (uint)(ushort)shp->shapex + (i * bpp) / 16;',
        '    ibp = (i * bpp) / 16;' + NL +
        '    texX = (uint)(ushort)shp->shapex + ibp;').replace(
        '    int c3;' + NL, '    int c3;' + NL + '    int ibp;' + NL, 1)


def AB(t):
    return B(A(t))


def AB2(t):
    return B2(A(t))


PROBES = [('A vraw', A), ('B texX-swap', B), ('B2 texX-split', B2),
          ('A+B', AB), ('A+B2', AB2)]

if __name__ == '__main__':
    for name, f in PROBES:
        try:
            r = probe(f, DRAW)
        except Exception as e:
            r = ['ERR %s' % e]
        print('%-14s %s' % (name, ' | '.join(r)))
