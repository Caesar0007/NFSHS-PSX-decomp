#!/usr/bin/env python3
"""w48_a5_spell.py <file> <anchor-file> <variants-file>
Simple spelling sweep: replace the region between two marker strings in <file> with each variant
from a python file defining VARIANTS = [(name, text), ...], gate the whole TU, restore in finally."""
import sys, subprocess, importlib.util
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent
f = ROOT / sys.argv[1]
spec = importlib.util.spec_from_file_location('v', ROOT / sys.argv[2])
m = importlib.util.module_from_spec(spec); spec.loader.exec_module(m)
orig = f.read_text(newline='')
base = m.BASE
assert orig.count(base) == 1, f"anchor count {orig.count(base)}"
try:
    for name, txt in m.VARIANTS:
        f.write_text(orig.replace(base, txt, 1), newline='')
        r = subprocess.run([sys.executable, str(ROOT / 'scratch' / 'w48_a5_tugate.py'), sys.argv[1]],
                           capture_output=True, text=True, cwd=str(ROOT))
        out = r.stdout.strip().splitlines()
        tail = out[-1] if out else r.stderr.strip().splitlines()[-1][:200]
        fns = [l for l in out if any(k in l for k in m.WATCH)]
        print(f"--- {name}: {tail}")
        for l in fns:
            print("    " + l.rstrip())
finally:
    f.write_text(orig, newline='')
