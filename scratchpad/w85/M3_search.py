"""M3_search.py — structured (A, G, S) search with a structural metric.

A = depths of sites 1-5 (init-list lines 3191-3194, members +0xF28..+0xF94)
G = depth of the garage site (line 3205, member +0x1250)
S = depths of sites 7-9 (lines 3366-3368, members +0x29B0..+0x2A10)

Metric = reg-blind/sp-blind LCS diff count vs the JPN oracle (skelnr), plus the
call-135 indicator and the frame.  The gate's own count is not usable for
navigation here (see receipt).
"""
import re, sys, difflib, itertools, json
sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/w85')
import M3_score as S
from M3_probe1747 import probe

ORC = [t for t in S.ORACLE]


def sk(t):
    t = re.sub(r',-?\d+\(sp\)', ',S(sp)', t)
    t = re.sub(r'^(addiu sp,sp),-?\d+$', r'\1,S', t)
    t = re.sub(r'-?\b\d+\b', 'N', t)
    t = t.replace('HI', 'N').replace('LO', 'N')
    return re.sub(r'\b(zero|at|v[01]|a[0-3]|t[0-9]|s[0-7]|k[01]|gp|sp|fp|ra)\b', 'R', t)

B = [sk(x) for x in ORC]


def evaluate(cfg):
    st = S.build(cfg)
    A = [sk(t) for t, k in st]
    sm = difflib.SequenceMatcher(None, A, B, autojunk=False)
    n = sum((i2 - i1) + (j2 - j1) for tag, i1, i2, j1, j2 in sm.get_opcodes() if tag != 'equal')
    d, txt, fr = probe(st)
    return n, len(st), fr, d


COST = lambda d: 0 if d == 0 else 4 * d + 1

if __name__ == '__main__':
    Areps = {}
    for c in itertools.product(range(4), repeat=5):
        s = sum(COST(x) for x in c)
        Areps.setdefault(s, ''.join(map(str, c)))
    Sreps = {}
    for c in itertools.product(range(7), repeat=3):
        s = sum(COST(x) for x in c)
        Sreps.setdefault(s, ''.join(map(str, c)))
    res = []
    for a in sorted(Areps):
        for g in range(5):
            P = a + COST(g)
            want = [t for t in sorted(Sreps) if P + t >= 48 and P + t <= 60]
            if not want:
                continue
            s = want[0]
            cfg = Areps[a] + str(g) + Sreps[s]
            try:
                n, ln, fr, d = evaluate(cfg)
            except Exception as e:
                print('ERR', cfg, e, flush=True)
                continue
            res.append((n, cfg, ln, fr, d, a, COST(g), s))
            print('A=%-3d G=%-3d S=%-3d %s skelnr=%-4d insns=%d frame=%s delta=%s'
                  % (a, COST(g), s, cfg, n, ln, fr, d), flush=True)
    res.sort()
    print('BEST:', res[:10])
    json.dump(res, open('C:/Temp/nfs4-decomp/scratchpad/w85/M3_search.json', 'w'))
