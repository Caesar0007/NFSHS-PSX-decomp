#!/usr/bin/env python3
"""W66-A6: classify brdist's divergent functions by BOARD state.

A divergent branch on a fn that is still a gate FAIL is expected (its word
stream differs anyway).  The blind-spot class -- the one W64 named with
PulloverCam -- is a divergence on a fn the board reports at 100.00%.
"""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
board = {}
for ln in (ROOT / "MATCH_PROGRESS.txt").read_text(encoding="utf-8",
                                                  errors="replace").split("\n"):
    m = re.match(r"^(0x[0-9A-Fa-f]+)\s+(\d+\.\d+)%\s+(\S+)\s+(\S+)\s*$", ln)
    if m:
        board[m.group(4)] = (float(m.group(2)), m.group(3), m.group(1))

rows = []
for ln in (ROOT / "scratchpad/w66a6/BRDIST.txt").read_text(
        encoding="utf-8", errors="replace").split("\n"):
    if not ln.startswith("[DIFF]"):
        continue
    tu = ln.split()[1]
    for part in ln.split("|", 1)[1].split(" ; "):
        fn = part.strip().split()[0]
        rows.append((tu, fn))

at100 = [(t, f) for t, f in rows if board.get(f, (0,))[0] == 100.0]
below = [(t, f) for t, f in rows if 0 < board.get(f, (0,))[0] < 100.0]
nob = [(t, f) for t, f in rows if f not in board]
print("brdist divergent fns: %d" % len(rows))
print("  board 100.00%% (BLIND-SPOT class): %d" % len(at100))
for t, f in at100:
    print("      %-10s %-28s %s" % (board[f][2], board[f][1], f))
print("  board <100%% (expected -- fn is a gate FAIL): %d" % len(below))
print("  not on the board at all: %d" % len(nob))
for t, f in nob:
    print("      %-58s %s" % (t, f))
