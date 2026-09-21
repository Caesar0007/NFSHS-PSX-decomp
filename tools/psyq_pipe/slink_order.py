#!/usr/bin/env python3
"""slink_order.py -- in what ORDER did the linker pull the library members?  retail vs a slink_lane.py variant.

Retail: the objects in .text address order (per-object ranges from the honest GNU link map, which is retail-identical).
Ours  : every .text name in the variant's map is assigned to the retail object whose .text range holds that name in the
        retail MAP; our objects are then ordered by the lowest address any of their names got.
usage: slink_order.py [variant]"""
import json
import os
import re
import sys
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
OUT = ROOT / os.environ.get('NFS4_LANE_OUT', 'build/psyq_off')
variant = sys.argv[1] if len(sys.argv) > 1 else 'off'
MAPLINE_RE = re.compile(r'^ (\.\S+)\s+0x([0-9a-f]+)\s+0x([0-9a-f]+)\s+(\S+\.o)$', re.M)
label = {}                       # lane object file -> retail object name (the lane script's comments)
for m in re.finditer(r'^\s+include\s+(\S+)\s*;\s*(.*)$', (OUT / 'nfs4.lnk').read_text(encoding='latin-1'), re.M):
    label[m.group(1)] = m.group(1) if m.group(2).startswith('<') else m.group(2).strip()
ranges = []                      # retail .text ranges per object, from the honest (= retail-identical) GNU link map
for m in MAPLINE_RE.finditer((ROOT / 'build/gen_ld/recon_multdef-ok.map').read_text(errors='replace')):
    va, sz = int(m.group(2), 16), int(m.group(3), 16)
    if sz and m.group(1).startswith('.text') and 0x80010000 <= va < 0x8010CCD4:
        fn = m.group(4).replace(chr(92), '/').split('build/', 1)[-1][:-2].replace('/', '__') + '.obj'
        ranges.append((va, va + sz, label.get(fn, fn)))
ranges.sort()
retail_objs = []
for lo, hi, name in ranges:
    if name not in retail_objs:
        retail_objs.append(name)


def names(path):
    out = {}
    for m in re.finditer(r'^ ([0-9A-F]{8})  ?(\S+)\s*$', Path(path).read_text(encoding='latin-1'), re.M):
        out.setdefault(m.group(2).replace('_._', '___'), int(m.group(1), 16))
    return out


ret = names('C:/Temp/nfs4iso/NFS4.MAP')
our = names(OUT / (variant + '.map'))
owner = {}
for n, a in ret.items():
    for lo, hi, obj in ranges:
        if lo <= a < hi:
            owner[n] = obj
            break
first = {}
for n, a in our.items():
    o = owner.get(n)
    if o is not None and (o not in first or a < first[o]):
        first[o] = a
ours_seq = [o for o, _ in sorted(first.items(), key=lambda kv: kv[1])]
ret_seq = [o for o in retail_objs if o in first]
short = lambda o: re.sub(r'^.*\\', '', o)
import difflib
print('%d objects with code in both' % len(ret_seq))
eq = 0
for tag, i1, i2, j1, j2 in difflib.SequenceMatcher(None, ret_seq, ours_seq, autojunk=False).get_opcodes():
    if tag == 'equal':
        eq += i2 - i1
        continue
    print('  retail #%d..%d: %-60s | ours #%d..%d: %s' % (i1, i2, ' '.join(short(o) for o in ret_seq[i1:i2])[:60], j1, j2, ' '.join(short(o) for o in ours_seq[j1:j2])[:80]))
print('in the same relative order: %d of %d' % (eq, len(ret_seq)))
