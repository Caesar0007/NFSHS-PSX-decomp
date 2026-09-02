"""M3_where.py CFG — where do the residual diffs live?

Aligns our stream to the JPN oracle on the reg-blind/sp-blind skeleton (stable
even when a register phase differs), then reports, per 100-instruction bucket,
how many aligned pairs differ after reloc masking.
"""
import re, sys, difflib, collections
sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/w85')
import M3_score as S


def sk(t):
    t = re.sub(r',-?\d+\(sp\)', ',S(sp)', t)
    t = re.sub(r'^(addiu sp,sp),-?\d+$', r'\1,S', t)
    t = re.sub(r'-?\b\d+\b', 'N', t)
    t = t.replace('HI', 'N').replace('LO', 'N')
    return re.sub(r'\b(zero|at|v[01]|a[0-3]|t[0-9]|s[0-7]|k[01]|gp|sp|fp|ra)\b', 'R', t)


cfg = sys.argv[1]
st = S.build(cfg)
A = [t for t, k in st]
K = [k for t, k in st]
B = S.ORACLE
sm = difflib.SequenceMatcher(None, [sk(x) for x in A], [sk(x) for x in B], autojunk=False)
buckets = collections.Counter()
tot = 0
unaligned = 0
for tag, i1, i2, j1, j2 in sm.get_opcodes():
    if tag != 'equal':
        unaligned += (i2 - i1) + (j2 - j1)
        buckets[i1 // 100 * 100] += (i2 - i1) + (j2 - j1)
        continue
    for k in range(i2 - i1):
        i, j = i1 + k, j1 + k
        a = S.mask_reloc(A[i], K[i]) if K[i] else A[i]
        b = S.mask_reloc(B[j], K[i]) if K[i] else B[j]
        if a != b:
            tot += 1
            buckets[i // 100 * 100] += 1
print('%s  insns=%d  aligned-mismatch=%d  unaligned=%d  total=%d'
      % (cfg, len(A), tot, unaligned, tot + unaligned))
for b in sorted(buckets):
    print('  %5d-%5d : %d' % (b, b + 99, buckets[b]))
