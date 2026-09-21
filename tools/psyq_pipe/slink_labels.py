#!/usr/bin/env python3
"""slink_labels.py LO HI [variant] -- retail MAP labels in [LO, HI) with the distance to the next label, next to the same
names in a slink_lane.py variant.  A variable that is too small / missing / in another section shows as a changed gap."""
import os
import re
import sys
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
OUT = ROOT / os.environ.get('NFS4_LANE_OUT', 'build/psyq_off')
lo, hi = int(sys.argv[1], 16), int(sys.argv[2], 16)
variant = sys.argv[3] if len(sys.argv) > 3 else 'off'


def names(path):
    out = {}
    for m in re.finditer(r'^ ([0-9A-F]{8})  ?(\S+)\s*$', Path(path).read_text(encoding='latin-1'), re.M):
        out.setdefault(m.group(2), int(m.group(1), 16))
    return out


r, o = names('C:/Temp/nfs4iso/NFS4.MAP'), names(OUT / (variant + '.map'))
rows = sorted((a, n) for n, a in r.items() if lo <= a < hi and not n.startswith('_') or (lo <= a < hi and n in o))
rows = sorted(set(rows))
oa = sorted(set(o.values()))
import bisect
for i, (a, n) in enumerate(rows):
    nxt = rows[i + 1][0] if i + 1 < len(rows) else hi
    if n in o:
        j = bisect.bisect_right(oa, o[n])
        og = (oa[j] - o[n]) if j < len(oa) else 0
        print('%08X %-28s gap %4d | ours %08X gap %4d %s' % (a, n[:28], nxt - a, o[n], og, '' if og == nxt - a else '<<'))
    else:
        print('%08X %-28s gap %4d | ours -' % (a, n[:28], nxt - a))
