#!/usr/bin/env python3
"""w46-a1 DrawGouraudShape probes ROUND 3 -- the flags&4 arm's a-band rotation
(ours {w1=a0, addw=a1, u+w1=v0} vs retail {w1=a1, addw=a2, u+w1=v1}) and the
`move v1,t4` the store-read-back costs."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from a1_probe import probe

DRAW = 'DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii'
NL = '\r\n'


def rep(t, a, b):
    assert a in t, 'anchor missing: %r' % a[:70]
    return t.replace(a, b, 1)


# L1: fresh dest for addw-1 (retail `addiu v1,a2,-1` keeps addw in a2)
def L1(t):
    t = rep(t, '    int vbot;' if 'int vbot;' in t else '    int c3;' + NL,
               ('    int vbot;' if 'int vbot;' in t else '    int c3;' + NL))
    t = rep(t, '    int c3;' + NL, '    int c3;' + NL + '    int addwm1;' + NL)
    t = rep(t, '      addw = addw - 1;', '      addwm1 = addw - 1;')
    t = t.replace('+ addw;', '+ addwm1;')
    return t


# L2: drop the w45 store-read-back (it costs a `move v1,t4` in THIS basin)
def L2(t):
    return rep(t, '    prim[0x19] = prim[0xd];', '    prim[0x19] = v;')


# L3: read-back the OTHER direction (prim[0xd] from a temp already stored)
def L3(t):
    return rep(t, '    prim[0x19] = prim[0xd];', '    prim[0x19] = prim[13];')


# L4: w1 as a fresh value at each use (retail duplicates `addu a1,s5,zero`)
def L4(t):
    return rep(t, '    w1 = w;' + NL, '')


def compose(*fs):
    def f(t):
        for g in fs:
            t = g(t)
        return t
    return f


PROBES = [('L1 addwm1', L1), ('L2 no-readback', L2), ('L3 readback-13', L3),
          ('L1+L2', compose(L1, L2))]

if __name__ == '__main__':
    for name, f in PROBES:
        try:
            r = probe(f, DRAW)
        except Exception as e:
            r = ['ERR %s' % e]
        print('%-14s %s' % (name, ' | '.join(r)))
