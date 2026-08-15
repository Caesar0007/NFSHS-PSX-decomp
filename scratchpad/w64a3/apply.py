#!/usr/bin/env python3
"""Apply ONE variant from a spec file to the tree (for dumping/objdump), or
restore.  Usage:
    python scratchpad/w64a3/apply.py <spec> <index>     # apply
    python scratchpad/w64a3/apply.py --restore <spec>   # restore from bak
A FRESH backup is written per apply (15F: a single stale .applybak burns you).
"""
import os
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
MY = ROOT / "scratchpad/w64a3"

if sys.argv[1] == "--restore":
    g = {}
    exec(open(sys.argv[2]).read(), g)
    rel = g.get('SRC', 'recon/syslib/psx/libgpu/SYS.c')
    bak = MY / ("applybak_" + Path(rel).name)
    (ROOT / rel).write_text(bak.read_text(encoding="utf-8", newline=""),
                            encoding="utf-8", newline="")
    print("restored", rel)
    sys.exit(0)

g = {}
exec(open(sys.argv[1]).read(), g)
rel = g.get('SRC', 'recon/syslib/psx/libgpu/SYS.c')
SRCP = ROOT / rel
i = int(sys.argv[2])
name, edits = g['SPEC'][i]
orig = SRCP.read_text(encoding="utf-8", newline="")
(MY / ("applybak_" + Path(rel).name)).write_text(orig, encoding="utf-8", newline="")
t = orig
for old, new in edits:
    assert t.count(old) == 1, "anchor count %d for %r" % (t.count(old), old[:70])
    t = t.replace(old, new)
assert t != orig
SRCP.write_text(t, encoding="utf-8", newline="")
print("applied", name, "to", rel)
