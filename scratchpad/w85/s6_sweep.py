#!/usr/bin/env python3
"""W85-S6 device sweep harness.

Usage:
  python scratchpad/w85/s6_sweep.py <file> [--lines N,M,...] [--apply N,M,...]

Default: find every single-line `__asm__("" ...)` STATEMENT in <file>, and for each
one, delete it, run tools/tugate.py on the file, and report the PASS/TOTAL.
Restores the file afterwards. --apply removes the given line numbers permanently
(after a confirming gate).
"""
import subprocess, sys, re, os
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]

def gate(path):
    r = subprocess.run([sys.executable, str(ROOT / 'tools' / 'tugate.py'), path],
                       capture_output=True, text=True, cwd=str(ROOT))
    out = (r.stdout or '') + (r.stderr or '')
    m = re.search(r':\s*(\d+)/(\d+) PASS', out)
    if m:
        return int(m.group(1)), int(m.group(2)), out
    return None, None, out

def candidates(lines):
    """1-based line numbers of standalone `__asm__("" ...);` statements."""
    out = []
    for i, ln in enumerate(lines, 1):
        s = ln.strip()
        if not s.startswith('__asm__'):
            continue
        if not re.match(r'^__asm__\s*\(\s*""', s):
            continue
        if not s.rstrip().endswith(';') and '*/' not in s:
            # allow trailing comment forms
            pass
        # must be a complete statement on this line
        if s.count('(') != s.count(')'):
            continue
        out.append(i)
    return out

def main():
    path = sys.argv[1]
    p = ROOT / path
    orig = p.read_text(encoding='utf-8', errors='surrogateescape')
    lines = orig.split('\n')

    if '--apply' in sys.argv:
        nums = sorted({int(x) for x in sys.argv[sys.argv.index('--apply') + 1].split(',')}, reverse=True)
        new = list(lines)
        for n in nums:
            del new[n - 1]
        p.write_text('\n'.join(new), encoding='utf-8', errors='surrogateescape')
        ok, tot, out = gate(path)
        print(f'APPLY {nums}: {ok}/{tot}')
        if ok is None or ok != tot:
            p.write_text(orig, encoding='utf-8', errors='surrogateescape')
            print('REVERTED (gate not full)')
            print(out[-3000:])
        return

    if '--lines' in sys.argv:
        cands = [int(x) for x in sys.argv[sys.argv.index('--lines') + 1].split(',')]
    else:
        cands = candidates(lines)

    base_ok, base_tot, _ = gate(path)
    print(f'BASELINE {path}: {base_ok}/{base_tot}')
    free, stuck = [], []
    try:
        for n in cands:
            new = list(lines)
            del new[n - 1]
            p.write_text('\n'.join(new), encoding='utf-8', errors='surrogateescape')
            ok, tot, out = gate(path)
            tag = 'FREE ' if (ok == base_tot and tot == base_tot) else 'STUCK'
            if tag == 'FREE ':
                free.append(n)
            else:
                stuck.append((n, ok, tot))
            print(f'  L{n:<5} {tag} {ok}/{tot}   {lines[n-1].strip()[:80]}')
            sys.stdout.flush()
    finally:
        p.write_text(orig, encoding='utf-8', errors='surrogateescape')
    print('FREE:', ','.join(str(x) for x in free))
    print('STUCK:', stuck)

main()
