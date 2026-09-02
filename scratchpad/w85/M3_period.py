"""M3_period.py — does the call-135 (delta=1) prefix class RECUR at higher P?

If it does, a device placed BETWEEN the R1 region (member ~+0x1550) and
menuCarUpgrades (+0x1F34) could bridge the two conflicting requirements
(R1 wants P>=~33, R2 wants P in [17,21]).  If it does not recur, the two
requirements are irreconcilable with any placement of this device kind.

Suffix is fixed OFF so P alone varies; only the delta indicator is read
(the frame/hoist needs the suffix and is irrelevant to this question).
"""
import sys, itertools
sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/w85')
import M3_score as S
from M3_probe1747 import probe

COST = lambda d: 0 if d == 0 else 4 * d + 1
reps = {}
for c in itertools.product(range(10), repeat=3):
    s = sum(COST(x) for x in c)
    reps.setdefault(s, ''.join(map(str, c)) + '000')

for P in [int(x) for x in sys.argv[1].split(',')]:
    if P not in reps:
        print('P=%-3d unreachable' % P)
        continue
    cfg = reps[P] + '000'
    st = S.build(cfg)
    d, txt, fr = probe(st)
    print('P=%-3d %s insns=%d frame=%s delta=%s' % (P, cfg, len(st), fr, d), flush=True)
