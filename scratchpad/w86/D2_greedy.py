#!/usr/bin/env python3
"""D2_greedy.py FILE NPASS [--apply]
Greedy device clearance: walk every zero-insn __asm__ device (comment-masked),
try the pure-C battery, and PERMANENTLY keep the first candidate that leaves the
whole TU at NPASS.  Prints the ladder.  Without --apply the file is restored at
the end (the greedy state is still reported)."""
import subprocess, sys, re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
rel = sys.argv[1].replace('\\', '/')
npass = int(sys.argv[2])
apply = '--apply' in sys.argv
path = ROOT / rel
orig = path.read_bytes()
crlf = b'\r\n' in orig

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

def write(t):
    if crlf:
        t = t.replace('\n', '\r\n')
    path.write_bytes(t.encode('utf-8', 'surrogateescape'))

def gate():
    r = subprocess.run([sys.executable, str(ROOT / 'tools' / 'tugate.py'), rel],
                       capture_output=True, text=True, cwd=str(ROOT))
    out = (r.stdout or '') + (r.stderr or '')
    s = [l for l in out.splitlines() if l.startswith(rel)]
    txt = s[-1].split(': ')[-1] if s else out.strip()[:150]
    ok = txt.startswith(f'{npass}/{npass} ')
    return ok, txt

DEV = re.compile(r'__asm__\s*(?:__volatile__|volatile)?\s*\(\s*""\s*:[^;]*?\);')

def sites(src):
    M = mask(src)
    out = []
    for m in DEV.finditer(M):
        txt = src[m.start():m.end()]
        vs = re.findall(r'"[=+]?[01r]"\s*\(\s*([A-Za-z_]\w*)\s*\)', txt)
        seen, uniq = set(), []
        for v in vs:
            if v not in seen:
                seen.add(v); uniq.append(v)
        out.append((m.start(), m.end(), txt, uniq, src[:m.start()].count('\n') + 1))
    return out

cur = orig.decode('utf-8', 'surrogateescape')
if crlf:
    cur = cur.replace('\r\n', '\n')

cleared = []
idx = 0
while True:
    S = sites(cur)
    if idx >= len(S):
        break
    pos, end, txt, vs, line = S[idx]
    cands = [('removed', '')]
    for v in vs:
        cands.append((f'abs1({v})',
                      '%s = (__typeof__(%s))((unsigned int)%s | ((unsigned int)%s & 3u));' % (v, v, v, v)))
        cands.append((f'and1({v})',
                      '%s = (__typeof__(%s))((unsigned int)%s & ((unsigned int)%s | 3u));' % (v, v, v, v)))
        cands.append((f'abs2({v})',
                      ('%s = (__typeof__(%s))((unsigned int)%s | ((unsigned int)%s & 3u)); ' % (v, v, v, v)) * 2))
    won = None
    for label, rep in cands:
        write(cur[:pos] + rep + cur[end:])
        ok, t = gate()
        if ok:
            won = (label, rep, t)
            break
    if won:
        label, rep, t = won
        cur = cur[:pos] + rep + cur[end:]
        cleared.append((line, txt[:60], label))
        print(f'CLEARED line {line}: {txt[:55]!r} -> {label}')
    else:
        print(f'kept    line {line}: {txt[:55]!r}')
        idx += 1
    write(cur)

print(f'\n{len(cleared)} devices cleared')
write(cur)
ok, t = gate()
print('final gate:', t)
if not apply:
    path.write_bytes(orig)
    print('(restored)')
