"""alphacmp.py CPP FUNC -- alpha-renamed structural compare (w62-a13).

Loads verify_asm.py's SOURCE (12H anti-drift: never re-implement the
normalizers), executes everything BEFORE its `allpass=True` main block, then
uses its ours()/oracle() to answer one question:

    is the residual PURE REGISTER ROTATION (alpha streams identical)
    or EMISSION ORDER / real structure (alpha streams still differ)?

Also prints the register correspondence map when the streams are alpha-equal.
"""
import sys, os, re, difflib
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tools'))
src = (ROOT / 'tools' / 'verify_asm.py').read_text()
head = src.split('\nallpass=True', 1)[0]
g = {'__name__': 'va', '__file__': str(ROOT / 'tools' / 'verify_asm.py')}
sys.argv = ['verify_asm.py', sys.argv[1], sys.argv[2]]
FN = sys.argv[2]
exec(compile(head, 'verify_asm.py', 'exec'), g)

o = g['ours'](FN)
e = g['oracle'](FN)
print('ours %d / oracle %d' % (len(o), len(e)))

REGS = ('zero|at|v0|v1|a0|a1|a2|a3|t0|t1|t2|t3|t4|t5|t6|t7|'
        's0|s1|s2|s3|s4|s5|s6|s7|t8|t9|k0|k1|gp|sp|fp|ra')
RX = re.compile(r'\b(%s)\b' % REGS)
FIXED = ('zero', 'sp', 'ra', 'gp')


def alpha(stream):
    m, out = {}, []
    for ins in stream:
        def sub(mo):
            r = mo.group(1)
            if r in FIXED:
                return r
            if r not in m:
                m[r] = 'R%d' % len(m)
            return m[r]
        out.append(RX.sub(sub, ins))
    return out, m


ao, mo = alpha(o)
ae, me = alpha(e)
d = [l for l in difflib.unified_diff(ao, ae, lineterm='')
     if l[0] in '+-' and not l.startswith(('+++', '---'))]
print('ALPHA diffs: %d   (raw diffs: %d)' % (
    len(d),
    len([l for l in difflib.unified_diff(o, e, lineterm='')
         if l[0] in '+-' and not l.startswith(('+++', '---'))])))
if not d:
    inv = {v: k for k, v in me.items()}
    print('PURE ROTATION. ours -> oracle:')
    for r, a in sorted(mo.items(), key=lambda kv: int(kv[1][1:])):
        print('   %-4s -> %-4s' % (r, inv.get(a, '?')))
else:
    for l in d[:int(os.environ.get('N', '60'))]:
        print('   ' + l)
