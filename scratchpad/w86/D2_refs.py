#!/usr/bin/env python3
"""D2_refs.py FILE PATCHFILE "fn signature" [pseudo...]
For each variant: apply, rtl_dump, print the top of the allocno table
(and the named pseudos' refs/live), then restore."""
import subprocess, sys, ast, re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
rel = sys.argv[1].replace('\\', '/')
variants = ast.literal_eval(Path(sys.argv[2]).read_text(encoding='utf-8'))
fn = sys.argv[3]
watch = set(sys.argv[4:])
path = ROOT / rel
orig = path.read_bytes()
crlf = b'\r\n' in orig
src = orig.decode('utf-8', 'surrogateescape')
if crlf:
    src = src.replace('\r\n', '\n')
tu = Path(rel).stem

def write(t):
    if crlf:
        t = t.replace('\n', '\r\n')
    path.write_bytes(t.encode('utf-8', 'surrogateescape'))

def dump():
    subprocess.run([sys.executable, 'tools/rtl_dump.py', rel],
                   capture_output=True, text=True, cwd=str(ROOT))
    r = subprocess.run([sys.executable, 'tools/prio.py',
                        f'scratch/rtl/{tu}.i.greg', f'scratch/rtl/{tu}.i.lreg', fn],
                       capture_output=True, text=True, cwd=str(ROOT))
    return r.stdout + r.stderr

try:
    for label, pairs in [('BASELINE', [])] + list(variants):
        t = src
        bad = False
        for old, new in pairs:
            if t.count(old) != 1:
                print(f'--- {label}: !! pattern {t.count(old)}x'); bad = True; break
            t = t.replace(old, new)
        if bad:
            continue
        write(t)
        out = dump()
        rows = [l for l in out.splitlines() if l.strip().startswith(tuple('0123456789'))]
        sel = [l for l in rows if (not watch) or any(f'p{w:>4}' in l or f'p {w}' in l or re.search(r'p\s*%s\b' % w, l) for w in watch)]
        print(f'--- {label}')
        for l in (sel if watch else rows[:12]):
            print('    ' + l.strip())
finally:
    path.write_bytes(orig)
