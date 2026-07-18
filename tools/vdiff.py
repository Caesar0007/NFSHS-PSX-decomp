#!/usr/bin/env python3
"""vdiff.py CPP FUNC -- full unified diff (no truncation), context=2."""
import sys, subprocess
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent
import importlib.util
spec = importlib.util.spec_from_file_location('va', ROOT / 'tools' / 'verify_asm.py')
# verify_asm.py runs top-level code on import (argv-based) -- instead, re-implement via exec of its ours()/oracle()
# Simpler: just call it as a subprocess with a wrapper that monkeypatches sys.argv is hard since it's a script.
# Instead, duplicate minimal logic by importing as text and exec'ing functions.
src = (ROOT/'tools'/'verify_asm.py').read_text()
# Cut off the top-level driver (find 'allpass=True') and exec only defs+setup above it, with sys.argv patched.
cut = src.index("allpass=True")
header = src[:cut]
ns = {'sys': sys, '__file__': str(ROOT/'tools'/'verify_asm.py')}
sys.argv = ['verify_asm.py', sys.argv[1], sys.argv[2]]
exec(compile(header, 'verify_asm.py', 'exec'), ns)
fn = sys.argv[2]
o = ns['ours'](fn)
e = ns['oracle'](fn)
if e is None:
    print("NO ORACLE"); sys.exit(1)
if not o:
    print("NOT IN OBJECT"); sys.exit(1)
import difflib
d = list(difflib.unified_diff(o, e, fromfile='ours', tofile='oracle', lineterm='', n=3))
for l in d:
    print(l)
print(f"\n[ours={len(o)} oracle={len(e)}]")
