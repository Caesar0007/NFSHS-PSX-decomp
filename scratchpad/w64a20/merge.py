#!/usr/bin/env python3
"""Merge a retry jsonl over the base sweep jsonl (last write per (tu,fn) wins).

Used for recon/game/psx/draww.cpp: its build/<tu>.i was rewritten by a
CONCURRENT belt mid-sweep (mtime 13:54, inside the run window) and cc1 read a
half-written file -> "parse error at end of input".  Re-run alone: 26/26 OK.
"""
import json
import sys

base = {}
order = []
for path in sys.argv[1:-1]:
    for ln in open(path, encoding="utf-8"):
        r = json.loads(ln)
        k = (r["tu"], r["fn"])
        if k not in base:
            order.append(k)
        base[k] = r
with open(sys.argv[-1], "w", encoding="utf-8") as f:
    for k in order:
        f.write(json.dumps(base[k]) + "\n")
print("merged rows:", len(order))
