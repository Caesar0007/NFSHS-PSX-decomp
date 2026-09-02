#!/usr/bin/env python3
"""D2_try.py FILE PATCHFILE [--apply]

PATCHFILE = python literal list of ("label", [(old,new), ...]) variants.
Patterns are written with '\n'; the file's real line ending (CRLF/LF) is
handled transparently.  Each variant is applied to the pristine source, the
WHOLE TU is gated, the result printed, and the file always restored (unless
--apply is given with exactly one variant).  No tools/*.py is touched.
"""
import subprocess, sys, ast
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
rel = sys.argv[1].replace('\\', '/')
variants = ast.literal_eval(Path(sys.argv[2]).read_text(encoding='utf-8'))
apply = '--apply' in sys.argv
path = ROOT / rel
orig = path.read_bytes()
crlf = b'\r\n' in orig
src = orig.decode('utf-8', 'surrogateescape')
if crlf:
    src = src.replace('\r\n', '\n')

if not (variants and isinstance(variants[0], (tuple, list)) and len(variants[0]) == 2
        and isinstance(variants[0][0], str)):
    variants = [(str(i), v) for i, v in enumerate(variants)]

def write(t):
    if crlf:
        t = t.replace('\n', '\r\n')
    path.write_bytes(t.encode('utf-8', 'surrogateescape'))

def gate():
    r = subprocess.run([sys.executable, str(ROOT / 'tools' / 'tugate.py'), rel],
                       capture_output=True, text=True, cwd=str(ROOT))
    out = (r.stdout or '') + (r.stderr or '')
    summary = [l for l in out.splitlines() if l.startswith(rel)]
    fails = [l.strip() for l in out.splitlines()
             if l.startswith('  ') and 'NO ORACLE' not in l and ' PASS' not in l]
    return (summary[-1] if summary else out.strip()[:400]), fails

ok_apply = False
try:
    for label, pairs in variants:
        t = src
        bad = False
        for old, new in pairs:
            n = t.count(old)
            if n != 1:
                print(f'--- {label}: !! pattern occurs {n}x: {old[:90]!r}')
                bad = True
                break
            t = t.replace(old, new)
        if bad:
            continue
        write(t)
        s, fails = gate()
        print(f'--- {label}: {s}')
        for fl in fails[:8]:
            print(f'      {fl[:150]}')
        if apply and len(variants) == 1:
            ok_apply = True
finally:
    if not ok_apply:
        path.write_bytes(orig)
    else:
        print('APPLIED')
