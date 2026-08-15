#!/usr/bin/env python3
"""Apply ONE variant from a spec, gate it, dump a windowed side-by-side, restore.
  python scratchpad/w63a3/show.py <specfile> <index> <fn> <lo> <hi>
"""
import subprocess
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
g = {}
exec(open(sys.argv[1]).read(), g)
rel = g.get('SRC', 'recon/syslib/psx/libgpu/FONT.c')
SRCP = ROOT / rel
idx = int(sys.argv[2]); fn = sys.argv[3]
lo = int(sys.argv[4]); hi = int(sys.argv[5])
name, edits = g['SPEC'][idx]
orig = SRCP.read_text(encoding="utf-8", newline="")
(ROOT / "scratchpad/w63a3/RESTORE.bak").write_text(orig, encoding="utf-8", newline="")
out = []
try:
    t = orig
    for old, new in edits:
        assert t.count(old) == 1, "anchor %d" % t.count(old)
        t = t.replace(old, new)
    SRCP.write_text(t, encoding="utf-8", newline="")
    r = subprocess.run([sys.executable, "tools/verify_asm.py", rel, fn],
                       cwd=ROOT, capture_output=True, text=True)
    out.append(name); out.append(r.stdout.rstrip())
    obj = "build/" + rel + ".o"
    s = subprocess.run([sys.executable, "scratchpad/w63a3/sbs.py", fn, obj],
                       cwd=ROOT, capture_output=True, text=True)
    lines = s.stdout.splitlines()
    out.extend(lines[lo:hi] + lines[-1:])
finally:
    SRCP.write_text(orig, encoding="utf-8", newline="")
    (ROOT / "scratchpad/w63a3/last_show.txt").write_text(
        "\n".join(out) + "\n", encoding="utf-8", newline="")
print("\n".join(out))
