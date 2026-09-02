"""M3_gatescan.py — scan (prefix P, suffix S) with the REGIONAL GATE as the metric.

Once the call-135 tie-break is fixed (prefix sum in the delta=1 window), the
pervasive t0/t1 register-phase swap disappears and the gate becomes meaningful
again, so this scan is gated, not scored.

usage: python M3_gatescan.py <Pmin> <Pmax> [Smax]
"""
import sys, itertools, json
sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/w85')
import M3_depth as D, M3_lib as L

COST = lambda d: 0 if d == 0 else 4 * d + 1
PRE, SUF = {}, {}
for c in itertools.product(range(7), repeat=6):
    s = sum(COST(x) for x in c)
    PRE.setdefault(s, ''.join(map(str, c)))
for c in itertools.product(range(7), repeat=3):
    s = sum(COST(x) for x in c)
    SUF.setdefault(s, ''.join(map(str, c)))

Pmin, Pmax = int(sys.argv[1]), int(sys.argv[2])
Smax = int(sys.argv[3]) if len(sys.argv) > 3 else 60
res = []
for P in range(Pmin, Pmax + 1):
    if P not in PRE:
        continue
    for Sv in sorted(SUF):
        if Sv > Smax:
            break
        cfg = PRE[P] + SUF[Sv]
        L.write(D.src(cfg), 'scratchpad/w85/M3_gs.cpp')
        d, n, fr, _ = L.gate('scratchpad/w85/M3_gs.cpp')
        res.append((d if d is not None else 999999, cfg, n, fr, P, Sv))
        print('P=%-3d S=%-3d %s gate=%s insns=%s frame=%s' % (P, Sv, cfg, d, n, fr), flush=True)
res.sort()
print('BEST:', res[:10])
json.dump(res, open('C:/Temp/nfs4-decomp/scratchpad/w85/M3_gatescan.json', 'w'))
