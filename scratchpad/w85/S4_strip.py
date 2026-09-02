#!/usr/bin/env python3
"""S4_strip.py FILE LINE[,LINE...] [--apply]
Strips every zero-insn `__asm__(...)` STATEMENT that starts on the given 1-based
source lines (leaving any other code on the line intact), then gates the whole TU.
Restores unless --apply.  Multi-line asm statements are supported (the matcher
walks to the terminating `);`)."""
import subprocess, sys, re
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent.parent
rel = sys.argv[1].replace('\\', '/')
targets = {int(x) for x in sys.argv[2].split(',')}
apply = '--apply' in sys.argv
path = ROOT / rel
bak = path.read_bytes()
ok = False
try:
    t = path.read_text(encoding='utf-8', errors='surrogateescape')
    out = []
    line = 1
    i = 0
    removed = 0
    pat = re.compile(r'__asm__\s*(?:volatile|__volatile__)?\s*\(')
    while i < len(t):
        m = pat.match(t, i)
        if m and line in targets:
            # walk to the matching ')' then the ';'
            depth = 0
            j = m.end() - 1
            while j < len(t):
                if t[j] == '(':
                    depth += 1
                elif t[j] == ')':
                    depth -= 1
                    if depth == 0:
                        break
                j += 1
            k = t.index(';', j) + 1
            removed += 1
            line += t.count('\n', i, k)
            out.append('\n' * t.count('\n', i, k))
            i = k
            continue
        if t[i] == '\n':
            line += 1
        out.append(t[i])
        i += 1
    if not removed:
        print('!! nothing removed'); sys.exit(2)
    path.write_text(''.join(out), encoding='utf-8', errors='surrogateescape')
    r = subprocess.run([sys.executable, str(ROOT / 'tools' / 'tugate.py'), rel],
                       capture_output=True, text=True, cwd=str(ROOT))
    res = '\n'.join(l for l in (r.stdout + r.stderr).splitlines() if 'NO ORACLE' not in l)
    print(f'[removed {removed} asm stmt(s)]')
    print(res.strip())
    ok = True
finally:
    if not (apply and ok):
        path.write_bytes(bak)
