#!/usr/bin/env python3
"""sbs.py CPP FN -- side-by-side ours|oracle stream, aligned by difflib opcodes.
Anti-drift (12H): loads tools/verify_asm.py's SOURCE and reuses its own ours()/oracle()
normalizers; only the final compare step is replaced.
"""
import sys, difflib
from pathlib import Path
ROOT = Path(r'C:\Temp\nfs4-decomp')
sys.path.insert(0, str(ROOT / 'tools'))
src = (ROOT / 'tools' / 'verify_asm.py').read_text()
head = src.split('allpass=True')[0]
g = {'__name__': '__vsrc__', '__file__': str(ROOT / 'tools' / 'verify_asm.py')}
sys.argv = ['verify_asm.py', sys.argv[1], sys.argv[2]]
exec(compile(head, 'verify_asm_head', 'exec'), g)
fn = sys.argv[2]
o = g['ours'](fn); e = g['oracle'](fn)
sm = difflib.SequenceMatcher(None, o, e, autojunk=False)
n = 0
for tag, i1, i2, j1, j2 in sm.get_opcodes():
    if tag == 'equal':
        for k in range(i2 - i1):
            print('%4d %4d     %-34s| %s' % (i1 + k, j1 + k, o[i1 + k], e[j1 + k]))
    else:
        L = max(i2 - i1, j2 - j1)
        n += (i2 - i1) + (j2 - j1)
        for k in range(L):
            a = o[i1 + k] if i1 + k < i2 else ''
            b = e[j1 + k] if j1 + k < j2 else ''
            print('%4s %4s  *  %-34s| %s' % (i1 + k if a else '', j1 + k if b else '', a, b))
print('# ours %d oracle %d  diffs(seqmatch) %d' % (len(o), len(e), n))
