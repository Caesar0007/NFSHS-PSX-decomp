#!/usr/bin/env python3
"""sbs2.py <patchfile> <recon-file> <Fn> -- side-by-side ours|oracle, with a candidate
build.py table patch exec'd into verify_asm's namespace (same trick as probe.py)."""
import sys, difflib
from pathlib import Path

ROOT = Path(r'C:/Temp/nfs4-decomp')
sys.path.insert(0, str(ROOT / 'tools'))
patch = Path(sys.argv[1]).resolve()
recon, fn = sys.argv[2], sys.argv[3]
va = ROOT / 'tools' / 'verify_asm.py'
src = va.read_text()
needle = "bld.OUT = bld.BUILD"
src = src.replace(needle, needle + "\nexec(compile(open(r'%s').read(), r'%s', 'exec'))"
                  % (patch.as_posix(), patch.as_posix()), 1)
sys.argv = [str(va), recon, '__none__']
g = {'__file__': str(va), '__name__': '__main__'}
try:
    exec(compile(src, str(va), 'exec'), g)
except SystemExit:
    pass
a, b = g['ours'](fn), g['oracle'](fn)
rows = []
for tag, i1, i2, j1, j2 in difflib.SequenceMatcher(None, a, b, autojunk=False).get_opcodes():
    if tag == 'equal':
        for k in range(i2 - i1):
            rows.append((' ', a[i1 + k], b[j1 + k]))
    else:
        for k in range(max(i2 - i1, j2 - j1)):
            rows.append(('X', a[i1 + k] if i1 + k < i2 else '',
                         b[j1 + k] if j1 + k < j2 else ''))
print(f"{fn}: ours {len(a)} / oracle {len(b)}")
for i, (m, l, r) in enumerate(rows):
    print(f"{i:4} {m} {l:<40} | {r}")
