#!/usr/bin/env python3
"""W66-A6 acceptance: the CLASS-D screen -- board rows below 100.00% whose
verify_asm gate nevertheless PASSes (the 04Q blind spot: verify_asm normalises
branch TARGETS, so a gate-PASS fn can still carry wrong branch words).

Reads MATCH_PROGRESS.txt, takes every row in [99, 100), maps unit -> recon TU,
and gates the function.  PASS => class-d.
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
rows = []
for ln in (ROOT / "MATCH_PROGRESS.txt").read_text(encoding="utf-8",
                                                  errors="replace").split("\n"):
    m = re.match(r"^(0x[0-9A-Fa-f]+)\s+(\d+\.\d+)%\s+(\S+)\s+(\S+)\s*$", ln)
    if m and 99.0 <= float(m.group(2)) < 100.0:
        rows.append((m.group(1), float(m.group(2)), m.group(3), m.group(4)))

# unit "game/common/audiocmn" -> recon/game/common/audiocmn.{cpp,c}
def tu_for(unit):
    for ext in (".cpp", ".c"):
        p = ROOT / "recon" / (unit + ext)
        if p.exists():
            return p.relative_to(ROOT).as_posix()
    return None


classd = []
for va, pct, unit, fn in rows:
    tu = tu_for(unit)
    if tu is None:
        print("%-12s %6.2f%%  %-28s %-50s  NO TU" % (va, pct, unit, fn))
        continue
    r = subprocess.run([sys.executable, "tools/verify_asm.py", tu, fn],
                       cwd=ROOT, capture_output=True, text=True)
    out = (r.stdout + r.stderr).strip().split("\n")
    verdict = next((l for l in out if "PASS" in l or "FAIL" in l
                    or "NO ORACLE" in l or "NOT IN OBJECT" in l), "?")
    tag = "CLASS-D" if "PASS" in verdict else ""
    if tag:
        classd.append((va, pct, unit, fn))
    print("%-12s %6.2f%%  %-28s %-46s %-22s %s"
          % (va, pct, unit, fn[:46], verdict.strip()[:22], tag))

print("\nrows screened: %d   CLASS-D (gate PASS, board <100): %d"
      % (len(rows), len(classd)))
for va, pct, unit, fn in classd:
    print("   %s %6.2f%% %s %s" % (va, pct, unit, fn))
