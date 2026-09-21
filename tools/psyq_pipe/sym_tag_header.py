#!/usr/bin/env python3
"""sym_tag_header.py -- which HEADER leaves the "SimpleMem" literal behind?  evidence from the retail SYM + image only.

SOLID owners     = objects whose placed read-only data in retail STARTS with the literal "SimpleMem".
SOLID non-owners = objects whose placed read-only data starts with something else.
(placement rows: linkers/nfs4_recon.rodata_placement.json / rodata_extra.json -- bases are retail addresses.)
For every type name in the retail SYM's per-object type blocks: how many solid owners saw it, how many solid non-owners.
A type seen by ALL owners and NO non-owner belongs to the header that carries the literal."""
import json
import re
import sys
from collections import Counter
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
sys.path.insert(0, str(ROOT / 'tools'))
T = Path(__import__('retail_sym').txt())
rom = (ROOT / 'rom/nfs4-f.exe').read_bytes()
rd = lambda a, n: rom[0x800 + a - 0x80010000:0x800 + a - 0x80010000 + n]
rows = json.load(open(ROOT / 'linkers/nfs4_recon.rodata_placement.json')) + json.load(open(ROOT / 'linkers/nfs4_recon.rodata_extra.json'))
first = {}
for r in rows:
    if r['base'] < 0x80060000:
        k = Path(r['obj']).name.split('.')[0].lower()
        if k not in first or r['base'] < first[k]:
            first[k] = r['base']
owners = {k for k, a in first.items() if rd(a, 10) == b'SimpleMem' + bytes(1)}
non = set(first) - owners
lines = T.read_text(encoding='latin-1').splitlines()
types = {}
cur = None
for i, l in enumerate(lines):
    m = re.search(r'Def class FILE type NULL size 0 name (\S+)$', l)
    if m:
        k = re.sub(r'^.*\(|\)$', '', m.group(1)).rsplit('.', 1)[0].lower()
        cur = None if cur == k else k
        if cur:
            types.setdefault(cur, set())
        continue
    if cur:
        m = re.search(r'class (?:STRTAG|TPDEF|UNTAG|ENTAG) .* name (\S+)$', l)
        if m and not m.group(1).startswith('.'):
            types[cur].add(m.group(1))
owners &= set(types); non &= set(types)
print('solid owners %d, solid non-owners %d' % (len(owners), len(non)))
print('non-owners:', ' '.join(sorted(non)))
cnt_o = Counter(t for o in owners for t in types[o])
cnt_n = Counter(t for o in non for t in types[o])
cand = sorted(((cnt_o[t], -cnt_n[t], t) for t in cnt_o), reverse=True)
print('types by (owners that saw it, non-owners that saw it):')
for c, n, t in cand[:400]:
    if -n <= 2 and c >= len(owners) - 3:
        print('   %3d / %-3d  %s' % (c, -n, t))
