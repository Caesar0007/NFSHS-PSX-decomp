#!/usr/bin/env python3
"""r09_variants.py -- try N source variants of one block in a candidate TU and
report the regional gate diff count for each.  scratchpad-local helper.

usage: python r09_variants.py <candidate> <region> <fn> <lane-as> <variants.py>
The variants module must define BASE (the exact text to replace) and
VARIANTS (list of (name, replacement_text)).
"""
import subprocess, sys, pathlib, importlib.util, shutil, re

cand, region, fn, lane, vmod = sys.argv[1:6]
ROOT = pathlib.Path(r'C:/Temp/nfs4-decomp')
spec = importlib.util.spec_from_file_location('v', vmod)
m = importlib.util.module_from_spec(spec); spec.loader.exec_module(m)
p = ROOT / cand
orig = p.read_text()
assert m.BASE in orig, 'BASE marker not found'
best = None
try:
    for name, repl in m.VARIANTS:
        p.write_text(orig.replace(m.BASE, repl))
        r = subprocess.run([sys.executable, 'regiondiff/tools/verify_region.py', region,
                            cand, fn, '--lane-as=' + lane], cwd=ROOT,
                           capture_output=True, text=True)
        out = r.stdout.strip().splitlines()
        head = out[0] if out else '(no output)'
        mm = re.search(r'FAIL (\d+)', head)
        n = int(mm.group(1)) if mm else (0 if 'REGION-PASS' in head else 999)
        print(f'{n:>4}  {name}')
        for l in out[1:9]:
            print('        ' + l.strip())
        if best is None or n < best[0]:
            best = (n, name, repl)
finally:
    p.write_text(orig)
print(f'BEST: {best[0]} {best[1]}')
