"""M3_scan2d.py — 2-D (prefix, total) scan.

prefix sites (1-6, init-list lines 3191-3205) shift the ordinals at BOTH
divergence sites; suffix sites (7-9, lines 3366-3368) shift only the later
FEApp-hoist region.  So scan prefix sum P (fixes/breaks the call-135 tie-break)
against TOTAL = P + S (fixes/breaks the hoist), choosing S to hit each total.

Reports the call-135 indicator (a0->jal delta: oracle = 1, ours = 9) and the
frame (632 = FEApp hoisted like retail, 608 = not).
"""
import sys, itertools
sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/w85')
import M3_score as S
from M3_probe1747 import probe

COST = lambda d: 0 if d == 0 else 4 * d + 1


def reps(n, maxd=6):
    best = {}
    for combo in itertools.product(range(maxd + 1), repeat=n):
        s = sum(COST(c) for c in combo)
        if s not in best:
            best[s] = ''.join(str(c) for c in combo)
    return best


PRE = reps(6, 3)
SUF = reps(3, 6)
TOTALS = [int(x) for x in sys.argv[1].split(',')] if len(sys.argv) > 1 else [48, 53, 58, 63]
for P in sorted(PRE):
    if P > 40:
        continue
    for T in TOTALS:
        s = T - P
        if s not in SUF:
            continue
        cfg = PRE[P] + SUF[s]
        st = S.build(cfg)
        d, txt, fr = probe(st)
        print('P=%-3d S=%-3d T=%-3d %s insns=%d frame=%s delta=%s' %
              (P, s, T, cfg, len(st), fr, d), flush=True)
