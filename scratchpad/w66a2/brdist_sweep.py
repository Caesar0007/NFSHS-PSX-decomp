#!/usr/bin/env python3
"""w66-a2: TREE-WIDE brdist sweep (every recon TU that objdiff.json knows).
Writes a JSON row table + a text log.  Usage: brdist_sweep.py [out-tag]"""
import json
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(r"C:\Temp\nfs4-decomp")
HERE = Path(__file__).resolve().parent
tag = sys.argv[1] if len(sys.argv) > 1 else "final"

cfg = json.loads((ROOT / "objdiff.json").read_text(encoding="utf-8"))
tus = sorted({u["metadata"]["source_path"] for u in cfg["units"]
              if u.get("metadata", {}).get("source_path", "").startswith("recon/")})
rows, log = {}, []
t0 = time.time()
for i, tu in enumerate(tus, 1):
    if not (ROOT / tu).exists():
        log.append("%s: SOURCE MISSING" % tu)
        continue
    r = subprocess.run([sys.executable, str(ROOT / "tools" / "brdist.py"), tu],
                       cwd=str(ROOT), capture_output=True, text=True)
    out = r.stdout.strip()
    if r.returncode:
        log.append("%s: brdist FAILED rc=%d %s" % (tu, r.returncode, r.stderr[-200:]))
        continue
    bad = [ln for ln in out.splitlines() if not ln.startswith("#")]
    if bad:
        rows[tu] = bad
        log.append("%s\n    %s" % (tu, "\n    ".join(bad)))
    if i % 25 == 0:
        print("  ...%d/%d (%.0fs)" % (i, len(tus), time.time() - t0),
              file=sys.stderr, flush=True)
(HERE / ("brdist_%s.json" % tag)).write_text(json.dumps(rows, indent=1))
(HERE / ("brdist_%s.txt" % tag)).write_text("\n".join(log))
print("%d TUs swept, %d with divergent rows, %.0fs"
      % (len(tus), len(rows), time.time() - t0))
for tu, bad in sorted(rows.items()):
    print(" ", tu)
    for b in bad:
        print("     ", b)
