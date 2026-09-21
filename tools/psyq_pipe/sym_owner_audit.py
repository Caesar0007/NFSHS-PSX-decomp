#!/usr/bin/env python3
"""sym_owner_audit.py -- is every global NAME filed under the right object?  checked against the retail SYM alone.

The linker lays each section out object by object in link order (the SYM FILE-record order), and the SYM lists the global
names with their addresses.  So inside one section, walking the names in ADDRESS order, the owning object's link index can
only stay or go UP.  Our tree says which object defines each name (the lane objects' XDEF records); wherever that owner
sequence steps BACKWARDS, a name is filed under the wrong object -- e.g. nullfunc.obj's 21 aliases end at asyncidle
0x800F6114 and the next name, SetShadeTex 0x800F611C, is libgpu P11.obj's, the next object in link order.
Prints every backward step per section, and for each suspect name the objects it could belong to instead.
usage: sym_owner_audit.py [section ...]"""
import json
import os
import re
import sys
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
sys.path.insert(0, str(ROOT / 'tools'))
import psyq_extract as X
OUT = ROOT / os.environ.get('NFS4_LANE_OUT', 'build/psyq_off')
T = Path(__import__('retail_sym').txt())
BS = chr(92)
RET = [('front.rdata', 0x80010000, 0x800128F0), ('front.text', 0x800128F0, 0x80051260), ('front.data', 0x80051260, 0x80052B38),
       ('front.bss', 0x80052B38, 0x80054548), ('.rdata', 0x80054548, 0x8005797C), ('.text', 0x8005797C, 0x8010CCD4),
       ('.data', 0x8010CCD4, 0x8013C54C), ('.sdata', 0x8013C54C, 0x8013DD7C), ('.sbss', 0x8013DD7C, 0x8013DEE0), ('.bss', 0x8013DEE0, 0x80148B04)]
only = [a for a in sys.argv[1:] if not a.startswith('--')]

# retail link order
order = []
for n, *_ in json.load(open(ROOT / 'tools/psyq_pipe/sym_obj_order.json')):
    k = n.split(BS)[-1]
    if k not in order:
        order.append(k)
pos = {k.lower(): i for i, k in enumerate(order)}
# our owner of each name: the lane script maps object file -> retail object; Sony members come from the LIB files
owner = {}
for m in re.finditer(r'^\s+include\s+(\S+)\s*;\s*(\S.*)$', (OUT / 'nfs4.lnk').read_text(encoding='latin-1'), re.M):
    fn, note = m.group(1), m.group(2).strip()
    if note.startswith('<') or fn.startswith('gap__') or 'syslib' in note:
        continue
    p = OUT / fn
    if not p.exists():
        continue
    for x in X.parse_obj(p.read_bytes())['xdefs']:
        owner.setdefault(x['name'].replace('___', '_._', 1) if x['name'].startswith('___') else x['name'], note.split(BS)[-1])
script = (OUT / 'off.lnk').read_text(encoding='latin-1')
for m in re.finditer(r'^\s+inclib\s+"([^"]+)"', script, re.M):
    raw = Path(m.group(1)).read_bytes()
    if raw[:4] != b'LIB' + bytes([1]):
        continue
    lib = Path(m.group(1)).stem.lower()
    for mem in X.lib_members(raw)[0]:
        tag = '%s.lib(%s.obj)' % (lib, mem['name'])
        if tag.lower() not in pos:
            continue                                  # a member retail did not link
        for x in X.parse_obj(mem['data'])['xdefs']:
            owner.setdefault(x['name'], tag)
# retail names with addresses
rec = []
for l in T.read_text(encoding='latin-1').splitlines():
    m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) 2 (\S+)$', l)
    if m:
        rec.append((int(m.group(1), 16), m.group(2)))
print('%d global names in the retail SYM, %d of them have an owner in our tree' % (len(rec), sum(1 for a, n in rec if n in owner)))
total = 0
for sec, lo, hi in RET:
    if only and sec not in only:
        continue
    rows = [(a, n, owner[n]) for a, n in rec if lo <= a < hi and n in owner and owner[n].lower() in pos]
    rows.sort(key=lambda r: r[0])                     # stable: names at one address keep the SYM order
    bad = []
    hi_idx, hi_name = -1, None
    for k, (a, n, o) in enumerate(rows):
        i = pos[o.lower()]
        if i < hi_idx:
            bad.append((a, n, o, hi_name))
        else:
            hi_idx, hi_name = i, o
    print('== %-11s %4d names, %d out of link order' % (sec, len(rows), len(bad)))
    total += len(bad)
    for a, n, o, prev in bad[:40]:
        print('   %08X %-34s filed under %-30s but it lies BEHIND names of %s' % (a, n[:34], o[:30], prev[:34]))
print('out of order in total: %d' % total)
