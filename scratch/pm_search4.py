#!/usr/bin/env python3
"""w46-a3: narrow the DrawC_PrimMenu required delta."""
import sys
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
FULL = {146: 10, 147: 9, 148: 6, 144: 5}


def show(tag, ov):
    _, got = sim.run(ov)
    ok = all(got.get(p) == r for p, r in FULL.items())
    print('%-52s %s %s' % (tag, 'HIT ' if ok else '    ',
          {('p%d' % p): A.rname(got.get(p)) for p in sorted(FULL)}))
    return ok


REV = {146: {'live': 101}, 147: {'live': 98}, 148: {'live': 91}}
REVR = {148: {'refs': 20}, 146: {'refs': 16}}


def merge(*ds):
    out = {}
    for d in ds:
        for k, v in d.items():
            out.setdefault(k, {}).update(v)
    return out


show('base', None)
for lv in (20, 51, 60, 90):
    show('p206 live=%d + ids-live-rev' % lv, merge({206: {'live': lv}}, REV))
for lv in (20, 51, 60, 90):
    show('p205+p206 live=%d + ids-live-rev' % lv,
         merge({205: {'live': lv}, 206: {'live': lv}}, REV))
for r in (4, 3, 2):
    show('p206 refs=%d + ids-live-rev' % r, merge({206: {'refs': r}}, REV))
    show('p205+206 refs=%d + ids-live-rev' % r,
         merge({205: {'refs': r}, 206: {'refs': r}}, REV))
print()
for lv in (20, 51, 60, 90):
    show('p206 live=%d + ids-REFS-rev' % lv, merge({206: {'live': lv}}, REVR))
    show('p205+206 live=%d + ids-REFS-rev' % lv,
         merge({205: {'live': lv}, 206: {'live': lv}}, REVR))
for r in (4, 3, 2):
    show('p205+206 refs=%d + ids-REFS-rev' % r,
         merge({205: {'refs': r}, 206: {'refs': r}}, REVR))
