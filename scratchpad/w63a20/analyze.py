#!/usr/bin/env python3
"""W63-A20 sweep analysis + W62 regression diff.

Classes (same taxonomy as the W62 ledger so the two are comparable):
  REAL0_CLEAN        REAL=0 RELOP=0 reloc=0
  REAL0_RELOC_ONLY   REAL=0 RELOP=0, reloc-site diffs only
  SHIM_MASKED        REAL+RELOP > 0 AND a build.py per-fn shim covers the fn
  LANE_DIVERGENT     REAL+RELOP > 0 with NO shim
  INAPPLICABLE_LANE  TU wired to cc1_272 / cc1_alt / cc1_ver
  HARNESS_GAP        any other non-OK status
"""
import collections
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ctx = json.load(open(HERE / "ctx.json"))
shims = ctx["shims"]
rows = [json.loads(l) for l in open(HERE / "final.jsonl", encoding="utf-8")]
assert len(rows) == 2972, len(rows)


def klass(r):
    if r["status"] == "TU_BUILD_FAIL":
        return "INAPPLICABLE_LANE" if "INAPPLICABLE-LANE" in r.get("err", "") \
            else "HARNESS_GAP"
    if r["status"] != "OK":
        return "HARNESS_GAP"
    tot = r["real"] + r["relop"]
    if tot == 0:
        return "REAL0_CLEAN" if r["reloc"] == 0 else "REAL0_RELOC_ONLY"
    return "SHIM_MASKED" if shims.get(f"{r['tu']}|{r['fn']}") else "LANE_DIVERGENT"


for r in rows:
    r["klass"] = klass(r)
    r["shim"] = ",".join(shims.get(f"{r['tu']}|{r['fn']}", [])) or ""

cnt = collections.Counter(r["klass"] for r in rows)
print("=== W63 CLASSES ===")
for k in ("REAL0_CLEAN", "REAL0_RELOC_ONLY", "SHIM_MASKED", "LANE_DIVERGENT",
          "INAPPLICABLE_LANE", "HARNESS_GAP"):
    print("%-20s %5d" % (k, cnt[k]))
real0 = cnt["REAL0_CLEAN"] + cnt["REAL0_RELOC_ONLY"]
print("REAL=0 total       %5d  (%.2f%% of %d board rows, %.2f%% of the %d provable)"
      % (real0, 100.0 * real0 / len(rows), len(rows),
         100.0 * real0 / (len(rows) - cnt["INAPPLICABLE_LANE"]),
         len(rows) - cnt["INAPPLICABLE_LANE"]))

print("\n=== PER SCOPE ===")
scope = collections.defaultdict(lambda: [0, 0])
for r in rows:
    s = "/".join(r["tu"].split("/")[1:3])
    scope[s][1] += 1
    scope[s][0] += r["klass"].startswith("REAL0")
for s in sorted(scope):
    a, b = scope[s]
    print("%-20s %4d/%4d  %6.1f%%" % (s, a, b, 100.0 * a / b))

print("\n=== NON-ZERO ROWS (REAL desc) ===")
bad = [r for r in rows if r["klass"] in ("SHIM_MASKED", "LANE_DIVERGENT")]
print("%4s %5s %5s %5s  %-24s %-28s %s" % ("REAL", "RELOP", "TOT", "words",
                                           "shim", "unit", "fn"))
for r in sorted(bad, key=lambda x: -(x["real"] + x["relop"])):
    print("%4d %5d %5d %5d  %-24s %-28s %s"
          % (r["real"], r["relop"], r["real"] + r["relop"], r["words"],
             r["shim"] or "-- NONE --", r["tu"][6:-4].replace("/", "/"), r["fn"]))

# ---- W62 regression diff ------------------------------------------------
prev = {}
for name in ("final.jsonl", "dial.jsonl", "refail.jsonl", "full.jsonl"):
    p = HERE.parent / "w62a20" / name
    if not p.exists():
        continue
    for ln in open(p, encoding="utf-8"):
        r = json.loads(ln)
        k = (r["tu"], r["fn"])
        if r["status"] == "OK" and (k not in prev or prev[k]["status"] != "OK"):
            prev[k] = r
        elif k not in prev:
            prev[k] = r
print("\n=== W62 -> W63 REGRESSION DIFF (rows present in both) ===")
moved = []
for r in rows:
    k = (r["tu"], r["fn"])
    o = prev.get(k)
    if not o:
        continue
    if o["status"] == "OK" and r["status"] == "OK":
        d = (r["real"] + r["relop"]) - (o["real"] + o["relop"])
        if d or r["reloc"] != o["reloc"]:
            moved.append((d, r["reloc"] - o["reloc"], k, o, r))
    elif o["status"] != r["status"]:
        moved.append((None, None, k, o, r))
worse = [m for m in moved if m[0] is not None and m[0] > 0]
better = [m for m in moved if m[0] is not None and m[0] < 0]
print("rows compared: %d   REAL+RELOP worse: %d   better: %d   status-changed: %d"
      % (sum(1 for r in rows if (r["tu"], r["fn"]) in prev),
         len(worse), len(better), sum(1 for m in moved if m[0] is None)))
for d, dr, k, o, r in moved:
    if d is None:
        print("  STATUS %-52s %-28s  %s -> %s"
              % (k[0][6:], k[1][:28], o["status"], r["status"]))
    else:
        print("  %+5d (reloc %+d) %-46s %s   %s->%s"
              % (d, dr, k[0][6:], k[1][:40],
                 o["real"] + o.get("relop", 0), r["real"] + r["relop"]))
new = [r for r in rows if (r["tu"], r["fn"]) not in prev]
print("rows NEW since W62 (fns sealed after the W62 sweep): %d" % len(new))
for r in new:
    print("  %-52s %-44s %s" % (r["tu"][6:], r["fn"][:44], r["klass"]))

json.dump(rows, open(HERE / "final_classified.json", "w"), indent=0)
