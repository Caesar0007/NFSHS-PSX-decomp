#!/usr/bin/env python3
"""W66-A6 acceptance: brdist over EVERY recon TU (the 3rd gate blind spot --
verify_asm normalises branch TARGETS, so a byte-equal word stream can still
carry a wrong branch DISTANCE).

ANTI-VACUITY (catalog W43-20 "validate any census tool against a known
positive"): brdist's summary line is
    "# N fns checked, M with branch-offset/count divergence"
Every TU MUST produce that line and MUST report N > 0, else the row is counted
as a HARNESS ERROR, never as clean.  The run also prints the total fns checked
so an empty sweep is impossible to mistake for a green one.
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SUM_RE = re.compile(r"#\s*(\d+)\s+fns checked,\s*(\d+)\s+with branch-offset/count divergence")

tus = sorted([p.relative_to(ROOT).as_posix()
              for p in ROOT.joinpath("recon").rglob("*.c")] +
             [p.relative_to(ROOT).as_posix()
              for p in ROOT.joinpath("recon").rglob("*.cpp")])

bad_tus = bad_rows = err = 0
tot_fns = 0
for i, tu in enumerate(tus, 1):
    try:
        r = subprocess.run([sys.executable, "tools/brdist.py", tu],
                           cwd=ROOT, capture_output=True, text=True, timeout=900)
        out = r.stdout + r.stderr
    except subprocess.TimeoutExpired:
        err += 1
        print("[ERR ] %-58s TIMEOUT" % tu, flush=True)
        continue
    m = SUM_RE.search(out)
    if not m:
        err += 1
        print("[ERR ] %-58s no summary line | %s" % (tu, out.strip()[:110]), flush=True)
        continue
    nfn, ndiv = int(m.group(1)), int(m.group(2))
    tot_fns += nfn
    if nfn == 0:
        err += 1
        print("[VAC ] %-58s 0 fns checked (no oracle?)" % tu, flush=True)
        continue
    if ndiv:
        bad_tus += 1
        bad_rows += ndiv
        detail = [l.strip() for l in out.split("\n")
                  if l.strip() and not l.strip().startswith("#")][:6]
        print("[DIFF] %-58s %d divergent | %s" % (tu, ndiv, " ; ".join(detail)),
              flush=True)
    if i % 50 == 0:
        print("   ...%d/%d TUs, %d fns checked so far" % (i, len(tus), tot_fns),
              flush=True)

print("\nbrdist tree-wide: %d TUs, %d fns checked, %d TUs divergent (%d fns), "
      "%d harness/vacuous rows" % (len(tus), tot_fns, bad_tus, bad_rows, err))
