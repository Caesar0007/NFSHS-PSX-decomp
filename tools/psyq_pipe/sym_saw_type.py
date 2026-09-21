#!/usr/bin/env python3
"""sym_saw_type.py TYPE [--tags] -- which retail OBJECTS saw a given type?  straight from the retail SYM.

The SN SYM keeps, per object, the block of type definitions that object's compilation emitted (between its two
`Def class FILE ... name X.obj` records).  A class / struct / typedef is in that block iff the translation unit saw its
declaration -- i.e. included the header.  Prints the objects in link order with yes / no.
--tags: for TYPE = SimpleMem, also show whether OUR object emits the "SimpleMem" literal (build/**.s), to check the tag
owners against this evidence."""
import re
import sys
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
sys.path.insert(0, str(ROOT / 'tools'))
T = Path(__import__('retail_sym').txt())
typ = sys.argv[1]
lines = T.read_text(encoding='latin-1').splitlines()
blocks = []          # (object, first line, last line)
cur = None
for i, l in enumerate(lines):
    m = re.search(r'Def class FILE type NULL size 0 name (\S+)$', l)
    if m:
        if cur and cur[0] == m.group(1):
            blocks.append((cur[0], cur[1], i)); cur = None
        else:
            cur = (m.group(1), i)
pat = re.compile(r'(class STRTAG|class TPDEF|class UNTAG|class ENTAG).* name %s$' % re.escape(typ))
tagpat = re.compile(r' tag %s ' % re.escape(typ))
ours = {}
if '--tags' in sys.argv:
    for p in (ROOT / 'build/recon').rglob('*.s'):
        if not re.match(r'^[^.]+[.](c|cpp)[.]s$', p.name) or '__' in p.name:
            continue          # scratch outputs of earlier experiments
        ours[p.name.split('.')[0].lower()] = b'.ascii\t"SimpleMem\\000"' in p.read_bytes()
saw = 0
for obj, a, b in blocks:
    body = lines[a:b]
    yes = any(pat.search(x) or tagpat.search(x) for x in body)
    saw += yes
    key = re.sub(r'^.*\(|\)$', '', obj).rsplit('.', 1)[0].lower()
    extra = ''
    if ours:
        o = ours.get(key)
        extra = '' if o is None else ('ours: tag' if o else 'ours: no tag')
        if o is not None and o != yes:
            extra += '   <<'
    print('%-5s %-44s %5d type records  %s' % ('YES' if yes else 'no', obj[-44:], b - a, extra))
print('%d of %d objects saw %s' % (saw, len(blocks), typ))
