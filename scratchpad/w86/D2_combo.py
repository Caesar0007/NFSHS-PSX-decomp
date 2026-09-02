#!/usr/bin/env python3
"""D2_combo.py FILE line1,line2[,...]  -- cartesian sweep of pure-C launder
replacements at the given launder LINE numbers (as reported by D2_auto).
Always restores."""
import subprocess, sys, re, itertools
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
rel = sys.argv[1].replace('\\', '/')
lines = [int(x) for x in sys.argv[2].split(',')]
path = ROOT / rel
orig = path.read_bytes()
crlf = b'\r\n' in orig
src = orig.decode('utf-8', 'surrogateescape')
if crlf:
    src = src.replace('\r\n', '\n')

def write(t):
    if crlf:
        t = t.replace('\n', '\r\n')
    path.write_bytes(t.encode('utf-8', 'surrogateescape'))

def gate():
    r = subprocess.run([sys.executable, str(ROOT / 'tools' / 'tugate.py'), rel],
                       capture_output=True, text=True, cwd=str(ROOT))
    out = (r.stdout or '') + (r.stderr or '')
    s = [l for l in out.splitlines() if l.startswith(rel)]
    f = [l.strip() for l in out.splitlines()
         if l.startswith('  ') and 'NO ORACLE' not in l and ' PASS' not in l]
    return (s[-1].split(': ')[-1] if s else out.strip()[:200]), f

PAT = re.compile(r'__asm__\s*\(\s*""\s*:\s*"=r"\(\s*(\w+)\s*\)\s*:\s*"0"\(\s*\1\s*\)[^;]*\);')
sites = {}
for m in PAT.finditer(src):
    ln = src[:m.start()].count('\n') + 1
    sites[ln] = (m.start(), m.group(0), m.group(1))

def cands(var):
    return [('keep', None),
            ('rm', ''),
            ('save0', '{ __typeof__(%s) v_ = %s; %s = 0; %s = v_; }' % (var, var, var, var)),
            ('dead0', '%s = 0;' % var)]

order = sorted(lines, reverse=True)   # apply from the bottom up so offsets hold
opts = [cands(sites[l][2]) for l in order]
try:
    for combo in itertools.product(*opts):
        t = src
        label = []
        for (ln, (lbl, rep)) in zip(order, combo):
            pos, text, var = sites[ln]
            label.append(f'{ln}:{lbl}')
            if rep is None:
                continue
            t = t[:pos] + rep + t[pos + len(text):]
        write(t)
        s, f = gate()
        print(f'{" ".join(reversed(label)):50s} {s}   ' + ' | '.join(x[:55] for x in f[:3]))
finally:
    path.write_bytes(orig)
