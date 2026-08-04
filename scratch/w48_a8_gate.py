#!/usr/bin/env python3
"""w48_a8 whole-TU gate helper.
Usage: python scratch/w48_a8_gate.py <UNIT> [UNIT...]
UNIT = e.g. libmath/MULDF3 ; reads MATCH_PROGRESS.txt for the TU's full fn list,
runs tools/verify_asm.py on recon/syslib/psx/<UNIT>.c with all of them.
"""
import re, subprocess, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MP = (ROOT / 'MATCH_PROGRESS.txt').read_text(errors='replace').splitlines()

units = {}
for ln in MP:
    m = re.match(r'^\s*(\S+)\s+([\d.]+)%\s+(\S+)\s+(\S+)\s*$', ln)
    if not m:
        continue
    va, pct, unit, fn = m.groups()
    if not unit.startswith('syslib/psx/'):
        continue
    if fn.startswith('D_'):
        continue
    units.setdefault(unit[len('syslib/psx/'):], []).append(fn)

def gate(u):
    fns = units.get(u)
    if not fns:
        print(f'!! no fns for {u}'); return
    src = f'recon/syslib/psx/{u}.c'
    if not (ROOT / src).exists():
        src = f'recon/syslib/psx/{u}.cpp'
    r = subprocess.run([sys.executable, 'tools/verify_asm.py', src, ','.join(fns)],
                       cwd=ROOT, capture_output=True, text=True)
    print(f'===== {u} ({src}) =====')
    out = r.stdout + r.stderr
    for ln in out.splitlines():
        if re.search(r'PASS|FAIL|diff|ORACLE|OBJECT|Error|error', ln):
            print(ln)

if __name__ == '__main__':
    args = sys.argv[1:]
    if not args:
        for u in sorted(units):
            print(u, len(units[u]))
    else:
        for u in args:
            gate(u)
