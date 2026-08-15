"""opcen.py CPP FN [FN...] -- per-opcode census ours vs oracle, using verify_asm's own
normalizers (12H anti-drift: load its SOURCE, never re-implement)."""
import sys, os
from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]
os.chdir(str(ROOT))
sys.path.insert(0, str(ROOT / 'tools'))
src = (ROOT / 'tools' / 'verify_asm.py').read_text()
head = src.split('\nallpass=True', 1)[0]
argv = sys.argv[:]
sys.argv = ['verify_asm.py', argv[1], argv[2]]
g = {'__name__': 'va', '__file__': str(ROOT / 'tools' / 'verify_asm.py')}
exec(compile(head, 'verify_asm.py', 'exec'), g)


def cen(s):
    d = {}
    for l in s:
        op = l.split()[0]
        d[op] = d.get(op, 0) + 1
    return d


for fn in argv[2:]:
    o, e = g['ours'](fn), g['oracle'](fn)
    co, ce = cen(o), cen(e)
    keys = sorted(set(co) | set(ce))
    print('== %s  ours %d / oracle %d' % (fn, len(o), len(e)))
    diffs = ' '.join('%s %dv%d' % (k, co.get(k, 0), ce.get(k, 0))
                     for k in keys if co.get(k, 0) != ce.get(k, 0))
    print('   ' + (diffs if diffs else '(opcode multiset IDENTICAL)'))
