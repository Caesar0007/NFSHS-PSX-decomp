#!/usr/bin/env python3
"""w46-a1 in-place probe harness for psxfront.cpp.

Patches the REAL path (build.py's PER_TU table is path-keyed -- w44 IN-PLACE PROBE
RULE), gates, and ALWAYS restores in `finally`.

  python scratch/a1_probe.py <patchmod.py>   # module exposing patch(text)->text
or as a library:  from a1_probe import probe
"""
import io
import os
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TU = os.path.join(ROOT, 'recon', 'frontend', 'psx', 'psxfront.cpp')
FNS = ('DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii,'
       'FontUpsideDownBlit__FiiPviiP12charactertbli')


def read():
    with io.open(TU, 'r', encoding='utf-8', newline='') as f:
        return f.read()


def write(t):
    with io.open(TU, 'w', encoding='utf-8', newline='') as f:
        f.write(t)


def gate(names=FNS):
    p = subprocess.run([sys.executable, 'tools/verify_asm.py',
                        'recon/frontend/psx/psxfront.cpp', names],
                       cwd=ROOT, capture_output=True, text=True)
    out = []
    for ln in (p.stdout + p.stderr).splitlines():
        if 'PASS' in ln or 'FAIL' in ln or 'NO ORACLE' in ln or 'rror' in ln:
            out.append(ln.strip())
    return out


def probe(fn, names=FNS):
    """fn: text -> text. Returns gate lines. Always restores."""
    orig = read()
    try:
        write(fn(orig))
        return gate(names)
    finally:
        write(orig)


if __name__ == '__main__':
    print('\n'.join(gate()))
