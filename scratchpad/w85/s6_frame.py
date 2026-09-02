#!/usr/bin/env python3
"""s6_frame.py FILE FUNC -- compile FILE and print the .frame line for FUNC."""
import sys, subprocess, re
from pathlib import Path
ROOT = Path(__file__).resolve().parents[2]
f = sys.argv[1]; fn = sys.argv[2]
subprocess.run([sys.executable, str(ROOT/'tools'/'tugate.py'), f],
               capture_output=True, text=True, cwd=str(ROOT))
s = (ROOT/'build'/f).with_suffix('.c.s')
txt = s.read_text(errors='replace').split('\n')
for i, ln in enumerate(txt):
    if ln.strip() == fn + ':':
        print(txt[i+1].strip())
        break
