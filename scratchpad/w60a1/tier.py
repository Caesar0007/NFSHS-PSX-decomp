#!/usr/bin/env python3
"""Cross the inversion list against the cross-fn-reference classes."""
import re
import sys
from pathlib import Path

SP = Path(sys.argv[1])
inv = {}
for ln in open(SP / "w60a1_order.txt", encoding="utf-8", errors="replace"):
    m = re.match(r"INVERSION (\S+):", ln)
    if m:
        p = m.group(1).replace("\\", "/")
        inv[p] = inv.get(p, 0) + 1

xf = {}
for ln in open(SP / "w60a1" / "xfn_all.txt", encoding="utf-8", errors="replace"):
    m = re.match(r"== (\S+)\s+A=(\d+) B=(\d+) C=(\d+)", ln)
    if m:
        xf[m.group(1)] = (int(m.group(2)), int(m.group(3)), int(m.group(4)))

t1 = t2 = t3 = 0
rows = []
for p, n in sorted(inv.items(), key=lambda kv: -kv[1]):
    a, b, c = xf.get(p, (0, 0, 0))
    if a or b:
        tier = 1
        t1 += 1
    elif c:
        tier = 2
        t2 += 1
    else:
        tier = 3
        t3 += 1
    rows.append((tier, n, a, b, c, p))
rows.sort(key=lambda r: (r[0], -r[1]))
print(f"{'TIER':<5}{'INV':<5}{'A':<3}{'B':<3}{'C':<4}OBJECT")
for tier, n, a, b, c, p in rows:
    print(f"{tier:<5}{n:<5}{a:<3}{b:<3}{c:<4}{p}")
print(f"\nobjects with inversions: {len(inv)}  total inversions: {sum(inv.values())}")
print(f"tier1(byte-visible)={t1}  tier2(intra-TU reloc)={t2}  tier3(external-only)={t3}")
