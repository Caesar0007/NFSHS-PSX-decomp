"""dialsearch.py GREG LREG "FN" --want "pN=reg,..." [--pool p1,p2,...] [--depth 2]
Brute-force search over 1..N simultaneous (pseudo,dial) overrides that make
allocsim's handout satisfy every --want.  Reports the smallest total |delta|.
Dial grid: refs +-14 (>=1), live +-70 (>=1).  Pool defaults to every allocno."""
import sys, itertools, importlib.util as _iu
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / 'tools'))
_sp = _iu.spec_from_file_location('allocsim', ROOT / 'tools' / 'allocsim.py')
A = _iu.module_from_spec(_sp); _sp.loader.exec_module(A)

greg, lreg, fn = sys.argv[1], sys.argv[2], sys.argv[3]
args = sys.argv[4:]
want_s, pool_s, depth = None, None, 2
i = 0
while i < len(args):
    if args[i] == '--want':   want_s = args[i+1]; i += 2
    elif args[i] == '--pool': pool_s = args[i+1]; i += 2
    elif args[i] == '--depth':depth = int(args[i+1]); i += 2
    else: i += 1
inv = {v: k for k, v in A.NAME.items()}
want = {}
for t in want_s.split(','):
    p, r = t.split('=')
    want[int(p.lstrip("p"))] = int(r) if r.isdigit() else inv[r]

L = A.parse_lreg(lreg, fn)
order, conf, prefs, disp = A.parse_greg(greg, fn)
sim = A.Sim(L, order, conf, prefs, disp, A.parse_copy_prefs(lreg, fn),
            A.parse_ever_live(lreg, fn))
pool = [int(x) for x in pool_s.split(',')] if pool_s else list(order)

# build candidate single overrides
cands = []            # (pseudo, key, newval, cost)
for p in pool:
    d = L.get(p)
    if not d: continue
    for k, lo, hi in (('refs', max(1, d['refs']-14), d['refs']+15),
                      ('live', max(1, d['live']-70), d['live']+71)):
        for v in range(lo, hi):
            if v != d[k]:
                cands.append((p, k, v, abs(v - d[k])))
print(f'pool {len(pool)} pseudos, {len(cands)} single dials, depth {depth}')

def ok(ov):
    _o, got = sim.run(ov)
    return all(got.get(q) == r for q, r in want.items())

best = []
for dep in range(1, depth+1):
    # group candidates by (pseudo,key) so a combo never dials the same knob twice
    byknob = {}
    for c in cands: byknob.setdefault((c[0], c[1]), []).append(c)
    knobs = sorted(byknob)
    found = []
    for combo in itertools.combinations(knobs, dep):
        if len({k[0] for k in combo}) != dep and dep > 1:
            pass                       # allow refs+live on same pseudo
        for pick in itertools.product(*[byknob[k] for k in combo]):
            ov = {}
            cost = 0
            for p, k, v, c in pick:
                ov.setdefault(p, {})[k] = v; cost += c
            if best and cost >= best[0][0]:
                continue
            if ok(ov):
                found.append((cost, {p: dict(d) for p, d in ov.items()}))
                best = sorted(found)[:1]
    if found:
        found.sort()
        print(f'\nDEPTH {dep}: {len(found)} solutions, best 12:')
        for cost, ov in found[:12]:
            print('   cost %-4d %s' % (cost, ov))
        break
    print(f'DEPTH {dep}: none')
