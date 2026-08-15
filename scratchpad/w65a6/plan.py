#!/usr/bin/env python3
"""W65-A6: for every still-unresolved symbol, recover its VA breadcrumb from the
referencing recon source and classify it: BSS (>= 0x8013E000) -> needs a real
object-owned definition; in-image -> check whether a splat blob dlabel already
defines that VA (-> asm-label alias) or not (-> blob cut needed first)."""
import json
import re
import glob
import os
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
BSS_ORG = 0x8013E000

cen = json.load(open(ROOT / "scratchpad/w65a6/census_recon.json"))
unres = sorted(cen["real_unres"])

# splat blob dlabels: name -> file
dlabels = {}
for f in glob.glob(str(ROOT / "asm/data/*.s")):
    try:
        txt = open(f, encoding="latin-1").read()
    except OSError:
        continue
    for m in re.finditer(r"^dlabel\s+(\S+)\s*$", txt, re.M):
        dlabels.setdefault(m.group(1), os.path.basename(f))

# symbol_addrs
sa = {}
for line in open(ROOT / "configs/symbol_addrs.txt", encoding="latin-1"):
    m = re.match(r"^(\S+)\s*=\s*(0x[0-9A-Fa-f]+);", line.strip())
    if m:
        sa[m.group(1)] = int(m.group(2), 16)

rows = []
for sym in unres:
    objs = cen["real_unres"][sym]
    hits = cen["real_unres_hits"][sym]
    va = sa.get(sym)
    src = ""
    if va is None:
        # hunt an @0xVA breadcrumb on a line mentioning the symbol
        for o in objs:
            p = ROOT / o.split("build/")[-1].replace(".o", "")
            if not p.exists():
                continue
            for line in open(p, encoding="latin-1"):
                if re.search(r"\b" + re.escape(sym) + r"\b", line):
                    m = re.search(r"@\s*(0x[0-9A-Fa-f]{8})", line)
                    if m:
                        va = int(m.group(1), 16)
                        src = p.name
                        break
            if va:
                break
    kind = "?"
    note = ""
    if va:
        kind = "BSS" if va >= BSS_ORG else "IMAGE"
        if kind == "IMAGE":
            nm = "D_%08X" % va
            note = dlabels.get(nm, dlabels.get("D_%08x" % va, "NO-DLABEL"))
    rows.append((sym, hits, "%08X" % va if va else "-", kind, note,
                 ";".join(o.split("build/recon/")[-1] for o in objs)[:70]))

rows.sort(key=lambda r: (-r[1]))
print("%-42s %4s %-8s %-6s %-28s %s" % ("symbol", "rel", "VA", "kind", "blob", "refs"))
for r in rows:
    print("%-42s %4d %-8s %-6s %-28s %s" % r)
