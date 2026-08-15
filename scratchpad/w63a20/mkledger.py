#!/usr/bin/env python3
"""Emit PRODUCTION_LEDGER.csv (per-fn) + the per-TU roll-up table for the
W63-A20 ledger, from final_classified.json."""
import collections
import csv
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
rows = json.load(open(HERE / "final_classified.json"))
ctx = json.load(open(HERE / "ctx.json"))
meta = ctx["meta"]

with open(HERE / "PRODUCTION_LEDGER.csv", "w", newline="", encoding="utf-8") as f:
    w = csv.writer(f)
    w.writerow(["class", "REAL", "RELOP", "reloc", "words", "G", "extra_flags",
                "shim", "unit", "tu", "fn", "oracle_dir", "symsrc", "tail_pad", "note"])
    for r in sorted(rows, key=lambda x: (x["tu"], x["fn"])):
        m = meta.get(r["tu"], {})
        w.writerow([r["klass"], r.get("real", ""), r.get("relop", ""),
                    r.get("reloc", ""), r.get("words", ""), r.get("g", ""),
                    " ".join(r.get("extra") or []), r["shim"], m.get("unit", ""),
                    r["tu"], r["fn"], r.get("oracle_dir", ""), r.get("symsrc", ""),
                    r.get("tail_pad", 0), r.get("err", "")])

agg = collections.defaultdict(lambda: collections.Counter())
for r in rows:
    a = agg[r["tu"]]
    a["rows"] += 1
    a[r["klass"]] += 1
    a["real0"] += r["klass"].startswith("REAL0")
lines = ["| TU | rows | REAL=0 | clean | reloc-only | shim | lane N/A |",
         "|---|---:|---:|---:|---:|---:|---:|"]
for tu in sorted(agg):
    a = agg[tu]
    lines.append("| `%s` | %d | %d | %d | %d | %d | %d |"
                 % (tu, a["rows"], a["real0"], a["REAL0_CLEAN"],
                    a["REAL0_RELOC_ONLY"], a["SHIM_MASKED"], a["INAPPLICABLE_LANE"]))
(HERE / "per_tu_table.md").write_text("\n".join(lines) + "\n")
print("wrote PRODUCTION_LEDGER.csv (%d rows) + per_tu_table.md (%d TUs)"
      % (len(rows), len(agg)))
