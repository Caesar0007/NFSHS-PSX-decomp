#!/usr/bin/env python
"""w48-a9 -- report a ladder JSON produced by w48_a9_axis.py.

Prints, per module, the BASE numbers and the delta of every other config,
plus the IDENTITY-BAR verdict:

   IDENTITY  = >0 FAIL->PASS conversions AND 0 PASS->FAIL regressions
               AND the converted fns land the oracle's exact insn count
   NUDGE     = diffs improve, no conversion (or a regression)
   WORSE / INERT

usage: python scratch/w48_a9_report.py <ledger.json> [--base BASE] [--only-wins]
"""
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def summ(res):
    p = sum(1 for v in res.values() if v and v[0] == 0)
    d = sum(v[0] for v in res.values() if v)
    c = sum(1 for v in res.values() if v and v[1] == v[2])
    return p, d, c


def main():
    path = sys.argv[1]
    base = 'BASE'
    only = '--only-wins' in sys.argv
    led = json.loads((ROOT / path).read_text())
    print('%-32s %-11s %6s %6s %6s %6s %6s   %s' %
          ('module', 'config', 'dDIFF', 'conv', 'regr', 'dCNT', 'PASS', 'verdict'))
    agg = {}
    for mod, cfgs in sorted(led.items()):
        if base not in cfgs:
            continue
        b = cfgs[base]
        bp, bd, bc = summ(b)
        for lab, res in cfgs.items():
            if lab == base:
                continue
            p, d, c = summ(res)
            conv = [f for f in res
                    if b.get(f) and res[f] and b[f][0] != 0 and res[f][0] == 0]
            regr = [f for f in res
                    if b.get(f) and res[f] and b[f][0] == 0 and res[f][0] != 0]
            if d == bd and p == bp and c == bc:
                v = 'INERT'
            elif conv and not regr:
                v = 'IDENTITY-CANDIDATE(' + ','.join(conv) + ')'
            elif d < bd and not regr:
                v = 'nudge'
            elif regr:
                v = 'REGR(' + ','.join(regr) + ')'
            else:
                v = 'worse'
            a = agg.setdefault(lab, [0, 0, 0, 0])
            a[0] += d - bd
            a[1] += len(conv)
            a[2] += len(regr)
            a[3] += c - bc
            if only and v in ('INERT', 'worse') :
                continue
            print('%-32s %-11s %+6d %6d %6d %+6d %6d   %s'
                  % (mod[:32], lab, d - bd, len(conv), len(regr), c - bc, bp, v[:70]))
    print()
    print('%-32s %-11s %6s %6s %6s %6s' %
          ('CLUSTER TOTAL', 'config', 'dDIFF', 'conv', 'regr', 'dCNT'))
    for lab, a in agg.items():
        print('%-32s %-11s %+6d %6d %6d %+6d' % ('', lab, a[0], a[1], a[2], a[3]))


if __name__ == '__main__':
    main()
