#!/usr/bin/env python3
r"""s6_volsweep.py <file>  --  remove ONE `volatile` qualifier at a time (code lines
only, skipping comments and 0x1F80xxxx MMIO lines), re-gate the whole TU, restore.

Prints FREE (gate still full) / STUCK per site.
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
path = sys.argv[1]
p = ROOT / path
orig = p.read_text(encoding='utf-8', errors='surrogateescape')
lines = orig.split('\n')


def gate():
    r = subprocess.run([sys.executable, str(ROOT / 'tools' / 'tugate.py'), path],
                       capture_output=True, text=True, cwd=str(ROOT))
    o = (r.stdout or '') + (r.stderr or '')
    m = re.search(r':\s*(\d+)/(\d+) PASS', o)
    fails = [l.strip() for l in o.split('\n') if re.match(r'^\s+\d+\s+\S', l)]
    if m:
        return int(m.group(1)), int(m.group(2)), fails
    return None, None, fails


in_comment = False
sites = []          # (lineno, col)
for i, ln in enumerate(lines, 1):
    s = ln
    # crude comment tracking
    stripped = s.strip()
    if in_comment:
        if '*/' in s:
            in_comment = False
            s = s.split('*/', 1)[1]
        else:
            continue
    if stripped.startswith('//'):
        continue
    code = s.split('/*')[0]
    if '/*' in s and '*/' not in s.split('/*', 1)[1]:
        in_comment = True
    if 'volatile' not in code:
        continue
    if '0x1f80' in code.lower():        # MMIO literal -> sanctioned, skip
        continue
    for m in re.finditer(r'\bvolatile\b', code):
        sites.append((i, m.start()))

base_ok, base_tot, _ = gate()
print(f'BASELINE {path}: {base_ok}/{base_tot}   ({len(sites)} non-MMIO volatile sites)')
free, stuck = [], []
try:
    for (n, c) in sites:
        new = list(lines)
        ln = new[n - 1]
        # remove this occurrence (plus one following space if present)
        cut = ln[:c] + re.sub(r'^volatile\s?', '', ln[c:], count=1)
        new[n - 1] = cut
        p.write_text('\n'.join(new), encoding='utf-8', errors='surrogateescape')
        ok, tot, fails = gate()
        good = (ok == base_tot and tot == base_tot)
        (free if good else stuck).append((n, c))
        print(f'  L{n:<5} c{c:<3} {"FREE " if good else "STUCK"} {ok}/{tot} '
              f'{"; ".join(fails)[:60]:<62} | {lines[n-1].strip()[:70]}')
        sys.stdout.flush()
finally:
    p.write_text(orig, encoding='utf-8', errors='surrogateescape')
print('FREE:', free)
print('STUCK:', stuck)
