#!/usr/bin/env python3
"""w46-a3: multi-pseudo what-if search for DrawC_PrimMenu's 3-cycle."""
import sys, itertools
sys.path.insert(0, 'tools')
import allocsim as A

GREG = 'scratch/rtl/drawc.i.greg'
LREG = 'scratch/rtl/drawc.i.lreg'
FN = ("void DrawC_PrimMenu(struct matrixtdef *, struct coorddef *, "
      "struct Transformer_zObj *, struct Transformer_zOverlay *, int, "
      "struct Draw_CarCache *)")

L = A.parse_lreg(LREG, FN)
order, conf, prefs, disp = A.parse_greg(GREG, FN)
sim = A.Sim(L, order, conf, prefs, disp, A.parse_copy_prefs(LREG, FN),
            A.parse_ever_live(LREG, FN))

WANT = {146: 10, 147: 9, 148: 6, 144: 5}   # id0=t2 id1=t1 id2=a2 ovl=a1


def run(ov=None):
    o, got = sim.run(ov)
    return o, got


def show(tag, ov):
    o, got = run(ov)
    ok = all(got.get(p) == r for p, r in WANT.items())
    print('%-40s %s  %s' % (
        tag, 'HIT ' if ok else '    ',
        {('p%d' % p): A.rname(got.get(p)) for p in sorted(WANT)}))
    return ok


if __name__ == '__main__':
    show('base', None)
    # H1: demote the envmap uv temps p205/p206
    for lv in (40, 60, 90, 120, 200):
        show('p205/p206 live=%d' % lv,
             {205: {'live': lv}, 206: {'live': lv}})
    # H2: H1 + reverse the id live order
    for lv in (90, 120, 200):
        show('H1(%d)+ids 101/98/91' % lv,
             {205: {'live': lv}, 206: {'live': lv},
              146: {'live': 101}, 147: {'live': 98}, 148: {'live': 91}})
