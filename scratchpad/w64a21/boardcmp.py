#!/usr/bin/env python3
"""w64a21 boardcmp.py -- compare a fresh objdiff report against MATCH_PROGRESS.txt.

Usage: python boardcmp.py REPORT.json [--all]
Prints rows whose fuzzy% differs from the committed board, plus the fresh totals
computed with update_match_progress.py's OWN accounting rules (SUPERSEDED skips,
.L filter) so the numbers are comparable.
"""
import json
import re
import sys
from pathlib import Path

ROOT = Path(r'C:\Temp\nfs4-decomp')

# mirrored verbatim from tools/update_match_progress.py (keep in sync)
SUPERSEDED = {
    ("game/common/spchevnt", "VoxEvent_GetFilterLengthFlag"),
    ("game/common/spchevnt", "iSPCH_GetOffset16"),
    ("syslib/psx/libpad/PAD", "PAD_convert"),
    ("syslib/psx/libpad/PAD", "ReadInitPadFlag"),
    ("frontend/common/fememcard", "___19tMemoryCardMenuItem"),
    ("frontend/common/femenuoptions", "Draw__27tMenuItemGoToMenuNFS4Buttonb"),
    ("game/common/aih_btcperp", "___15AIHigh_BTC_Perp"),
}


def load_report(p):
    rep = json.load(open(p, encoding='utf-8'))
    out = {}
    for unit in rep.get("units", []):
        uname = unit["name"].replace("\\", "/")
        for fn in unit.get("functions", []):
            name = fn["name"]
            if name.startswith(".L"):
                continue
            if (uname, name) in SUPERSEDED:
                continue
            out[(uname, name)] = float(fn.get("fuzzy_match_percent", 0.0))
    return out


def load_board():
    out = {}
    txt = (ROOT / 'MATCH_PROGRESS.txt').read_text(encoding='utf-8').splitlines()
    pat = re.compile(r'^(0x[0-9A-F]{8}|\s+-\s+)\s+([\d.]+)%\s+(\S+)\s+(\S+)\s*$')
    for ln in txt[6:]:
        m = pat.match(ln)
        if m:
            out[(m.group(3), m.group(4))] = (float(m.group(2)),
                                             m.group(1).strip())
    return out


def main():
    rep = load_report(sys.argv[1])
    board = load_board()
    show_all = '--all' in sys.argv

    tot = len(rep)
    matched = sum(1 for v in rep.values() if v >= 100.0)
    print(f"FRESH REPORT: {tot} functions, {matched} at 100% "
          f"({100.0*matched/tot:.2f}%)")
    btot = len(board)
    bmatch = sum(1 for v, _ in board.values() if v >= 100.0)
    print(f"COMMITTED BOARD: {btot} functions, {bmatch} at 100% "
          f"({100.0*bmatch/btot:.2f}%)")

    only_rep = set(rep) - set(board)
    only_board = set(board) - set(rep)
    print(f"rows only in fresh report: {len(only_rep)}")
    for k in sorted(only_rep):
        print(f"   +NEW  {rep[k]:6.2f}%  {k[0]}  {k[1]}")
    print(f"rows only in committed board: {len(only_board)}")
    for k in sorted(only_board):
        print(f"   -GONE {board[k][0]:6.2f}%  {k[0]}  {k[1]}")

    drift = []
    for k in sorted(set(rep) & set(board)):
        if abs(rep[k] - board[k][0]) > 0.005:
            drift.append((k, board[k][0], rep[k], board[k][1]))
    print(f"drifted rows: {len(drift)}")
    for k, b, r, va in drift:
        print(f"   {va:<11} {b:6.2f}% -> {r:6.2f}%  {k[0]}  {k[1]}")

    if show_all:
        print("\n--- fresh non-100 rows ---")
        for k in sorted(rep, key=lambda x: (rep[x], x)):
            if rep[k] < 100.0:
                va = board.get(k, (0, '?'))[1]
                print(f"{va:<11} {rep[k]:6.2f}%  {k[0]}  {k[1]}")


if __name__ == '__main__':
    main()
