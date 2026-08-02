#!/usr/bin/env python3
"""reqdelta.py -- REQUIRED-DELTA RECEIPTS.

Given a function's -dg/-dl dumps and the RETAIL handout you want, search the
MINIMAL single-pseudo change to REG_N_REFS / REG_LIVE_LENGTH / REG_N_CALLS_CROSSED
that makes tools/allocsim.py (a validated replica of gcc-2.8 global_alloc)
produce that handout.

The three dials map 1:1 onto source-side levers already banked in the catalog:
  refs   -> the w44 floor_log2 REF-STEP family (zero-insn re-mask, deliberate
            arm duplication that cross-jumps back, do{}while(0) depth wrapper)
  live   -> last-USE position / default-then-override init / early-init demote
  calls  -> move a def or a last use across a call site (zero-insn when the
            value is already computed there); raising calls_crossed above
            refs/4 REMOVES the register entirely (CALLER_SAVE_PROFITABLE)

USAGE
  python tools/reqdelta.py <tu.greg> <tu.lreg> "<fn sig>" \
        --want "p82=t2,p166=t3,p90=none" [--only p90] [--max 40]
"""
import sys

sys.path.insert(0, 'tools')
import allocsim as A

INV = {v: k for k, v in A.NAME.items()}


def parse_want(spec):
    out = {}
    for t in spec.split(','):
        p, r = t.split('=')
        p = int(p.lstrip('pP'))
        r = r.strip()
        out[p] = None if r in ('none', 'mem', 'spill', '--') else \
            (int(r) if r.isdigit() else INV[r])
    return out


def build(greg, lreg, fn):
    L = A.parse_lreg(lreg, fn)
    order, conf, prefs, disp = A.parse_greg(greg, fn)
    return L, A.Sim(L, order, conf, prefs, disp,
                    A.parse_copy_prefs(lreg, fn), A.parse_ever_live(lreg, fn))


def hits(sim, want, ov):
    _, got = sim.run(ov)
    return all(got.get(p) == r for p, r in want.items())


def main():
    greg, lreg, fn = sys.argv[1], sys.argv[2], sys.argv[3]
    want = {}
    only = None
    span = 40
    a = sys.argv[4:]
    for i, x in enumerate(a):
        if x == '--want':
            want = parse_want(a[i + 1])
        elif x == '--only':
            only = [int(v.lstrip('pP')) for v in a[i + 1].split(',')]
        elif x == '--max':
            span = int(a[i + 1])

    L, sim = build(greg, lreg, fn)
    order, base = sim.run()
    print('BASE handout (== our build, allocsim-verified):')
    for p in order:
        print('   p%-5d %-4s  refs=%-3d live=%-4d calls=%-2d  pri=%.4f'
              % (p, A.rname(base.get(p)), L[p]['refs'], L[p]['live'],
                 L[p]['calls'], A.priority(L[p]['refs'], L[p]['live'],
                                           L[p]['size']) / 10000.0))
    print('\nWANT:', {('p%d' % p): A.rname(r) for p, r in want.items()})
    if hits(sim, want, None):
        print('  ALREADY SATISFIED.')
        return

    cands = only if only else order
    found = []
    for p in cands:
        d = L.get(p)
        if not d:
            continue
        for key in ('refs', 'live', 'calls'):
            base_v = d[key]
            lo = 0 if key == 'calls' else 1
            for v in range(max(lo, base_v - span), base_v + span + 1):
                if v == base_v:
                    continue
                if hits(sim, want, {p: {key: v}}):
                    found.append((abs(v - base_v), p, key, base_v, v))
    found.sort()
    if not found:
        print('\nNo SINGLE-dial delta in +-%d reaches it; try --max larger or a '
              'two-dial combination (see the pair search below).' % span)
        pairs(sim, L, want, cands, span)
        return
    print('\nMINIMAL SINGLE-DIAL DELTAS (smallest |delta| first):')
    seen = set()
    for dist, p, key, o, n in found:
        if (p, key) in seen:
            continue
        seen.add((p, key))
        print('   p%-5d %-5s %4d -> %-4d   |d|=%-3d   %s'
              % (p, key, o, n, dist, explain(key, o, n)))


def explain(key, o, n):
    if key == 'refs':
        return ('REF-STEP: floor_log2 %d->%d' % (A.floor_log2(o), A.floor_log2(n))
                if A.floor_log2(o) != A.floor_log2(n) else 'ref count only')
    if key == 'live':
        return 'live-length dial (last-USE position / early-init demote)'
    return ('CALLER_SAVE_PROFITABLE flips: 4*%d<refs -> 4*%d<refs' % (o, n))


def pairs(sim, L, want, cands, span):
    print('\nTWO-DIAL search (same pseudo, refs+live):')
    for p in cands:
        d = L.get(p)
        if not d:
            continue
        for r in range(max(1, d['refs'] - 8), d['refs'] + 9):
            for lv in range(max(1, d['live'] - span), d['live'] + span + 1, 2):
                if r == d['refs'] and lv == d['live']:
                    continue
                if hits(sim, want, {p: {'refs': r, 'live': lv}}):
                    print('   p%-5d refs %d->%d  live %d->%d'
                          % (p, d['refs'], r, d['live'], lv))
                    return
    print('   none found')


if __name__ == '__main__':
    main()
