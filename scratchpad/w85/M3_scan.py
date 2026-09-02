"""M3_scan.py — 2-D chain-object scan.

The nine device sites split at the menuCarUpgrades construction (init-list line
3303): sites 1-6 (weather/traffic/speech/mto_dir/mto_mir/garage, lines ~3191-3205)
sit BEFORE it, sites 7-9 (dpos/dlap/dsplit, lines 3343-3345) sit AFTER it and
BEFORE the controller-iterator run (line 3354+).  So the prefix sum controls the
ordinal shift at BOTH divergence sites, the suffix sum only at the later one.

Cost per site: depth 0 = 0 objects, depth d = 4d+1 (5 / 9 / 13).

usage: python M3_scan.py prefix <suffix>   scan prefix sums, suffix fixed
       python M3_scan.py suffix <prefix>   scan suffix sums, prefix fixed
"""
import sys, itertools, json
sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/w85')
import M3_score as S

COST = {0: 0, 1: 5, 2: 9, 3: 13}


def reps(n):
    """one representative config-string per achievable object-sum over n sites"""
    best = {}
    for combo in itertools.product('0123', repeat=n):
        s = sum(COST[int(c)] for c in combo)
        if s not in best:
            best[s] = ''.join(combo)
    return best


if __name__ == '__main__':
    what = sys.argv[1]
    other = sys.argv[2]
    res = []
    table = reps(6 if what == 'prefix' else 3)
    for s in sorted(table):
        cfg = (table[s] + other) if what == 'prefix' else (other + table[s])
        n, ln, err, bad = S.score(cfg)
        res.append((n if n is not None else 999999, s, cfg, ln, err))
        print('sum=%-3d %s score=%s insns=%d %s' % (s, cfg, n, ln, err), flush=True)
    res.sort()
    print('BEST:', res[:8])
    json.dump(res, open('C:/Temp/nfs4-decomp/scratchpad/w85/M3_scan_%s.json' % what, 'w'))
