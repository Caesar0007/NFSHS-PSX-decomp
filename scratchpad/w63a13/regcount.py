"""regcount.py CPP FUNC -- per-register usage counts + first/last index, ours vs oracle."""
import sys, os, re
from pathlib import Path
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tools'))
src = (ROOT / 'tools' / 'verify_asm.py').read_text()
head = src.split('\nallpass=True', 1)[0]
g = {'__name__': 'va', '__file__': str(ROOT / 'tools' / 'verify_asm.py')}
sys.argv = ['verify_asm.py', sys.argv[1], sys.argv[2]]
FN = sys.argv[2]
exec(compile(head, 'verify_asm.py', 'exec'), g)
o = g['ours'](FN); e = g['oracle'](FN)
REGS = ('zero|at|v0|v1|a0|a1|a2|a3|t0|t1|t2|t3|t4|t5|t6|t7|'
        's0|s1|s2|s3|s4|s5|s6|s7|t8|t9|k0|k1|gp|sp|fp|ra')
RX = re.compile(r'\b(%s)\b' % REGS)
ORDER = ['zero','at','v0','v1','a0','a1','a2','a3','t0','t1','t2','t3','t4','t5','t6','t7',
         's0','s1','s2','s3','s4','s5','s6','s7','t8','t9','gp','sp','fp','ra']


def tab(stream):
    d = {}
    for i, ins in enumerate(stream):
        for r in set(RX.findall(ins)):
            c, f, l = d.get(r, (0, i, i))
            d[r] = (c + 1, min(f, i), i)
    return d


a, b = tab(o), tab(e)
print('%-5s %-22s %-22s' % ('reg', 'OURS cnt/first/last', 'ORACLE cnt/first/last'))
for r in ORDER:
    if r in a or r in b:
        x = a.get(r); y = b.get(r)
        print('%-5s %-22s %-22s' % (
            r,
            '%d / %d / %d' % x if x else '-',
            '%d / %d / %d' % y if y else '-'))
