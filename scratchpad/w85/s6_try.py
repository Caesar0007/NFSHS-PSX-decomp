#!/usr/bin/env python3
r"""s6_try.py FILE  --  apply a list of (old,new) substring edits from a JSON spec
file and gate.  Usage:  s6_try.py FILE spec.json  [--keep]

spec.json = { "name": [[old,new], ...], ... }   -> each name is tried in turn,
the file is restored between tries, and the gate line is printed.
"""
import json
import subprocess
import sys
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
f = ROOT / sys.argv[1]
spec = json.loads(Path(sys.argv[2]).read_text(encoding='utf-8'))
orig = f.read_text(encoding='utf-8', errors='surrogateescape')


def gate():
    r = subprocess.run([sys.executable, str(ROOT / 'tools' / 'tugate.py'), sys.argv[1]],
                       capture_output=True, text=True, cwd=str(ROOT))
    o = (r.stdout or '') + (r.stderr or '')
    m = re.search(r':\s*(\d+)/(\d+) PASS', o)
    tail = [l.strip() for l in o.split('\n') if re.match(r'^\s+\d+\s+\w', l)]
    return (m.group(0) if m else 'COMPILE-FAIL'), tail


try:
    for name, edits in spec.items():
        s = orig
        ok = True
        for old, new in edits:
            if old not in s:
                print(f'{name}: MISSING PATTERN {old!r}')
                ok = False
                break
            s = s.replace(old, new)
        if not ok:
            continue
        f.write_text(s, encoding='utf-8', errors='surrogateescape')
        g, tail = gate()
        print(f'{name}: {g}   {"; ".join(tail)}')
        sys.stdout.flush()
finally:
    f.write_text(orig, encoding='utf-8', errors='surrogateescape')
