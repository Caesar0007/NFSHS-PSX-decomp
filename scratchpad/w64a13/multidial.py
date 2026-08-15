#!/usr/bin/env python3
"""w63a12_multidial.py -- multi-pseudo dial search on top of allocsim/reqdelta.

reqdelta only searches ONE pseudo (and a same-pseudo refs+live pair).  When the
retail handout needs several independent priority swaps (a whole t-band
permutation) the answer is a SET of per-pseudo deltas.  This driver:
  * prints the base handout + priority table,
  * evaluates an explicit override set given on the command line,
  * and (with --search) greedily searches per-pseudo refs deltas that reduce
    the number of mismatching WANT entries.

usage:
  python w63a12_multidial.py <greg> <lreg> "<fn>" --want "p80=t0,..." \
        [--ov "p82:refs=3,p147:live=90"] [--search]
"""
import sys, itertools, os

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.insert(0, os.path.join(ROOT, 'tools'))
import allocsim as A
import reqdelta as R


def parse_ov(spec):
    out = {}
    if not spec:
        return out
    for t in spec.split(','):
        p, kv = t.split(':')
        k, v = kv.split('=')
        out.setdefault(int(p.lstrip('pP')), {})[k] = int(v)
    return out


def score(sim, want, ov):
    _, got = sim.run(ov)
    return sum(1 for p, r in want.items() if got.get(p) != r), got


def main():
    greg, lreg, fn = sys.argv[1], sys.argv[2], sys.argv[3]
    want, ov, do_search = {}, {}, False
    a = sys.argv[4:]
    for i, x in enumerate(a):
        if x == '--want':
            want = R.parse_want(a[i + 1])
        elif x == '--ov':
            ov = parse_ov(a[i + 1])
        elif x == '--search':
            do_search = True

    L, sim = R.build(greg, lreg, fn)
    order, base = sim.run(ov or None)
    print('handout with ov=%s' % (ov or {}))
    for p in order:
        d = L[p]
        o = ov.get(p, {})
        refs = o.get('refs', d['refs'])
        live = o.get('live', d['live'])
        mark = ''
        if p in want:
            mark = 'OK' if base.get(p) == want[p] else 'want ' + A.rname(want[p])
        print('   p%-5d %-4s refs=%-3d live=%-4d pri=%.4f   %s'
              % (p, A.rname(base.get(p)), refs, live,
                 A.priority(refs, live, d['size']) / 10000.0, mark))
    bad, _ = score(sim, want, ov or None)
    print('MISMATCHES:', bad)

    if do_search:
        cur = dict((k, dict(v)) for k, v in ov.items())
        best, _ = score(sim, want, cur or None)
        print('\ngreedy search from %d mismatches' % best)
        improved = True
        while improved and best:
            improved = False
            for p in order:
                d = L.get(p)
                if not d:
                    continue
                for key, span in (('refs', 24), ('live', 200)):
                    for v in range(1, d[key] + span):
                        trial = dict((k, dict(x)) for k, x in cur.items())
                        trial.setdefault(p, {})[key] = v
                        s, _ = score(sim, want, trial)
                        if s < best:
                            best, cur, improved = s, trial, True
                            print('   p%d %s %d->%d  mismatches %d'
                                  % (p, key, d[key], v, best))
                            break
                    if improved:
                        break
                if improved:
                    break
        print('final', best, cur)


if __name__ == '__main__':
    main()
