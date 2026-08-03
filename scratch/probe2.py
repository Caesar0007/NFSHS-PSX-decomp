#!/usr/bin/env python
"""Multi-anchor probe: variantfile defines PAIRS = [(OLD,NEW), ...].
Usage: python scratch/probe2.py <tu> <fnlist> <variantfile>"""
import io, os, sys, subprocess, importlib.util

tu, fns, vf = sys.argv[1], sys.argv[2], sys.argv[3]
spec = importlib.util.spec_from_file_location("v", vf)
v = importlib.util.module_from_spec(spec); spec.loader.exec_module(v)

s = io.open(tu, encoding='utf-8', newline='').read()
t = s
for old, new in v.PAIRS:
    assert t.count(old) == 1, "anchor count %d for %r" % (t.count(old), old[:60])
    t = t.replace(old, new)
try:
    io.open(tu, 'w', encoding='utf-8', newline='').write(t)
    r = subprocess.run([sys.executable, 'tools/verify_asm.py', tu, fns],
                       capture_output=True, text=True)
    print(r.stdout + r.stderr)
finally:
    io.open(tu, 'w', encoding='utf-8', newline='').write(s)
