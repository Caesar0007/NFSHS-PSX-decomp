#!/usr/bin/env python3
"""w48_a5_fnsplice.py <recon.c> <FN,FN,...>
Patch PER_FN_NO_DELAYED_BRANCH in tools/build.py IN PLACE to add the named functions for that TU,
run the whole-TU gate, then ALWAYS restore build.py. Report-only probe (w48 rule 2)."""
import sys, subprocess
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent
BUILD = ROOT / 'tools' / 'build.py'
tu, fns = sys.argv[1], sys.argv[2].split(',')
orig = BUILD.read_text(newline='')
anchor = 'PER_FN_NO_DELAYED_BRANCH = {'
i = orig.index(anchor) + len(anchor)
nl = '\r\n' if '\r\n' in orig[:4000] else '\n'
ins = nl + f'    "{tu}": {{' + ', '.join(f'"{f}"' for f in fns) + '},'
patched = orig[:i] + ins + orig[i:]
try:
    BUILD.write_text(patched, newline='')
    r = subprocess.run([sys.executable, str(ROOT / 'scratch' / 'w48_a5_tugate.py'), tu],
                       capture_output=True, text=True, cwd=str(ROOT))
    print(r.stdout or r.stderr[-800:])
finally:
    BUILD.write_text(orig, newline='')
