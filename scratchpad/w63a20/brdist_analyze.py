#!/usr/bin/env python3
"""Cross-validate the tree-wide brdist census against the board and the
production prover.

A branch-DISTANCE divergence only matters as a *production bug hiding behind a
green gate* when the fn is at 100.00% on the board (verify_asm normalises branch
targets, so it reads PASS anyway).  For every such hit this prints the matching
psyqproof result from the W63 sweep (EA rows) so the two screens can be compared
(A15: they agree exactly).
"""
import json
import re
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = Path(r"C:/Temp/nfs4-decomp")

board = {}
for ln in open(ROOT / "MATCH_PROGRESS.txt", encoding="utf-8", errors="replace"):
    m = re.match(r"^(0x[0-9A-F]+)\s+(\d+\.\d+)%\s+(\S+)\s+(\S+)\s*$", ln)
    if m:
        board[(m.group(3), m.group(4))] = float(m.group(2))

pq = {}
p = HERE / "final_classified.json"
if p.exists():
    for r in json.load(open(p)):
        pq[(r["tu"], r["fn"])] = r

cur = None
hits = []
CENSUS = HERE / (sys.argv[1] if len(sys.argv) > 1 else "brdist_tree.txt")
for ln in open(CENSUS, encoding="utf-8", errors="replace"):
    m = re.match(r"^### (\S+)", ln)
    if m:
        cur = m.group(1)
        continue
    m = re.match(r"^(\S+)\s+(\d+ offset diffs|BRANCH COUNT \S+ vs \S+)", ln.rstrip())
    if m and cur:
        hits.append((cur, m.group(1), m.group(2), ln.rstrip()))

unit_of = lambda tu: tu[len("recon/"):].rsplit(".", 1)[0]
print("brdist hits: %d" % len(hits))
green, notgreen = [], []
for tu, fn, kind, raw in hits:
    pct = board.get((unit_of(tu), fn))
    (green if pct is not None and pct >= 100.0 else notgreen).append((tu, fn, kind, pct, raw))

print("\n=== A. HITS ON GATE-PASSING (100.00 pct) FNS -- the PulloverCam class: %d ===" % len(green))
print("%-46s %-52s %-18s %s" % ("TU", "fn", "brdist", "psyqproof"))
for tu, fn, kind, pct, raw in sorted(green, key=lambda x: x[0]):
    r = pq.get((tu, fn))
    if r is None:
        pqs = "(syslib / not in EA sweep)"
    elif r["status"] != "OK":
        pqs = r["status"]
    else:
        pqs = "REAL=%d RELOP=%d reloc=%d  %s" % (r["real"], r["relop"], r["reloc"],
                                                 r["shim"] or "no shim")
    print("%-46s %-52s %-18s %s" % (tu[6:], fn[:52], kind, pqs))

print("\n=== B. HITS ON NON-100 pct FNS (known near-misses): %d ===" % len(notgreen))
for tu, fn, kind, pct, raw in sorted(notgreen, key=lambda x: x[0])[:80]:
    print("  %-44s %-50s %-18s board=%s" % (tu[6:], fn[:50], kind, pct))

print("\n=== C. AGREEMENT CHECK (A: brdist-hit + gate-PASS) ===")
agree = dis = nosweep = 0
for tu, fn, kind, pct, raw in green:
    r = pq.get((tu, fn))
    if r is None or r["status"] != "OK":
        nosweep += 1
    elif r["real"] + r["relop"] > 0:
        agree += 1
    else:
        dis += 1
print("brdist hit AND psyqproof REAL/RELOP>0 : %d" % agree)
print("brdist hit BUT psyqproof REAL=0       : %d   <-- brdist-only signal" % dis)
print("not covered by the EA sweep (syslib)  : %d" % nosweep)
for tu, fn, kind, pct, raw in green:
    r = pq.get((tu, fn))
    if r is not None and r["status"] == "OK" and r["real"] + r["relop"] == 0:
        print("   brdist-only: %-44s %s   %s" % (tu[6:], fn, kind))
