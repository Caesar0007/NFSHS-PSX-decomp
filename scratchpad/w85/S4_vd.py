#!/usr/bin/env python3
"""S4_vd.py FILE FN [dropline,...]  -- vdiff one fn, optionally with device lines removed.
Always restores the file."""
import subprocess, sys
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent.parent
rel = sys.argv[1].replace('\\', '/')
fn = sys.argv[2]
lines = [int(x) for x in sys.argv[3].split(',')] if len(sys.argv) > 3 and sys.argv[3] else []
path = ROOT / rel
bak = path.read_bytes()
try:
    if lines:
        txt = path.read_text(encoding='utf-8', errors='surrogateescape').split('\n')
        for n in sorted(lines, reverse=True):
            del txt[n - 1]
        path.write_text('\n'.join(txt), encoding='utf-8', errors='surrogateescape')
    r = subprocess.run([sys.executable, str(ROOT / 'tools' / 'vdiff.py'), rel, fn],
                       capture_output=True, text=True, cwd=str(ROOT))
    print(r.stdout + r.stderr)
finally:
    path.write_bytes(bak)
