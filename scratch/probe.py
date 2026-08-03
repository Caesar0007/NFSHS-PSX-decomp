#!/usr/bin/env python
"""Probe harness: apply a variant to a TU IN PLACE (per-TU flags are path-keyed!),
gate, restore.  Usage: python scratch/probe.py <tu> <fnlist> <variantfile>
variantfile = python module defining OLD and NEW strings."""
import io, os, sys, subprocess, importlib.util

tu, fns, vf = sys.argv[1], sys.argv[2], sys.argv[3]
spec = importlib.util.spec_from_file_location("v", vf)
v = importlib.util.module_from_spec(spec); spec.loader.exec_module(v)

s = io.open(tu, encoding='utf-8', newline='').read()
assert s.count(v.OLD) == 1, "anchor count %d" % s.count(v.OLD)
try:
    io.open(tu, 'w', encoding='utf-8', newline='').write(s.replace(v.OLD, v.NEW))
    r = subprocess.run([sys.executable, 'tools/verify_asm.py', tu, fns],
                       capture_output=True, text=True)
    print(r.stdout + r.stderr)
finally:
    io.open(tu, 'w', encoding='utf-8', newline='').write(s)
