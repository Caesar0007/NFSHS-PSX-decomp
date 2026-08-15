#!/usr/bin/env python3
"""W64-A3 variant prober, UNCAPPED diff printer (twin of probe.py).
  python scratchpad/w64a3/probe2.py <specfile> [only-index]
Prints the full verify_asm block for every FN of every variant.
"""
import os
import subprocess
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
MY = ROOT / "scratchpad/w64a3"
g = {}
exec(open(sys.argv[1]).read(), g)
rel = g.get('SRC', 'recon/syslib/psx/libgpu/SYS.c')
SRCP = ROOT / rel
FNS = g['FNS']
spec = g['SPEC']
sel = int(sys.argv[2]) if len(sys.argv) > 2 else None

orig = SRCP.read_text(encoding="utf-8", newline="")
(MY / "RESTORE.bak").write_text(orig, encoding="utf-8", newline="")
out = []
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
        env = dict(os.environ, VA_MAX="200")
        r = subprocess.run([sys.executable, "tools/verify_asm.py", rel,
                            ",".join(FNS)],
                           cwd=ROOT, capture_output=True, text=True, env=env)
        blk = "==== %s\n%s" % (name, r.stdout.rstrip())
        out.append(blk)
        print(blk)
        sys.stdout.flush()
finally:
    SRCP.write_text(orig, encoding="utf-8", newline="")
    (MY / "last_probe2.txt").write_text(
        "\n".join(out) + "\nrestored\n", encoding="utf-8", newline="")
print("restored")
