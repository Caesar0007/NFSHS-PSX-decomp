"""dump.py CPP FUNC [lo] [hi] -- print ours/oracle normalized streams side by side."""
import sys, os
from pathlib import Path
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tools'))
src = (ROOT / 'tools' / 'verify_asm.py').read_text()
head = src.split('\nallpass=True', 1)[0]
g = {'__name__': 'va', '__file__': str(ROOT / 'tools' / 'verify_asm.py')}
argv = sys.argv[:]
sys.argv = ['verify_asm.py', argv[1], argv[2]]
FN = argv[2]
exec(compile(head, 'verify_asm.py', 'exec'), g)
o = g['ours'](FN); e = g['oracle'](FN)
lo = int(argv[3]) if len(argv) > 3 else 0
hi = int(argv[4]) if len(argv) > 4 else max(len(o), len(e))
for i in range(lo, min(hi, max(len(o), len(e)))):
    a = o[i] if i < len(o) else ''
    b = e[i] if i < len(e) else ''
    print('%4d  %-34s %s %s' % (i, a, ' ' if a == b else '|', b))
