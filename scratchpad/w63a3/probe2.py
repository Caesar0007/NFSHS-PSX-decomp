#!/usr/bin/env python3
"""W63-A3 variant prober that also prints the diff body (VA_MAX uncapped)."""
import os
import subprocess
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
g = {}
exec(open(sys.argv[1]).read(), g)
rel = g.get('SRC', 'recon/syslib/psx/libgpu/FONT.c')
SRCP = ROOT / rel
FNS = g['FNS']
spec = g['SPEC']
sel = int(sys.argv[2]) if len(sys.argv) > 2 else None

env = dict(os.environ, VA_MAX="400")
orig = SRCP.read_text(encoding="utf-8", newline="")
(ROOT / "scratchpad/w63a3/RESTORE.bak").write_text(orig, encoding="utf-8", newline="")
buf = []
try:
    for i, (name, edits) in enumerate(spec):
        if sel is not None and i != sel:
            continue
        t = orig
        for old, new in edits:
            assert t.count(old) == 1, "variant %r: anchor count %d for %r" % (
                name, t.count(old), old[:70])
            t = t.replace(old, new)
        assert t != orig, "variant %r: no change" % name
        SRCP.write_text(t, encoding="utf-8", newline="")
        r = subprocess.run([sys.executable, "tools/verify_asm.py", rel] + FNS,
                           cwd=ROOT, capture_output=True, text=True, env=env)
        buf.append("=== " + name)
        buf.append(r.stdout.rstrip())
        print(buf[-2]); print(buf[-1]); sys.stdout.flush()
finally:
    SRCP.write_text(orig, encoding="utf-8", newline="")
    (ROOT / "scratchpad/w63a3/last_probe2.txt").write_text(
        "\n".join(buf) + "\nrestored\n", encoding="utf-8", newline="")
print("restored")
