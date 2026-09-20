"""drift_vt.py -- PSYLINK lane: every `_vt.*` table of our SYM vs the retail SYM (plain `2` label records, which drift.py
does not read).  Prints, per read-only section, the base delta and every change point in table order."""
import re

OURS = 'C:/Temp/nfs4-decomp/scratchpad/psyq_pipe/nfs4_sym.txt'
RETAIL = __import__('retail_sym').txt()
pat = re.compile(r'^[0-9a-f]+: \$([0-9a-f]{8}) [126] (_vt\.\S+)$')


def load(p):
    d = {}
    for l in open(p, errors='replace'):
        m = pat.match(l)
        if m:
            d.setdefault(m.group(2), int(m.group(1), 16))
    return d


o, r = load(OURS), load(RETAIL)
print('tables: ours %d retail %d; only ours %s; only retail %s' % (len(o), len(r), sorted(set(o) - set(r))[:8], sorted(set(r) - set(o))[:8]))
for name, lo, hi in (('front.rdata', 0x80010000, 0x800128F0), ('.rdata', 0x80054548, 0x8005797C)):
    rows = sorted((a, n) for n, a in r.items() if lo <= a < hi and n in o)
    prev = None
    print('== %s: %d matched tables' % (name, len(rows)))
    for a, n in rows:
        d = o[n] - a
        if prev is None:
            print('   base delta %+#x' % d)
        elif d != prev:
            print('   drift %+#x -> %+#x (%+d) at %s @%#x' % (prev, d, d - prev, n, a))
        prev = d
