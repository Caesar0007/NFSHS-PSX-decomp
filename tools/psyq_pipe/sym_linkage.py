"""sym_linkage.py -- PSYLINK lane: label KIND (SN SYM record 1/2 = global, 6 = local) of every symbol, ours vs retail.
A mismatch means the source gives a function / object / vtable the wrong linkage (static vs extern, inline vs
out-of-line, key function vs all-inline class) although the bytes already match."""
import re
import sys
from collections import Counter

OURS = 'C:/Temp/nfs4-decomp/scratchpad/psyq_pipe/nfs4_sym.txt'
RETAIL = 'C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt'
pat = re.compile(r'^[0-9a-f]+: \$([0-9a-f]{8}) ([126]) (\S+)$')


def load(p):
    d = {}
    for l in open(p, errors='replace'):
        m = pat.match(l)
        if m:
            d.setdefault(m.group(3).replace('_._', '___'), (int(m.group(2)), int(m.group(1), 16)))
    return d


o, r = load(OURS), load(RETAIL)
print('labels: ours %d retail %d common %d' % (len(o), len(r), len(set(o) & set(r))))
print('kinds ours', Counter(k for k, _ in o.values()), 'retail', Counter(k for k, _ in r.values()))
mis = sorted((r[n][1], n, r[n][0], o[n][0]) for n in set(o) & set(r) if (r[n][0] == 6) != (o[n][0] == 6))
print('linkage mismatches', len(mis))
for a, n, kr, ko in mis[:int(sys.argv[1]) if len(sys.argv) > 1 else 60]:
    print('   %08x retail %d ours %d  %s' % (a, kr, ko, n[:90]))
only_r = sorted((a, n, k) for n, (k, a) in r.items() if n not in o)
only_o = sorted((a, n, k) for n, (k, a) in o.items() if n not in r)
print('only retail', len(only_r), 'only ours', len(only_o))
if '--only' in sys.argv:
    for a, n, k in only_r[:80]:
        print('   R %08x %d %s' % (a, k, n[:90]))
    for a, n, k in only_o[:80]:
        print('   O %08x %d %s' % (a, k, n[:90]))
