"""fncount_hunks.py CPP FN -- like fndiff.py, but register-blind and only the hunks where the INSTRUCTION COUNT differs
(so pure register-renaming noise disappears).  Prints oracle/ours slices with a little context."""
import difflib
import importlib.util
import re
import sys
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
sys.path.insert(0, str(ROOT / 'tools'))
cpp, fn = sys.argv[1], sys.argv[2]
sys.argv = [sys.argv[0], cpp, '__none__']
sp = importlib.util.spec_from_file_location('va', ROOT / 'tools' / 'verify_asm.py')
V = importlib.util.module_from_spec(sp)
try:
    sp.loader.exec_module(V)
except SystemExit:
    pass
o, u = V.oracle(fn), V.ours(fn)


def blind(x):
    return re.sub(r'\b(s[0-8]|t[0-9]|v[01]|a[0-3])\b', 'R', x)


ob, ub = [blind(x) for x in o], [blind(x) for x in u]
print(fn, 'oracle', len(o), 'ours', len(u))
for tag, i1, i2, j1, j2 in difflib.SequenceMatcher(None, ob, ub, autojunk=False).get_opcodes():
    if tag != 'equal' and (i2 - i1) != (j2 - j1):
        print('--- oracle[%d:%d] vs ours[%d:%d]' % (i1, i2, j1, j2))
        for x in o[max(0, i1 - 3):i2 + 3]:
            print('   O ', x)
        for x in u[max(0, j1 - 3):j2 + 3]:
            print('   U ', x)
