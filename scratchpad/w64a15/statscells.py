"""w64a15: enumerate EVERY reachable (refs, live) cell that lands retail's band on
Stats_TrackEndGame, using allocsim/reqdelta directly (multidial's --search is greedy
and refs-only, so it misses the live-only pairs the certificate needs).
"""
import os, sys, itertools

ROOT = r'C:\Temp\nfs4-decomp'
sys.path.insert(0, os.path.join(ROOT, 'tools'))
import reqdelta as R

GREG = os.path.join(ROOT, r'scratch\rtl\stats.i.greg')
LREG = os.path.join(ROOT, r'scratch\rtl\stats.i.lreg')
FN = 'void Stats_TrackEndGame()'
WANT = None  # set after import

L, sim = R.build(GREG, LREG, FN)
WANT = R.parse_want('p104=s4,p101=s5,p130=s6,p103=s7')
print('WANT', WANT)
BAND = [101, 103, 104, 130]
base = {p: (L[p]['refs'], L[p]['live']) for p in BAND}
print('base', base)


def score(ov):
    _, got = sim.run(ov)
    return sum(1 for p, r in WANT.items() if got.get(p) != r)


print('control mismatches', score({}))

# single-pseudo sweep
print('\n-- single-pseudo cells --')
for p in BAND:
    r0, l0 = base[p]
    for dr in range(-4, 5):
        for dl in range(-6, 9):
            if dr == 0 and dl == 0:
                continue
            if r0 + dr < 1 or l0 + dl < 1:
                continue
            ov = {p: {'refs': r0 + dr, 'live': l0 + dl}}
            if score(ov) == 0:
                print('  SOLO p%-4d refs %d->%d live %d->%d' % (p, r0, r0 + dr, l0, l0 + dl))

print('\n-- two-pseudo cells (minimal |delta| first) --')
sols = []
for pa, pb in itertools.combinations(BAND, 2):
    ra, la = base[pa]
    rb, lb = base[pb]
    for dra in range(-3, 4):
        for dla in range(-4, 7):
            for drb in range(-3, 4):
                for dlb in range(-4, 7):
                    if (dra, dla, drb, dlb) == (0, 0, 0, 0):
                        continue
                    if ra + dra < 1 or rb + drb < 1 or la + dla < 1 or lb + dlb < 1:
                        continue
                    ov = {pa: {'refs': ra + dra, 'live': la + dla},
                          pb: {'refs': rb + drb, 'live': lb + dlb}}
                    if score(ov) == 0:
                        cost = abs(dra) * 2 + abs(dla) + abs(drb) * 2 + abs(dlb)
                        sols.append((cost, pa, dra, dla, pb, drb, dlb))
sols.sort()
seen = set()
for cost, pa, dra, dla, pb, drb, dlb in sols[:40]:
    key = (pa, dra, dla, pb, drb, dlb)
    if key in seen:
        continue
    seen.add(key)
    print('  cost%-3d p%-4d refs%+d live%+d  |  p%-4d refs%+d live%+d'
          % (cost, pa, dra, dla, pb, drb, dlb))
print('total two-pseudo solutions:', len(sols))
