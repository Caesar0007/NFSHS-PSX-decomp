#!/usr/bin/env python3
"""w46-a1 FontUpsideDownBlit probes from the gate-50 basin.

Target: retail materialises `ybase + 5` in its OWN register (`addiu $v1,$t8,5`)
and keeps ybase/ytop in a fresh $t8, running 16 distinct registers where ours
runs 15 -- ours folds `(A+5)-B` into `A-(B-5)` (`addiu t4,t4,-5`) and mutates the
dying `y` REGPARM ($a1) in place.  w45 §C: the constant reassociation is
STATEMENT-granular; parentheses do nothing, only a separate statement stops it.
All of these were measured NEGATIVE in the w43 basin (68) -- falsifications are
BASIN-RELATIVE, so they are re-probed here."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from a1_probe import probe

FONT = 'FontUpsideDownBlit__FiiPviiP12charactertbli'
NL = '\r\n'
YT = '  ytop = (ybase + 5) - hoff;' + NL


def rep(t, a, b):
    assert t.count(a) == 1, 'anchor %r count=%d' % (a[:60], t.count(a))
    return t.replace(a, b, 1)


def decl(t, d):
    return rep(t, '  int      ytop;' + NL, '  int      ytop;' + NL + d + NL)


def split_at(where):
    """ybase+5 as its own statement, emitted at `where`."""
    def f(t):
        t = decl(t, '  int      ybase5;')
        t = rep(t, YT, '  ytop = ybase5 - hoff;' + NL)
        stmt = '  ybase5 = ybase + 5;' + NL
        anchors = {
            'after-ybase': '  hoff = height + yoff;' + NL,
            'after-hoff':  '  dv = (((*(int *)((int)src + 0xc) << 4) >> 0x14) + v & 0xff) - 1;' + NL,
            'at-use':      '  ytop = ybase5 - hoff;' + NL,
            'top':         '  width = ch->width;' + NL,
        }
        a = anchors[where]
        i = t.index(a)
        if where in ('after-ybase', 'after-hoff', 'top'):
            i += len(a)
        return t[:i] + stmt + t[i:]
    return f


def mutate(t):
    """mutate ybase in place: ybase = ybase + 5; ytop = ybase - hoff;"""
    return rep(t, YT, '  ybase = ybase + 5;' + NL + '  ytop = ybase - hoff;' + NL)


def yplus5(t):
    """fold the +5 into ybase's own definition (ybase = y - yoff + 5 as 2 stmts)"""
    t = rep(t, '  ybase = y - yoff;' + NL,
               '  ybase = y - yoff;' + NL + '  ybase = ybase + 5;' + NL)
    return rep(t, YT, '  ytop = ybase - hoff;' + NL)


def hoff5(t):
    """explicit hoff-5 (make ours' fold the SOURCE shape -- control probe)"""
    return rep(t, YT, '  ytop = ybase - (hoff - 5);' + NL)


PROBES = [
    ('split after-ybase', split_at('after-ybase')),
    ('split after-hoff',  split_at('after-hoff')),
    ('split at-use',      split_at('at-use')),
    ('split top',         split_at('top')),
    ('mutate ybase',      mutate),
    ('y-yoff then +5',    yplus5),
    ('ybase-(hoff-5)',    hoff5),
]

if __name__ == '__main__':
    for name, f in PROBES:
        try:
            r = probe(f, FONT)
        except Exception as e:
            r = ['ERR %s' % e]
        print('%-20s %s' % (name, ' | '.join(r)))
