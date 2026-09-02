#!/usr/bin/env python3
"""D2_sweep.py FILE lines opts [--best N]
lines = comma list of device LINE numbers (from D2_auto2)
opts  = comma list from {K,R,S,D}  (Keep / Remove / Save-deadset-restore / Dead-set-post)
Cartesian sweep over the listed sites; whole-TU gate each; prints only results
better than or equal to the running best (and every PASS).  Always restores.
For a multi-operand device S/D apply to ALL its operands.
"""
import subprocess, sys, re, itertools
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
rel = sys.argv[1].replace('\\', '/')
lines = [int(x) for x in sys.argv[2].split(',')]
opts = sys.argv[3].split(',')
path = ROOT / rel
orig = path.read_bytes()
crlf = b'\r\n' in orig
src = orig.decode('utf-8', 'surrogateescape')
if crlf:
    src = src.replace('\r\n', '\n')

def mask(t):
    out, i, n = [], 0, len(t)
    while i < n:
        if t.startswith('/*', i):
            j = t.find('*/', i + 2); j = n if j < 0 else j + 2
            out.append(re.sub(r'[^\n]', ' ', t[i:j])); i = j
        elif t.startswith('//', i):
            j = t.find('\n', i); j = n if j < 0 else j
            out.append(' ' * (j - i)); i = j
        else:
            out.append(t[i]); i += 1
    return ''.join(out)

M = mask(src)
DEV = re.compile(r'__asm__\s*(?:__volatile__|volatile)?\s*\(\s*""\s*:[^;]*?\);')
sites = {}
for m in DEV.finditer(M):
    ln = src[:m.start()].count('\n') + 1
    vs = re.findall(r'"[=+]?[01r]"\s*\(\s*([A-Za-z_]\w*)\s*\)', src[m.start():m.end()])
    seen, uniq = set(), []
    for v in vs:
        if v not in seen:
            seen.add(v); uniq.append(v)
    sites[ln] = (m.start(), m.end(), uniq)

def rep_for(opt, vs):
    if opt == 'K':
        return None
    if opt == 'R':
        return ''
    if opt == 'S':
        return ' '.join('{ __typeof__(%s) v_ = %s; %s = 0; %s = v_; }' % (v, v, v, v) for v in vs)
    if opt == 'D':
        return ' '.join('%s = 0;' % v for v in vs)
    if opt == 'A':
        return ' '.join('%s = (__typeof__(%s))((unsigned int)%s | ((unsigned int)%s & 3u));'
                        % (v, v, v, v) for v in vs)
    if opt == 'B':
        return ' '.join(('%s = (__typeof__(%s))((unsigned int)%s | ((unsigned int)%s & 3u));' % (v, v, v, v)) * 2
                        for v in vs)
    raise SystemExit('bad opt ' + opt)

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
    tot = 0
    for x in f:
        try:
            tot += int(x.split()[0])
        except Exception:
            tot += 999
    return (s[-1].split(': ')[-1] if s else out[:120]), f, tot

order = sorted(lines, reverse=True)
best = 10 ** 9
try:
    for combo in itertools.product(*[opts] * len(order)):
        t = src
        for ln, o in zip(order, combo):
            pos, end, vs = sites[ln]
            r = rep_for(o, vs)
            if r is None:
                continue
            t = t[:pos] + r + t[end:]
        write(t)
        s, f, tot = gate()
        lbl = ' '.join(f'{ln}:{o}' for ln, o in zip(reversed(order), reversed(combo)))
        if tot <= best or tot == 0:
            best = min(best, tot)
            print(f'{lbl:44s} tot={tot:4d}  {s}   ' + ' | '.join(x[:50] for x in f[:3]))
finally:
    path.write_bytes(orig)
print('best', best)
