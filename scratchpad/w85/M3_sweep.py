"""M3_sweep.py — 512-subset device sweep on the v2 (dropped-arg) JPN source."""
import sys, json
sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/w85')
import M3_lib as L

EXTRA = [('&itemTwoPlayerHotPursuit, &itemTwoPlayerPinkSlips, 0)',
          '&itemTwoPlayerHotPursuit, 0)', 1),
         ('&itemControllerShockImpact, &itemControllerDeadSpot1, &itemControllerDeadSpot2, 0)',
          '&itemControllerShockImpact, 0)', 1)]

res = []
for mask in range(512):
    d, n, fr, _ = L.run(mask, EXTRA, path='scratchpad/w85/M3_sweep_work.cpp')
    names = ''.join('1' if mask >> i & 1 else '0' for i in range(9))
    res.append((d if d is not None else 999999, n, fr, names))
    if mask % 32 == 0:
        print('..', mask, sorted(res)[0], flush=True)
res.sort()
for r in res[:25]:
    print(r)
json.dump(res, open('C:/Temp/nfs4-decomp/scratchpad/w85/M3_sweep.json', 'w'))
