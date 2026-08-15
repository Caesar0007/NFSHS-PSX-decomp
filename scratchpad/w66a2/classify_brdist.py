#!/usr/bin/env python3
"""w66-a2: classify every tree-wide brdist row as
   class-d  = the GATE says PASS but a branch word/count diverges (hidden), or
   class-a  = the fn already FAILs the gate (the divergence is part of that residual).
Runs tugate once per affected TU."""
import json
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(r"C:\Temp\nfs4-decomp")
HERE = Path(__file__).resolve().parent
rows = json.loads((HERE / "brdist_final.json").read_text())

out = {}
for i, (tu, lines) in enumerate(sorted(rows.items()), 1):
    r = subprocess.run([sys.executable, str(ROOT / "tools" / "tugate.py"), tu],
                       cwd=str(ROOT), capture_output=True, text=True)
    fails = {}
    for ln in r.stdout.splitlines():
        m = re.match(r"^\s+(\d+)\s+(\S+)\s*$", ln)     # "     12  FnName"
        if m:
            fails[m.group(2)] = int(m.group(1))
    for ln in lines:
        fn = ln.split()[0]
        cls = "a" if fn in fails else "d"
        out.setdefault(cls, []).append((tu, ln.strip(), fails.get(fn)))
    print("  ...%d/%d %s" % (i, len(rows), tu), file=sys.stderr, flush=True)

(HERE / "brdist_classified.json").write_text(json.dumps(out, indent=1))
for cls in ("d", "a"):
    L = out.get(cls, [])
    print("\n=== class-%s: %d rows ===" % (cls, len(L)))
    for tu, ln, f in L:
        print("  %-46s %s%s" % (tu.replace("recon/", ""), ln,
                                "" if f is None else "   [gate FAIL:%d]" % f))
