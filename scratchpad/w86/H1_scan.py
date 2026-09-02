"""H1_scan -- prefix-sum scan with the R1 and R2 INDICATORS (not just the gate).

W85-M3 scanned the gate/score; this scan reads the two tie-break indicators
directly, so the exact achievable windows are visible.

usage: python H1_scan.py prefix <suffix3digits> [maxsum]
"""
import sys, itertools
sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/w86')
import H1_score as S

COST = {0: 0, 1: 5, 2: 9, 3: 13}


def reps(n):
    best = {}
    for combo in itertools.product('0123', repeat=n):
        s = sum(COST[int(c)] for c in combo)
        if s not in best:
            best[s] = ''.join(combo)
    return best


if __name__ == '__main__':
    suffix = sys.argv[2] if len(sys.argv) > 2 else '133'
    mx = int(sys.argv[3]) if len(sys.argv) > 3 else 40
    table = reps(6)
    for s in sorted(k for k in table if k <= mx):
        cfg = table[s] + suffix
        st = S.build_cfg(cfg)
        n, ln, err, bad = S.score_stream(st)
        print('P=%-3d %s insns=%-5d frame=%-4s R2delta=%-4s R1=%-10s score=%s' %
              (s, cfg, ln, S.frame(st), S.probe1747(st), S.probeR1(st), n), flush=True)
