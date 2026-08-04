#!/usr/bin/env python3
"""w48_a5_tuflag.py '<key>:<val>[,<key>:<val>...]' <recon.c> [<recon.c> ...]
Patch PER_TU_FLAGS in tools/build.py IN PLACE for the given TUs, run the whole-TU gate on each,
then ALWAYS restore build.py (finally). Report-only probe harness (w48 rule 2)."""
import sys, subprocess, os
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent
BUILD = ROOT / 'tools' / 'build.py'
spec = sys.argv[1]
tus = sys.argv[2:]
flags = {}
for kv in spec.split(','):
    k, v = kv.split(':', 1)
    flags[k] = v
lit = '{' + ', '.join(f'"{k}": {v}' for k, v in flags.items()) + '}'

orig = BUILD.read_text(newline='')
anchor = 'PER_TU_FLAGS = {\n'
if anchor not in orig:
    anchor = 'PER_TU_FLAGS = {\r\n'
ins = ''.join(f'    "{t}": {lit},\n' for t in tus)
nl = '\r\n' if '\r\n' in orig[:4000] else '\n'
ins = ins.replace('\n', nl)
patched = orig.replace(anchor, anchor + ins, 1)
assert patched != orig, 'anchor not found'
try:
    BUILD.write_text(patched, newline='')
    for t in tus:
        r = subprocess.run([sys.executable, str(ROOT / 'scratch' / 'w48_a5_tugate.py'), t],
                           capture_output=True, text=True, cwd=str(ROOT))
        print(r.stdout.strip().splitlines()[-1] if r.stdout.strip() else r.stderr[-400:])
finally:
    BUILD.write_text(orig, newline='')
