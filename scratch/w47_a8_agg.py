#!/usr/bin/env python3
"""w47-a8 aggregator: roll every scratch/sweep_*.json into

 (1) a per-TU verdict table (baseline + best flag + whether ANY flag met the bar), and
 (2) a per-FLAG census across ALL swept TUs:
       INERT   = compiled, but produced byte-identical results on this TU
       WORSE   = increased TOTALDIFF
       BETTER  = decreased TOTALDIFF
     An INERT count matters: an inert flag is UNFALSIFIED (the TU has no construct
     it can touch), NOT ruled out -- the distinction the wave needs recorded.
"""
import json
from collections import defaultdict
from pathlib import Path

SCRATCH = Path(__file__).resolve().parent

rows = []
flagstat = defaultdict(lambda: {"inert": 0, "worse": 0, "better": 0, "buildfail": 0,
                                "better_on": [], "worse_tot": 0})

for sj in sorted(SCRATCH.glob('sweep_*.json')):
    d = json.loads(sj.read_text())
    tu = d['tu']
    base = d['base']
    bt = sum(base.values())
    bp = sum(1 for v in base.values() if v == 0)
    best = None
    for row in d['rows']:
        f = row.get('flag')
        if row.get('status') == 'BUILDFAIL':
            flagstat[f]["buildfail"] += 1
            continue
        dl = row['delta']
        if dl == 0 and not row['better'] and not row['worse']:
            flagstat[f]["inert"] += 1
        elif dl < 0:
            flagstat[f]["better"] += 1
            flagstat[f]["better_on"].append(f"{Path(tu).stem}{dl:+d}")
        elif dl > 0:
            flagstat[f]["worse"] += 1
            flagstat[f]["worse_tot"] += dl
        else:
            flagstat[f]["inert"] += 1     # net zero but shuffled
        if dl < 0 and not row['regressions'] and (best is None or dl < best[1]):
            best = (f, dl, row['pass'] - bp)
    rows.append((Path(tu).stem, len(base), bp, bt, best))

print("== PER-TU VERDICT ==")
print(f"{'TU':14s} {'n':>3s} {'PASS':>5s} {'TOTDIFF':>8s}  RECOMMENDED FLAG")
for stem, n, bp, bt, best in sorted(rows, key=lambda r: -r[3]):
    print(f"{stem:14s} {n:3d} {bp:5d} {bt:8d}  " + (f"{best[0]} ({best[1]:+d}, PASS{best[2]:+d})" if best else "-- none --"))
print(f"\nTUs swept: {len(rows)}   with a recommendable flag: {sum(1 for r in rows if r[4])}")

print("\n== PER-FLAG CENSUS (across all swept TUs) ==")
print(f"{'flag':34s} {'INERT':>6s} {'WORSE':>6s} {'BETTER':>7s} {'BUILDFAIL':>10s}  better_on")
for f, s in sorted(flagstat.items(), key=lambda kv: (-kv[1]['better'], -kv[1]['inert'])):
    print(f"{f:34s} {s['inert']:6d} {s['worse']:6d} {s['better']:7d} {s['buildfail']:10d}  "
          + ",".join(s['better_on'][:6]))
