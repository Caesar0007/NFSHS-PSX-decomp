#!/usr/bin/env python3
"""S4_probe.py FILE  --  device-removal probe driver (no tool edits; lives in scratchpad).

Usage:
  python scratchpad/w85/S4_probe.py gate  recon/game/psx/flare.cpp
  python scratchpad/w85/S4_probe.py drop  recon/game/psx/flare.cpp 707[,1184,...]
        -> deletes those 1-based source lines (device statements), re-gates the WHOLE
           file, prints the gate table, then RESTORES the file unconditionally.
  python scratchpad/w85/S4_probe.py apply recon/game/psx/flare.cpp 707,1184
        -> same deletion but KEEPS it (caller has already seen a clean gate).

Gate is tools/tugate.py (whole-TU) run as a subprocess -- no tool file is modified.
"""
import subprocess, sys, shutil, os
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent


def gate(rel):
    r = subprocess.run([sys.executable, str(ROOT / 'tools' / 'tugate.py'), rel],
                       capture_output=True, text=True, cwd=str(ROOT))
    out = [l for l in (r.stdout + r.stderr).splitlines() if 'NO ORACLE' not in l]
    return '\n'.join(out).strip()


def drop_lines(path, lines):
    txt = path.read_text(encoding='utf-8', errors='surrogateescape').split('\n')
    for n in sorted(lines, reverse=True):
        del txt[n - 1]
    path.write_text('\n'.join(txt), encoding='utf-8', errors='surrogateescape')


def main():
    mode = sys.argv[1]
    rel = sys.argv[2].replace('\\', '/')
    path = ROOT / rel
    if mode == 'gate':
        print(gate(rel)); return
    lines = [int(x) for x in sys.argv[3].split(',')]
    bak = path.read_bytes()
    try:
        drop_lines(path, lines)
        print(gate(rel))
    finally:
        if mode != 'apply':
            path.write_bytes(bak)


main()
