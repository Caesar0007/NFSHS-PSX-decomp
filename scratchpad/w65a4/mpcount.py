#!/usr/bin/env python3
"""w65a4 -- report MATCH_PROGRESS.txt's numbers WITHOUT writing the file.

tools/update_match_progress.py has no --out option: running it rewrites the
tracked MATCH_PROGRESS.txt, and in a 20-belt wave a peer `git add -A` could
sweep that into their commit.  The mission says report the regen numbers, do
NOT commit them -- so this replicates the tool's counting rule exactly
(skip `.L*`, skip its SUPERSEDED list, matched = fuzzy >= 100.0) and is
VALIDATED against a known positive: w64a21's board_final.json must reproduce
that census's published 3358/3489.

Usage: python scratchpad/w65a4/mpcount.py <report.json> [<report.json> ...]
"""
import json
import sys
from pathlib import Path

# verbatim from tools/update_match_progress.py
SUPERSEDED = {
    ("game/common/spchevnt", "VoxEvent_GetFilterLengthFlag"),
    ("game/common/spchevnt", "iSPCH_GetOffset16"),
    ("syslib/psx/libpad/PAD", "PAD_convert"),
    ("syslib/psx/libpad/PAD", "ReadInitPadFlag"),
    ("frontend/common/fememcard", "___19tMemoryCardMenuItem"),
    ("frontend/common/femenuoptions", "Draw__27tMenuItemGoToMenuNFS4Buttonb"),
    ("game/common/aih_btcperp", "___15AIHigh_BTC_Perp"),
}
BACKSLASH = chr(92)


def count(p):
    rep = json.load(open(p, encoding="utf-8"))
    tot = m = 0
    for u in rep.get("units", []):
        un = u["name"].replace(BACKSLASH, "/")
        for f in u.get("functions", []):
            n = f["name"]
            if n.startswith(".L") or (un, n) in SUPERSEDED:
                continue
            tot += 1
            if float(f.get("fuzzy_match_percent", 0.0)) >= 100.0:
                m += 1
    return m, tot


ROOT = Path(__file__).resolve().parents[2]
ctl = ROOT / "scratchpad" / "w64a21" / "board_final.json"
if ctl.exists():
    m, t = count(ctl)
    ok = (m, t) == (3358, 3489)
    print(f"CONTROL w64a21/board_final.json -> {m}/{t} "
          f"({100.0*m/t:.1f}%)  [published 3358/3489]  "
          f"{'REPLICATION VALID' if ok else 'MISMATCH -- DO NOT USE'}")
    if not ok:
        sys.exit(1)

for p in sys.argv[1:]:
    m, t = count(p)
    print(f"{Path(p).name:24} -> {m}/{t} = {100.0*m/t:.1f}%   "
          f"(sub-100 rows: {t-m})")
