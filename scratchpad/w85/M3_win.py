"""M3_win.py OURSTREAM oursStart oursEnd oracleStart oracleEnd — side-by-side raw window."""
import sys
sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/w84')
from R02_norm import load
ours = [l for l in open(sys.argv[1]).read().splitlines() if l.strip()]
orc = load('C:/Temp/nfs4-decomp/regiondiff/oracles/NFS4-R-JPN/__15tGlobalMenuDefs.s')
a, b, c, d = (int(x) for x in sys.argv[2:6])
A = ours[a:b]; B = orc[c:d]
for i in range(max(len(A), len(B))):
    l = A[i] if i < len(A) else ''
    r = B[i] if i < len(B) else ''
    print('%5d %-34s | %5d %s' % (a + i, l, c + i, r))
