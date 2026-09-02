#!/usr/bin/env python3
"""D2_auto.py FILE  -- for every identity launder  __asm__("" : "=r"(V) : "0"(V));
try a battery of pure-C dead-set substitutions in place, whole-TU gate each,
print the ladder.  Always restores.  Nothing outside scratchpad is written."""
import subprocess, sys, re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
rel = sys.argv[1].replace('\\', '/')
only = sys.argv[2] if len(sys.argv) > 2 else None
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

sites = [(m.start(), m.group(0), m.group(1)) for m in PAT.finditer(src)]
print(f'{len(sites)} identity launders in {rel}')
try:
    for pos, text, var in sites:
        line = src[:pos].count('\n') + 1
        if only and str(line) != only:
            continue
        print(f'\n=== line {line}  var={var}')
        cands = [
            ('removed', ''),
            ('saveset0', '{ __typeof__(%s) v_ = %s; %s = 0; %s = v_; }' % (var, var, var, var)),
            ('saveset1', '{ __typeof__(%s) v_ = %s; %s = (__typeof__(%s))1; %s = v_; }' % (var, var, var, var, var)),
            ('saveset-1', '{ __typeof__(%s) v_ = %s; %s = (__typeof__(%s))-1; %s = v_; }' % (var, var, var, var, var)),
            ('deadset0-post', '%s = 0;' % var),
        ]
        for label, rep in cands:
            t = src[:pos] + rep + src[pos + len(text):]
            write(t)
            s, f = gate()
            print(f'  {label:16s} {s}   ' + ' | '.join(x[:60] for x in f[:3]))
finally:
    path.write_bytes(orig)
