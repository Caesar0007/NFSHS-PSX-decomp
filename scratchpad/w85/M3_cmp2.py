"""M3_cmp2.py A B [--mode=...] [lim] — compare two streams.
A/B may be a .txt (our dumped stream) or a .s oracle path."""
import re, sys, difflib
sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/w84')
from R02_norm import load

def get(p):
    if p.endswith('.s'):
        return load(p)
    return [l for l in open(p).read().splitlines() if l.strip()]

def mask(t, mode):
    if mode in ('sp', 'spreg', 'skelnr', 'skel'):
        t = re.sub(r',-?\d+\(sp\)', ',S(sp)', t)
        t = re.sub(r'^(addiu sp,sp),-?\d+$', r'\1,S', t)
    if mode in ('skel', 'skelnr'):
        t = re.sub(r'-?\b\d+\b', 'N', t)
        t = t.replace('HI', 'N').replace('LO', 'N')
    if mode in ('spreg', 'skelnr'):
        t = re.sub(r'\b(zero|at|v[01]|a[0-3]|t[0-9]|s[0-7]|k[01]|gp|sp|fp|ra)\b', 'R', t)
    return t

A0, B0 = get(sys.argv[1]), get(sys.argv[2])
mode = 'raw'
lim = 20
for a in sys.argv[3:]:
    if a.startswith('--mode'):
        mode = a.split('=', 1)[1]
    elif a.isdigit():
        lim = int(a)
A = [mask(x, mode) for x in A0]
B = [mask(x, mode) for x in B0]
sm = difflib.SequenceMatcher(None, A, B, autojunk=False)
n = 0
hunks = []
for tag, i1, i2, j1, j2 in sm.get_opcodes():
    if tag == 'equal':
        continue
    n += (i2 - i1) + (j2 - j1)
    hunks.append((i1, i2, j1, j2))
print('A %d B %d mode=%s diffs=%d hunks=%d' % (len(A), len(B), mode, n, len(hunks)))
for (i1, i2, j1, j2) in hunks[:lim]:
    print('--- A %d..%d / B %d..%d' % (i1, i2, j1, j2))
    for l in A0[i1:i2]:
        print('   -', l)
    for l in B0[j1:j2]:
        print('   +', l)
