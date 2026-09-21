#!/usr/bin/env python3
"""slink_delta.py -- WHERE does a slink_lane.py variant's layout drift from retail?

Every name both maps share gives (our address - retail address).  Walking the names in retail address order, inside one
section, the difference stays constant while the layout agrees and steps where something is bigger / smaller / missing /
moved.  Each step is printed with the retail object it happens in (per-object ranges from the honest GNU link map).
Steps that cancel out again within a few names (an object that merely sits elsewhere) are folded with --fold.
usage: slink_delta.py [variant] [section ...]"""
import os
import re
import sys
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
OUT = ROOT / os.environ.get('NFS4_LANE_OUT', 'build/psyq_off')
args = [a for a in sys.argv[1:] if not a.startswith('--')]
variant = args[0] if args else 'off'
only = args[1:]
RET = [('front.rdata', 0x80010000, 0x800128F0), ('front.text', 0x800128F0, 0x80051260), ('front.data', 0x80051260, 0x80052B38),
       ('front.bss', 0x80052B38, 0x80054548), ('.rdata', 0x80054548, 0x8005797C), ('.text', 0x8005797C, 0x8010CCD4),
       ('.data', 0x8010CCD4, 0x8013C54C), ('.sdata', 0x8013C54C, 0x8013DD7C), ('.sbss', 0x8013DD7C, 0x8013DEE0), ('.bss', 0x8013DEE0, 0x80148B04)]
MAPLINE_RE = re.compile(r'^ (\.\S+)\s+0x([0-9a-f]+)\s+0x([0-9a-f]+)\s+(\S+\.o)$', re.M)
label = {}
for m in re.finditer(r'^\s+include\s+(\S+)\s*;\s*(.*)$', (OUT / 'nfs4.lnk').read_text(encoding='latin-1'), re.M):
    label[m.group(1)] = m.group(1) if m.group(2).startswith('<') else m.group(2).strip()
ranges = []
for m in MAPLINE_RE.finditer((ROOT / 'build/gen_ld/recon_multdef-ok.map').read_text(errors='replace')):
    va, sz = int(m.group(2), 16), int(m.group(3), 16)
    if sz:
        fn = m.group(4).replace(chr(92), '/').split('build/', 1)[-1][:-2].replace('/', '__') + '.obj'
        ranges.append((va, va + sz, re.sub(r'^.*\\', '', label.get(fn, fn))))
ranges.sort()


def owner(a):
    for lo, hi, n in ranges:
        if lo <= a < hi:
            return n
    return '?'


def names(path):
    out = {}
    for m in re.finditer(r'^ ([0-9A-F]{8})  ?(\S+)\s*$', Path(path).read_text(encoding='latin-1'), re.M):
        out.setdefault(m.group(2).replace('_._', '___'), int(m.group(1), 16))
    return out


ret = names('C:/Temp/nfs4iso/NFS4.MAP')
our = names(OUT / (variant + '.map'))
mp = (OUT / (variant + '.map')).read_text(encoding='latin-1')
ourstart = {m.group(3): int(m.group(1), 16) for m in re.finditer(r'^ ([0-9A-F]{8}) [0-9A-F]{8} ([0-9A-F]{8}) [0-9A-F]{8} \S+\s+(\S+)\s*$', mp, re.M)}
for sec, lo, hi in RET:
    if only and sec not in only:
        continue
    rows = sorted((a, n) for n, a in ret.items() if lo <= a < hi and n in our and not n.startswith('__') and not re.match(r'^_\w+_(obj|org|size|objend|orgend)$', n))
    base = ourstart.get(sec, 0) - lo
    print('== %s  (%d shared names; our section starts %+d from retail)' % (sec, len(rows), base))
    prev = 0
    steps = []
    for a, n in rows:
        d = our[n] - a - base
        if d != prev:
            steps.append((a, n, d - prev, d))
            prev = d
    for a, n, step, d in steps[:60]:
        print('   %08X %+6d (running %+6d)  %-30s %s' % (a, step, d, owner(a)[:30], n[:50]))
    if len(steps) > 60:
        print('   ... %d more steps' % (len(steps) - 60))
