#!/usr/bin/env python3
"""C1_spblind.py CAND FUNC -- ours-vs-oracle diff counts at three blindness levels:
  strict            = the gate's own normalizer
  sp-blind          = every N(sp) displacement masked
  sp+reg-blind      = also every register name masked
(catalog 30E-2's instrument, rebuilt on the W84-C1 gate copy so it works on a
lane-aliased scratch sibling.)"""
import re, sys, difflib
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent.parent
src = (ROOT/'scratchpad'/'w84'/'C1_verify.py').read_text()
cut = src.index("allpass=True")
ns = {'sys': sys, '__file__': str(ROOT/'scratchpad'/'w84'/'C1_verify.py')}
argv = sys.argv[1:]
sys.argv = ['C1_verify.py', argv[0], argv[1]]
exec(compile(src[:cut], 'C1_verify.py', 'exec'), ns)
o, e = ns['ours'](argv[1]), ns['oracle'](argv[1])
REG = r'(?:zero|at|v[01]|a[0-3]|t[0-9]|s[0-7]|k[01]|gp|sp|fp|ra)'
def blind(seq, sp, rg):
    out = []
    for l in seq:
        if sp: l = re.sub(r'-?\d+\(sp\)', 'D(sp)', l)
        if rg: l = re.sub(REG, 'R', l)
        out.append(l)
    return out
def count(a, b):
    sm = difflib.SequenceMatcher(None, a, b, autojunk=False)
    return sum(max(i2-i1, j2-j1) for t, i1, i2, j1, j2 in sm.get_opcodes() if t != 'equal')
print(f'{argv[1]}: ours {len(o)} / oracle {len(e)}')
print(f'  strict       {count(o, e)}')
print(f'  sp-blind     {count(blind(o,1,0), blind(e,1,0))}')
print(f'  sp+reg-blind {count(blind(o,1,1), blind(e,1,1))}')
