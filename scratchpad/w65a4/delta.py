#!/usr/bin/env python3
"""w65a4 -- turn the census artefacts into the CENSUS.md tables + the W64->W65 delta."""
import json
from pathlib import Path

D = Path(__file__).resolve().parent


def load(n):
    return json.load(open(D / n, encoding="utf-8"))


board = {tuple(k.split("|", 1)): v for k, v in load("board_rows.json").items()}
gate = {tuple(k.split("|", 1)): v for k, v in load("gate_rows.json").items()}
brd = {tuple(k.split("|", 1)): v for k, v in load("brdist_rows.json").items()}
cls = load("classified.json")
w64 = {tuple(k.split("|", 1)): v for k, v in load("w64a21_baseline.json").items()}

tot = len(board)
at100 = sum(1 for v in board.values() if v >= 100)
print(f"BOARD  {at100}/{tot} = {100.0*at100/tot:.2f}%   (sub-100 rows: {tot-at100})")

order = [("a", "GATE_FAIL"), ("d", "BRANCH_REAL"), ("c", "ARTIFACT"),
         ("x", "GATE-ONLY (board blind)"), ("?", "UNRESOLVED")]
print("\n== CLASS COUNTS (w65a4) vs w64a21 ==")
w64c = {}
for k, v in w64.items():
    w64c[v["class"][0]] = w64c.get(v["class"][0], 0) + 1
# w64a21's raw label 'b_LANE_GAP' is the prose's class c (the 5 artefacts)
w64c["c"] = w64c.pop("b", 0)
w64c["x"] = w64c.pop("X", 0)
w64c.pop("e", None)                       # 'stale' is not a state, it is a refresh
for k, label in order:
    print(f"  {k} {label:26} w64a21={w64c.get(k,0):4}   w65a4={len(cls[k]):4}")

print("\n== CLASS d -- BRANCH WORDS REMAINING ==")
dnow = sorted(tuple(r[0].split("|", 1)) for r in cls["d"])
dwas = sorted(k for k, v in w64.items() if v["class"].startswith("d"))
print(f"  w64a21 {len(dwas)}  ->  w65a4 {len(dnow)}")
closed = [k for k in dwas if k not in dnow]
newly = [k for k in dnow if k not in dwas]
print(f"\n  CLOSED since w64a21 ({len(closed)}):")
for u, f in closed:
    print(f"    - {u:34} {f[:56]:58} now board={board.get((u,f),'?')}")
print(f"\n  NEW / newly-visible ({len(newly)}):")
for u, f in newly:
    print(f"    + {u:34} {f[:56]:58} board={board.get((u,f))}  {brd.get((u,f),'')[-60:]}")
print(f"\n  STILL OPEN ({len(set(dnow)&set(dwas))}):")
for u, f in sorted(set(dnow) & set(dwas)):
    print(f"      {u:34} {f[:56]:58} board={board.get((u,f))}")

print("\n== CLASS c -- ARTIFACTS REMAINING ==")
for r in sorted(cls["c"]):
    u, f = r[0].split("|", 1)
    print(f"    {u:34} {f[:56]:58} board={r[1]}")

print("\n== CLASS x -- GATE FAIL BUT BOARD 100 (board blind) ==")
for r in sorted(cls["x"]):
    u, f = r[0].split("|", 1)
    print(f"    {u:34} {f[:56]:58} gate={r[2]}")

print("\n== CLASS ? -- UNRESOLVED ==")
for r in sorted(cls["?"]):
    u, f = r[0].split("|", 1)
    print(f"    {u:34} {f[:56]:58} board={r[1]} gate={r[2]}")

print("\n== TOP class-a near-misses (gate FAIL, by diff count) ==")
rows = []
for r in cls["a"]:
    u, f = r[0].split("|", 1)
    n = int(r[2].split(":")[1]) if r[2].startswith("FAIL:") else 10 ** 9
    rows.append((n, u, f, r[1]))
for n, u, f, b in sorted(rows, reverse=True)[:20]:
    print(f"    {n:6}  {u:32} {f[:52]:54} board={b}")
print(f"\n  class-a total diff lines: {sum(n for n,_,_,_ in rows if n < 10**9)}")
