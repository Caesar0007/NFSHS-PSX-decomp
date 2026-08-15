#!/usr/bin/env python3
"""Apply ONE variant from a spec, compile, print a window of the emitted .s, restore.
  python scratchpad/w63a3/dumps.py <specfile> <index> <fn> <grep-regex> [before] [after]
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
g = {}
exec(open(sys.argv[1]).read(), g)
rel = g.get('SRC', 'recon/syslib/psx/libgpu/FONT.c')
SRCP = ROOT / rel
idx = int(sys.argv[2]); fn = sys.argv[3]; pat = sys.argv[4]
before = int(sys.argv[5]) if len(sys.argv) > 5 else 8
after = int(sys.argv[6]) if len(sys.argv) > 6 else 12
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
    subprocess.run([sys.executable, "tools/verify_asm.py", rel, fn],
                   cwd=ROOT, capture_output=True, text=True)
    s = (ROOT / ("build/" + rel + ".s")).read_text(encoding="utf-8", newline="")
    body = s.split(fn + ":", 1)[1]
    lines = body.splitlines()
    for i, ln in enumerate(lines):
        if re.search(pat, ln):
            out.append("---- hit at %d" % i)
            out.extend("%4d|%s" % (j, lines[j])
                       for j in range(max(0, i - before), min(len(lines), i + after)))
    (ROOT / "scratchpad/w63a3/variant.s").write_text(s, encoding="utf-8", newline="")
finally:
    SRCP.write_text(orig, encoding="utf-8", newline="")
print("\n".join(out))
