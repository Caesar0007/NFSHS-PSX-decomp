#!/usr/bin/env python3
"""w46-a3: with PART-1 fixed, single- and double-dial search for PART 2."""
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
P1 = {206: {'refs': 4}}


def merge(*ds):
    out = {}
    for d in ds:
        for k, v in d.items():
            out.setdefault(k, {}).update(v)
    return out


def hit(ov):
    _, got = sim.run(ov)
    return all(got.get(p) == r for p, r in FULL.items())


print('single dials on top of PART1 (p206 refs 12->4):')
found = []
for p in sim.order_dump:
    d = L.get(p)
    if not d:
        continue
    for key in ('refs', 'live'):
        b = d[key]
        for v in range(max(1, b - 40), b + 41):
            if v == b:
                continue
            if hit(merge(P1, {p: {key: v}})):
                found.append((p, key, b, v))
                break
for p, k, b, v in found:
    print('   p%-5d %-5s %3d -> %-3d' % (p, k, b, v))
if not found:
    print('   none')

print('\ndouble dials on the three ids only:')
import itertools
ids = [146, 147, 148]
for combo in itertools.combinations(ids, 2):
    for k1 in ('refs', 'live'):
        for k2 in ('refs', 'live'):
            for v1 in range(L[combo[0]][k1] - 12, L[combo[0]][k1] + 13):
                for v2 in range(L[combo[1]][k2] - 12, L[combo[1]][k2] + 13):
                    ov = merge(P1, {combo[0]: {k1: v1}, combo[1]: {k2: v2}})
                    if hit(ov):
                        print('   p%d %s=%d + p%d %s=%d'
                              % (combo[0], k1, v1, combo[1], k2, v2))
                        break
                else:
                    continue
                break
