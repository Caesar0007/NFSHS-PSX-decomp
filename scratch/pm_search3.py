#!/usr/bin/env python3
"""w46-a3: 3-dial candidate check for DrawC_PrimMenu."""
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
    print('%-46s %s %s' % (tag, 'HIT ' if ok else '    ',
          {('p%d' % p): A.rname(got.get(p)) for p in sorted(FULL)}))


CASES = [
    ('id2 +2refs, id0 -2refs only',
     {148: {'refs': 20}, 146: {'refs': 16}}),
    ('p206 live20 + id2 20refs + id0 16refs',
     {206: {'live': 20}, 148: {'refs': 20}, 146: {'refs': 16}}),
    ('p206 refs8  + id2 20refs + id0 16refs',
     {206: {'refs': 8}, 148: {'refs': 20}, 146: {'refs': 16}}),
    ('p144 refs33 + id2 20refs + id0 16refs',
     {144: {'refs': 33}, 148: {'refs': 20}, 146: {'refs': 16}}),
    ('p206 live20 + id0 16refs only',
     {206: {'live': 20}, 146: {'refs': 16}}),
    ('p206 live20 + id2 20refs only',
     {206: {'live': 20}, 148: {'refs': 20}}),
    ('p206 live20 + ids live 101/98/91',
     {206: {'live': 20}, 146: {'live': 101}, 147: {'live': 98},
      148: {'live': 91}}),
    ('p206 live20 + id2 live 88 + id0 live 104',
     {206: {'live': 20}, 148: {'live': 88}, 146: {'live': 104}}),
]
show('base', None)
for t, ov in CASES:
    show(t, ov)
