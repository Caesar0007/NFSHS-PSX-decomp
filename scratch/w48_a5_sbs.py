#!/usr/bin/env python3
"""w48_a5_sbs.py CPP FUNC — side-by-side normalized listing (ours | oracle) via verify_asm's own
normalizer. Usage: python scratch/w48_a5_sbs.py recon/syslib/psx/libcd/drv.c CD_flush"""
import sys, importlib.util, os
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / 'tools'))
cpp, fn = sys.argv[1], sys.argv[2]
sys.argv = ['verify_asm.py', cpp, fn]
spec = importlib.util.spec_from_file_location('va', ROOT / 'tools' / 'verify_asm.py')
va = importlib.util.module_from_spec(spec)
try:
    spec.loader.exec_module(va)
except SystemExit:
    pass
o = va.ours(fn); e = va.oracle(fn)
import difflib
sm = difflib.SequenceMatcher(None, o, e)
rows = []
for tag, i1, i2, j1, j2 in sm.get_opcodes():
    if tag == 'equal':
        for k in range(i2 - i1):
            rows.append(('   ', o[i1 + k], e[j1 + k]))
    else:
        n = max(i2 - i1, j2 - j1)
        for k in range(n):
            a = o[i1 + k] if i1 + k < i2 else ''
            b = e[j1 + k] if j1 + k < j2 else ''
            rows.append((' * ', a, b))
print(f"{fn}: ours {len(o)} / oracle {len(e)}")
print(f"{'':>4} {'OURS':<40}{'ORACLE'}")
for i, (m, a, b) in enumerate(rows):
    print(f"{i:>4}{m}{a:<40}{b}")
