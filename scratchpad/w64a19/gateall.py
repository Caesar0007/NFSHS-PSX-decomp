#!/usr/bin/env python3
"""W64-A19: run tools/tugate.py over every TU affected by this agent's edits.
Usage: python scratchpad/w64a19/gateall.py <tag>
Writes scratchpad/w64a19/gate_<tag>.txt  (TU -> "n/m PASS")
"""
import importlib.util
import json
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools"))
sys.path.insert(0, str(ROOT / "scratchpad/w64a19"))
import apply_alias3 as A3

MINE = set(json.loads((ROOT / "scratchpad/w64a19/myfiles.json").read_text()))
tag = sys.argv[1]

tus = []
for p in sorted(list((ROOT / "recon").rglob("*.cpp")) + list((ROOT / "recon").rglob("*.c"))):
    rel = p.relative_to(ROOT).as_posix()
    clos = {f.relative_to(ROOT).as_posix() for f in A3.includes(p)
            if str(f).startswith(str(ROOT))}
    if clos & MINE:
        tus.append(rel)
assert tus, "no TUs -- refusing a vacuous gate"

out = {}
for t in tus:
    r = subprocess.run([sys.executable, str(ROOT / "tools/tugate.py"), t],
                       capture_output=True, text=True, cwd=ROOT)
    m = re.search(r":\s*(\d+)/(\d+) PASS", r.stdout)
    out[t] = m.group(0).strip() if m else ("ERR " + (r.stdout + r.stderr)[-200:].replace("\n", " "))
    print(f"{t}\t{out[t]}")
(ROOT / f"scratchpad/w64a19/gate_{tag}.json").write_text(json.dumps(out, indent=1))
