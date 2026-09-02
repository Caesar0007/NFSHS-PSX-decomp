#!/usr/bin/env python3
"""C1_spdiff.py CAND FUNC -- sp-blind unified diff (ours vs oracle)."""
import re, sys, difflib
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent.parent
src = (ROOT/'scratchpad'/'w84'/'C1_verify.py').read_text()
cut = src.index("allpass=True")
ns = {'sys': sys, '__file__': str(ROOT/'scratchpad'/'w84'/'C1_verify.py')}
argv = sys.argv[1:]
sys.argv = ['C1_verify.py', argv[0], argv[1]]
exec(compile(src[:cut], 'C1_verify.py', 'exec'), ns)
m = (lambda s: [re.sub(r'-?\d+\(sp\)', 'D(sp)', x) for x in s])
o, e = m(ns['ours'](argv[1])), m(ns['oracle'](argv[1]))
for l in difflib.unified_diff(o, e, 'ours', 'oracle', n=2, lineterm=''):
    print(l)
print(f'[ours={len(o)} oracle={len(e)}]')
