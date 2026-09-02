#!/usr/bin/env python3
"""C1_dump.py CAND FUNC -- print OUR normalized emitted stream (verify_asm's own
`ours()`), one insn per line with index.  Honours C1_* / NFS4_* probe envs."""
import sys
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent.parent
src = (ROOT/'scratchpad'/'w84'/'C1_verify.py').read_text()
cut = src.index("allpass=True")
ns = {'sys': sys, '__file__': str(ROOT/'scratchpad'/'w84'/'C1_verify.py')}
argv = sys.argv[1:]
sys.argv = ['C1_verify.py', argv[0], argv[1]]
exec(compile(src[:cut], 'C1_verify.py', 'exec'), ns)
for i, l in enumerate(ns['ours'](argv[1])):
    print(f'{i:4d}  {l}')
