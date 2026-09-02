#!/usr/bin/env python3
"""S4_try.py FILE PATCHFILE [--apply]
PATCHFILE = a python literal list of (old, new) string pairs applied in order
(each `old` must occur exactly once).  Gates the whole TU, then restores unless
--apply is given.  No tool file is touched."""
import subprocess, sys, ast
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent.parent
rel = sys.argv[1].replace('\\', '/')
pairs = ast.literal_eval(Path(sys.argv[2]).read_text(encoding='utf-8'))
apply = '--apply' in sys.argv
path = ROOT / rel
bak = path.read_bytes()
ok = False
try:
    t = path.read_text(encoding='utf-8', errors='surrogateescape')
    for old, new in pairs:
        n = t.count(old)
        if n != 1:
            print(f"!! pattern occurs {n} times: {old[:70]!r}"); sys.exit(2)
        t = t.replace(old, new)
    path.write_text(t, encoding='utf-8', errors='surrogateescape')
    r = subprocess.run([sys.executable, str(ROOT / 'tools' / 'tugate.py'), rel],
                       capture_output=True, text=True, cwd=str(ROOT))
    out = '\n'.join(l for l in (r.stdout + r.stderr).splitlines() if 'NO ORACLE' not in l)
    print(out.strip())
    ok = True
finally:
    if not (apply and ok):
        path.write_bytes(bak)
