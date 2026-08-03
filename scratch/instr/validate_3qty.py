#!/usr/bin/env python
"""w46-a10: validate the `next_qty == 3` local-alloc sort quirk against every
[qty_order] line in every instrumented-cc1 trace.

  python scratch/instr/validate_3qty.py [trace.txt ...]     (default: cmp/*/trace.txt)

CLAIM UNDER TEST (local-alloc.c:1588-1611):
  for next_qty == 3, gcc-2.8 does NOT qsort; it runs a hand-rolled sequence whose
  comparator `qty_compare(a,b)` takes QTY NUMBERS while EXCHANGE permutes qty_order,
  so the result is generally NOT priority-descending:

      if (P1 > P0) swap positions 0,1
      if (P2 > P1) swap positions 2,1
      if (P1 > P0) swap positions 0,1

  (P_k = QTY_CMP_PRI of qty number k, NOT of qty_order[k].)

RESULT on the w46 corpus (psxfront C++ / memcard C / hud C++ / drawc C++):
  38 three-qty blocks   -> 38/38 predicted EXACTLY by the model above (100 %)
  12 of those 38 (32 %) are NOT priority-descending
  435 blocks with != 3 qtys -> 435/435 correctly descending (the qsort path)
"""
import glob
import re
import sys

RE_ORDER = re.compile(r'^\[qty_order\s*\] \(qty/reg1:refs/life/calls/sg/csg=pri\):(.*)$')
RE_ENT = re.compile(r'(\d+)/(-?\d+):(\d+)/(-?\d+)/(\d+)/(\d+)/(\d+)=(-?\d+)')


def sim3(P):
    """The hand-rolled next_qty==3 sort, verbatim."""
    o = [0, 1, 2]

    def ex(i, j):
        o[i], o[j] = o[j], o[i]

    if P[1] > P[0]:
        ex(0, 1)
    if P[2] > P[1]:
        ex(2, 1)
    if P[1] > P[0]:
        ex(0, 1)
    return o


def main():
    files = sys.argv[1:] or glob.glob('scratch/instr/cmp/*/trace.txt')
    n3 = ok3 = nd3 = other = other_desc = 0
    for f in files:
        for line in open(f, errors='replace'):
            m = RE_ORDER.match(line.strip())
            if not m:
                continue
            rows = [(int(a), int(h))
                    for a, b, c, d, e, ff, g, h in RE_ENT.findall(m.group(1))]
            if not rows:
                continue
            qs = [q for q, _ in rows]
            pri = [p for _, p in rows]
            desc = all(pri[i] >= pri[i + 1] for i in range(len(pri) - 1))
            if len(rows) == 3:
                n3 += 1
                P = dict(rows)
                if all(k in P for k in (0, 1, 2)) and sim3([P[0], P[1], P[2]]) == qs:
                    ok3 += 1
                elif all(k in P for k in (0, 1, 2)):
                    print('MISPREDICT', f, qs, sim3([P[0], P[1], P[2]]))
                if not desc:
                    nd3 += 1
            else:
                other += 1
                other_desc += desc
                if not desc and len(rows) > 3:
                    print('UNEXPECTED non-descending %d-qty block' % len(rows), f)
    print('3-qty blocks : %d   model-exact %d   NOT priority-descending %d'
          % (n3, ok3, nd3))
    print('other blocks : %d   descending  %d' % (other, other_desc))


if __name__ == '__main__':
    main()
