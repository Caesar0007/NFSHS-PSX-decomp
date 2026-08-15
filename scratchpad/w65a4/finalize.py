#!/usr/bin/env python3
"""w65a4 -- FINAL board read + reclassification.

census.py's step 3c proved the board moved between run 1 and the post-gate
re-read (2 rows), and it rebased the classification onto the re-read -- but
board_rows.json (and therefore delta.py) still carried the run-1 numbers.  That
mismatch made physics look CLOSED and screenmemcard look still-open.

This takes a FINAL board read (x2 for reproducibility) over the objects as the
gate/brdist steps left them -- i.e. all 76 sub-100 TUs freshly compiled from
committed source -- gates any sub-100 row that has no verdict yet, and rewrites
board_rows.json / gate_rows.json / classified.json coherently from ONE board.
"""
import json
import subprocess
import sys
from pathlib import Path

ROOT = Path(r"C:\Temp\nfs4-decomp")
CLI = r"C:/Temp/nfs4-clean/objdiff-cli.exe"
PY = sys.executable
D = ROOT / "scratchpad" / "w65a4"


def board(tag):
    p = D / f"report_final_{tag}.json"
    r = subprocess.run([CLI, "report", "generate", "-o", str(p)],
                       cwd=str(ROOT), capture_output=True, text=True)
    if r.returncode:
        sys.exit(r.stderr[-800:])
    rep = json.load(open(p, encoding="utf-8"))
    rows = {}
    for u in rep["units"]:
        for f in u.get("functions", []):
            if not f["name"].startswith(".L"):
                rows[(u["name"], f["name"])] = round(
                    float(f.get("fuzzy_match_percent", 0.0)), 4)
    return rows, rep.get("measures", {})


b1, m = board("a")
b2, _ = board("b")
print(f"FINAL board: {len(b1)} rows, {sum(1 for v in b1.values() if v>=100)} at 100%")
print(f"  reproducible (run1 == run2): {b1 == b2}")
print(f"  matched_code_percent = {m.get('matched_code_percent')}")

gate = {tuple(k.split("|", 1)): v
        for k, v in json.load(open(D / "gate_rows.json")).items()}
brd = {tuple(k.split("|", 1)): v
       for k, v in json.load(open(D / "brdist_rows.json")).items()}
cfg = json.loads((ROOT / "objdiff.json").read_text(encoding="utf-8"))
usrc = {u["name"]: u.get("metadata", {}).get("source_path") for u in cfg["units"]}

missing = sorted({k for k, v in b1.items() if v < 100 and k not in gate})
print(f"\nsub-100 rows with no gate verdict yet: {len(missing)}")
by_unit = {}
for u, f in missing:
    by_unit.setdefault(u, []).append(f)
for u, fns in by_unit.items():
    src = usrc.get(u)
    if not src or not (ROOT / src).exists():
        continue
    r = subprocess.run([PY, str(D / "_gate_driver.py"), src, "\x1f".join(fns)],
                       cwd=str(ROOT), capture_output=True, text=True)
    for ln in r.stdout.splitlines():
        if "\t" in ln:
            fn, v = ln.split("\t", 1)
            gate[(u, fn)] = v.strip()
            print(f"  gated {u} {fn}: {v.strip()}")
    # brdist too, so the row can be classified d vs c
    rb = subprocess.run([PY, "tools/brdist.py", src], cwd=str(ROOT),
                        capture_output=True, text=True)
    import re as _re
    BRFN = _re.compile(r"^(\S+)\s+(?:(\d+) offset diffs|BRANCH COUNT)")
    for ln in rb.stdout.splitlines():
        if not ln.startswith("#") and BRFN.match(ln.rstrip()):
            brd[(u, BRFN.match(ln.rstrip()).group(1))] = ln.strip()

cls = {"a": [], "d": [], "c": [], "x": [], "?": []}
for key, fz in sorted(b1.items()):
    g, hit = gate.get(key), key in brd
    if fz < 100:
        if g is None or g in ("NOORACLE", "NOTINOBJ", "COMPILEFAIL"):
            cls["?"].append([f"{key[0]}|{key[1]}", fz, g, hit])
        elif g.startswith("FAIL"):
            cls["a"].append([f"{key[0]}|{key[1]}", fz, g, hit])
        else:
            cls["d" if hit else "c"].append([f"{key[0]}|{key[1]}", fz, g, hit])
    elif g and g.startswith("FAIL"):
        cls["x"].append([f"{key[0]}|{key[1]}", fz, g, hit])

json.dump({f"{k[0]}|{k[1]}": v for k, v in b1.items()},
          open(D / "board_rows.json", "w"), indent=0)
json.dump({f"{k[0]}|{k[1]}": v for k, v in gate.items()},
          open(D / "gate_rows.json", "w"), indent=0)
json.dump({f"{k[0]}|{k[1]}": v for k, v in brd.items()},
          open(D / "brdist_rows.json", "w"), indent=0)
json.dump(cls, open(D / "classified.json", "w"), indent=1)
print("\nFINAL CLASSES: " + "  ".join(f"{k}={len(v)}" for k, v in cls.items()))
