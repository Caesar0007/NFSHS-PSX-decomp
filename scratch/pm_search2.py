#!/usr/bin/env python3
"""w46-a3: two-stage what-if search for DrawC_PrimMenu's 3-cycle.

Stage 1: single-dial deltas that achieve p144=a1 (overlayFlag -> $a1).
Stage 2: from each stage-1 hit, single-dial deltas that achieve the FULL
         retail handout id0=t2 id1=t1 id2=a2 overlayFlag=a1.
"""
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
PART = {144: 5}
SPAN = 30


def hit(want, ov):
    _, got = sim.run(ov)
    return all(got.get(p) == r for p, r in want.items())


def singles(want, base_ov):
    out = []
    for p in sim.order_dump:
        d = L.get(p)
        if not d:
            continue
        for key in ('refs', 'live'):
            b = d[key]
            for v in range(max(1, b - SPAN), b + SPAN + 1):
                if v == b:
                    continue
                ov = dict((k, dict(vv)) for k, vv in (base_ov or {}).items())
                ov.setdefault(p, {})[key] = v
                if hit(want, ov):
                    out.append((p, key, b, v))
                    break
    return out


s1 = singles(PART, None)
print('STAGE 1 - single dials giving p144=a1 (%d):' % len(s1))
for p, k, b, v in s1:
    print('   p%-5d %-5s %3d -> %-3d' % (p, k, b, v))

print()
seen = set()
for p, k, b, v in s1:
    base = {p: {k: v}}
    s2 = singles(FULL, base)
    for p2, k2, b2, v2 in s2:
        key = (p, k, p2, k2)
        if key in seen:
            continue
        seen.add(key)
        print('FULL HIT: p%d %s %d->%d  +  p%d %s %d->%d'
              % (p, k, b, v, p2, k2, b2, v2))
