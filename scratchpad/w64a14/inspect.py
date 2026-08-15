#!/usr/bin/env python3
"""inspect.py <relfile> <fn> <variant-file> <variant-name> [minsz]
Applies ONE named variant, runs tools/chunkdiff.py, restores.
"""
import sys, os, subprocess, pathlib, importlib.util
ROOT = pathlib.Path(r'C:/Temp/nfs4-decomp')
SCR = ROOT / 'scratchpad' / 'w64a14'
rel, fn, varfile, vname = sys.argv[1:5]
minsz = sys.argv[5] if len(sys.argv) > 5 else '4'
tgt = ROOT / rel
orig = tgt.read_bytes()
(SCR / (tgt.name + '.iprobebak')).write_bytes(orig)
spec = importlib.util.spec_from_file_location('v', varfile)
v = importlib.util.module_from_spec(spec); spec.loader.exec_module(v)
patch = dict(v.PATCHES)[vname]
try:
    tgt.write_bytes(patch(orig.decode('latin-1')).encode('latin-1'))
    r = subprocess.run([sys.executable, str(ROOT/'tools'/'chunkdiff.py'), rel, fn, minsz],
                       capture_output=True, text=True, cwd=str(ROOT))
    print(r.stdout[-14000:]); print(r.stderr[-2000:])
finally:
    tgt.write_bytes(orig)
