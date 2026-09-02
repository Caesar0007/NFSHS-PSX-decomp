"""M3_slots.py OURSTREAM — tabulate ours-vs-oracle sp displacement pairs on the
skelnr-aligned equal runs.  Shows whether our frame carries extra slots and where."""
import re, sys, difflib, collections
sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/w84')
from R02_norm import load

def skelnr(t):
    t = re.sub(r',-?\d+\(sp\)', ',S(sp)', t)
    t = re.sub(r'^(addiu sp,sp),-?\d+$', r'\1,S', t)
    t = re.sub(r'-?\b\d+\b', 'N', t)
    t = t.replace('HI', 'N').replace('LO', 'N')
    t = re.sub(r'\b(zero|at|v[01]|a[0-3]|t[0-9]|s[0-7]|k[01]|gp|sp|fp|ra)\b', 'R', t)
    return t

ours = [l for l in open(sys.argv[1]).read().splitlines() if l.strip()]
orc = load('C:/Temp/nfs4-decomp/regiondiff/oracles/NFS4-R-JPN/__15tGlobalMenuDefs.s')
sm = difflib.SequenceMatcher(None, [skelnr(x) for x in ours], [skelnr(x) for x in orc], autojunk=False)
pairs = collections.Counter()
D = re.compile(r',(-?\d+)\(sp\)$')
for tag, i1, i2, j1, j2 in sm.get_opcodes():
    if tag != 'equal':
        continue
    for k in range(i2 - i1):
        a, b = ours[i1 + k], orc[j1 + k]
        ma, mb = D.search(a), D.search(b)
        if ma and mb:
            pairs[(int(ma.group(1)), int(mb.group(1)))] += 1
tot = sum(pairs.values())
print('aligned sp-ref pairs:', tot)
same = sum(v for (o, e), v in pairs.items() if o == e)
print('identical disp:', same, ' differing:', tot - same)
for (o, e), v in sorted(pairs.items()):
    if o != e:
        print('  ours %4d -> oracle %4d   x%d' % (o, e, v))
print('--- delta histogram')
h = collections.Counter()
for (o, e), v in pairs.items():
    h[o - e] += v
for d, v in sorted(h.items()):
    print('  delta %+d : %d' % (d, v))
