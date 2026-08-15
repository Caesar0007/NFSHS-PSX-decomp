"""permtest.py CPP FUNC "t0=t1,t3=t4,..." -- apply a register permutation to OURS
and re-diff vs the oracle.  Answers "if the handout shifted, how much collapses?"
"""
import sys, os, re, difflib
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
m = dict(p.split('=') for p in argv[3].split(',') if p)
RX = re.compile(r'\b(%s)\b' % '|'.join(sorted(m, key=len, reverse=True)))
LO = int(os.environ.get('LO','0')); HI = int(os.environ.get('HI','999999'))
o2 = [RX.sub(lambda mo: m[mo.group(1)], ins) if LO <= i < HI else ins
      for i, ins in enumerate(o)]


def nd(a, b):
    return len([l for l in difflib.unified_diff(a, b, lineterm='')
                if l[0] in '+-' and not l.startswith(('+++', '---'))])


pos0=sum(1 for a,b in zip(o,e) if a!=b); pos1=sum(1 for a,b in zip(o2,e) if a!=b)
print('POSITIONAL mismatches raw %d -> permuted %d' % (pos0,pos1))
print('raw %d -> permuted %d   (ours %d / oracle %d)' % (nd(o, e), nd(o2, e), len(o), len(e)))
d = [l for l in difflib.unified_diff(o2, e, lineterm='')
     if l[0] in '+-' and not l.startswith(('+++', '---'))]
for l in d[:int(os.environ.get('N', '40'))]:
    print('   ' + l)
