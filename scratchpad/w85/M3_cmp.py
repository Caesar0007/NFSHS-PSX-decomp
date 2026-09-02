"""M3_cmp.py OURSTREAM [--mode raw|sp|spreg] — compare our normalised stream vs the JPN oracle.

Modes:
  raw    exact gate-like compare (no masking beyond norm)
  sp     mask every sp displacement (frame-size blind)
  spreg  mask sp displacements AND all register names (structure only)
Prints LCS-based diff count and the hunk list (first N hunks).
"""
import re, sys, difflib
sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/w84')
from R02_norm import load

def mask(t, mode):
    if mode in ('sp', 'spreg'):
        t = re.sub(r',-?\d+\(sp\)', ',S(sp)', t)
        t = re.sub(r'^(addiu sp,sp),-?\d+$', r'\1,S', t)
    if mode == 'spreg':
        t = re.sub(r'\b(zero|at|v[01]|a[0-3]|t[0-9]|s[0-7]|k[01]|gp|sp|fp|ra)\b', 'R', t)
    if mode in ('skel', 'skelnr'):
        t = re.sub(r'-?\b\d+\b', 'N', t)
        t = t.replace('HI', 'N').replace('LO', 'N')
    if mode == 'skelnr':
        t = re.sub(r'\b(zero|at|v[01]|a[0-3]|t[0-9]|s[0-7]|k[01]|gp|sp|fp|ra)\b', 'R', t)
    return t

ours = [l for l in open(sys.argv[1]).read().splitlines() if l.strip()]
orc  = load('C:/Temp/nfs4-decomp/regiondiff/oracles/NFS4-R-JPN/__15tGlobalMenuDefs.s')
mode = 'raw'
for a in sys.argv[2:]:
    if a.startswith('--mode'):
        mode = a.split('=', 1)[1]
A = [mask(x, mode) for x in ours]
B = [mask(x, mode) for x in orc]
sm = difflib.SequenceMatcher(None, A, B, autojunk=False)
n = 0
hunks = []
for tag, i1, i2, j1, j2 in sm.get_opcodes():
    if tag == 'equal':
        continue
    n += (i2 - i1) + (j2 - j1)
    hunks.append((i1, i2, j1, j2, ours[i1:i2], orc[j1:j2]))
print('ours %d oracle %d  mode=%s  diffs=%d  hunks=%d' % (len(A), len(B), mode, n, len(hunks)))
lim = int(sys.argv[-1]) if sys.argv[-1].isdigit() else 40
for h in hunks[:lim]:
    print('--- @ours %d..%d / oracle %d..%d' % (h[0], h[1], h[2], h[3]))
    for l in h[4]:
        print('   -', l)
    for l in h[5]:
        print('   +', l)
