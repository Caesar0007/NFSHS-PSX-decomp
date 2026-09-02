#!/usr/bin/env python3
"""D2_auto2.py FILE [lineFilter]
Comment-masked census of zero-insn __asm__ devices (read-only fences + identity
launders, single- or multi-operand).  For each, tries the pure-C battery:
  removed | save/dead-set/restore per operand | dead-set-post per operand
Whole-TU gate each; always restores.
"""
import subprocess, sys, re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
rel = sys.argv[1].replace('\\', '/')
only = set(sys.argv[2].split(',')) if len(sys.argv) > 2 else None
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

# zero-insn devices only: empty asm template ""
DEV = re.compile(r'__asm__\s*(?:__volatile__|volatile)?\s*\(\s*""\s*:[^;]*?\);')
sites = []
for m in DEV.finditer(M):
    txt = src[m.start():m.end()]
    vars_ = re.findall(r'"[=+]?[01r]"\s*\(\s*([A-Za-z_]\w*)\s*\)', txt)
    seen, uniq = set(), []
    for v in vars_:
        if v not in seen:
            seen.add(v); uniq.append(v)
    sites.append((m.start(), m.end(), txt, uniq, src[:m.start()].count('\n') + 1))

print(f'{len(sites)} zero-insn asm devices in {rel}')
try:
    for pos, end, txt, vs, line in sites:
        if only and str(line) not in only:
            continue
        print(f'\n=== line {line}  vars={vs}  {txt[:80]!r}')
        cands = [('removed', '')]
        for v in vs:
            cands.append((f'save0({v})',
                          '{ __typeof__(%s) v_ = %s; %s = 0; %s = v_; }' % (v, v, v, v)))
            cands.append((f'dead0post({v})', '%s = 0;' % v))
        if len(vs) > 1:
            cands.append(('save0(all)', ' '.join(
                '{ __typeof__(%s) v_ = %s; %s = 0; %s = v_; }' % (v, v, v, v) for v in vs)))
        for label, rep in cands:
            write(src[:pos] + rep + src[end:])
            s, f = gate()
            print(f'  {label:22s} {s}   ' + ' | '.join(x[:58] for x in f[:3]))
finally:
    path.write_bytes(orig)
