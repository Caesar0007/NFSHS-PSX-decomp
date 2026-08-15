#!/usr/bin/env python3
"""Apply a source variant + a PER_FN_TEXT_MOVES json (via vprobe's hook), gate, restore.
  python scratchpad/w63a3/probe_moves.py <specfile> <index> <fn> <movesjson|-> [runs]
"""
import os
import subprocess
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
g = {}
exec(open(sys.argv[1]).read(), g)
rel = g.get('SRC', 'recon/syslib/psx/libgpu/FONT.c')
SRCP = ROOT / rel
idx = int(sys.argv[2]); fn = sys.argv[3]; mv = sys.argv[4]
runs = int(sys.argv[5]) if len(sys.argv) > 5 else 2
name, edits = g['SPEC'][idx] if idx >= 0 else ("<no source edit>", [])
orig = SRCP.read_text(encoding="utf-8", newline="")
(ROOT / "scratchpad/w63a3/RESTORE.bak").write_text(orig, encoding="utf-8", newline="")
env = dict(os.environ, VA_MAX="400")
if mv != "-":
    env["W60_TEXT_MOVES_FILE"] = str(ROOT / mv)
out = [name, "moves=%s" % mv]
try:
    t = orig
    for old, new in edits:
        assert t.count(old) == 1, "anchor %d" % t.count(old)
        t = t.replace(old, new)
    if edits:
        SRCP.write_text(t, encoding="utf-8", newline="")
    for k in range(runs):
        r = subprocess.run([sys.executable, "tools/vprobe.py", rel, fn],
                           cwd=ROOT, capture_output=True, text=True, env=env)
        out.append("run%d: %s" % (k, r.stdout.strip() or r.stderr[-400:]))
finally:
    SRCP.write_text(orig, encoding="utf-8", newline="")
    (ROOT / "scratchpad/w63a3/last_moves.txt").write_text(
        "\n".join(out) + "\nrestored\n", encoding="utf-8", newline="")
print("\n".join(out))
print("restored")
