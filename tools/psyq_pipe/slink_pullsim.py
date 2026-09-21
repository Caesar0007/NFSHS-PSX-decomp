#!/usr/bin/env python3
"""slink_pullsim.py -- WHY does a library member enter the link where it does?  a model of slink's on-demand pull.

Reads the variant's script (includes + inclibs), every object's XDEF / XBSS / XREF records (XREFs in record order) and
the libraries' members.  Model: unresolved names are served in the order they are first met -- objects in script order,
inside an object the XREF record order; a name nobody defines yet pulls the first library (script order) member that
XDEFs it, and that member's own XREFs join the END of the queue.
Reports (1) how well the model reproduces OUR slink order (read from the variant's map), so the model can be trusted,
(2) every member retail has EARLIER than we do, with the name that pulls it in our link, who asks for it, and the retail
objects that sit around its retail position: the member was asked for by something retail linked before that point.
usage: slink_pullsim.py [variant]"""
import os
import re
import sys
from collections import OrderedDict
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
sys.path.insert(0, str(ROOT / 'tools'))
import psyq_extract as X
OUT = ROOT / os.environ.get('NFS4_LANE_OUT', 'build/psyq_off')
variant = sys.argv[1] if len(sys.argv) > 1 else 'off'
BS = chr(92)


def parse(data):
    try:
        o = X.parse_obj(data)
    except Exception:
        try:
            o = X.parse_obj(data, alt_debug=True)
        except Exception:
            return None
    return [x['name'] for x in o['xdefs']], list(o['xrefs'])


script = (OUT / (variant + '.lnk')).read_text(encoding='latin-1')
objs, libs = [], []
for m in re.finditer(r'^\s+(include|inclib)\s+"?([^",\r\n\t;]+)"?', script, re.M):
    (objs if m.group(1) == 'include' else libs).append(m.group(2).strip())
defined = {}
queue = OrderedDict()          # name -> who asked first
bad = []
for f in objs:
    p = Path(f) if ':' in f else OUT / f
    r = parse(p.read_bytes())
    if r is None:
        bad.append(p.name); continue
    for n in r[0]:
        defined.setdefault(n, p.name)
    for n in r[1]:
        queue.setdefault(n, p.name)
for m in re.finditer(r'^(\S+)\s+equ\s', script, re.M):
    defined.setdefault(m.group(1), '<equ>')
index = []                      # (lib, member, xdefs, xrefs)
byname = {}
for lf in libs:
    lib = Path(lf).stem.lower()
    raw = Path(lf).read_bytes()
    if raw[:4] == b'LIB' + bytes([1]):                       # Sony's libraries
        members = [(m['name'], m['data']) for m in X.lib_members(raw)[0]]
    else:                                                    # ours are PSYLIB2's newer LIB 2 format: read the member objects it was made from
        members = [(f.stem, f.read_bytes()) for f in sorted((OUT / 'ealib' / lib).glob('*.obj'))]
    for name, blob in members:
        r = parse(blob)
        if r is None:
            bad.append('%s(%s)' % (lib, name)); continue
        index.append((lib, name, r[0], r[1]))
        for n in r[0]:
            byname.setdefault(n, len(index) - 1)
pulled, why = [], {}
names = list(queue.items())
i = 0
loaded = set()
while i < len(names):
    n, asker = names[i]; i += 1
    if n in defined or n not in byname:
        continue
    k = byname[n]
    if k in loaded:
        continue
    loaded.add(k)
    lib, mem, xd, xr = index[k]
    tag = '%s.lib(%s.obj)' % (lib, mem.lower())
    pulled.append(tag); why[tag] = (n, asker)
    for d in xd:
        defined.setdefault(d, tag)
    for r in xr:
        if r not in queue:
            queue[r] = tag; names.append((r, tag))
print('objects %d, library members indexed %d, unparsed %d %s' % (len(objs), len(index), len(bad), bad[:6]))
print('model pulls %d members' % len(pulled))

# retail order of library members (SYM FILE records)
import json
order = json.load(open(ROOT / 'tools/psyq_pipe/sym_obj_order.json'))
retail = []
for n, *_ in order:
    m = re.search(r'(\w+)\.lib\((\w+)\.obj\)', n)
    if m:
        t = '%s.lib(%s.obj)' % (m.group(1).lower(), m.group(2).lower())
        if t not in retail:
            retail.append(t)
rpos = {t: i for i, t in enumerate(retail)}
mpos = {t: i for i, t in enumerate(pulled)}
both = [t for t in retail if t in mpos]
print('retail pulls %d members; %d in both; only retail: %s' % (len(retail), len(both), ' '.join(t for t in retail if t not in mpos)[:300]))
print('only model: %s' % ' '.join(t for t in pulled if t not in rpos)[:300])
import difflib
ms = [t for t in pulled if t in rpos]
sm = difflib.SequenceMatcher(None, both, ms, autojunk=False)
moved = [t for tag, i1, i2, j1, j2 in sm.get_opcodes() if tag in ('delete', 'replace') for t in both[i1:i2]]
print('model order == retail order for %d of %d shared members; %d sit elsewhere:' % (len(both) - len(moved), len(both), len(moved)))
xd = {'%s.lib(%s.obj)' % (l, m.lower()): x for l, m, x, _ in index}
for t in moved:
    n, asker = why[t]
    i = rpos[t]
    print('  %s   retail #%d, model #%d (pulled there by `%s`, asked by %s)' % (t, i, mpos[t], n, asker[-44:]))
    for k in (i - 1, i + 1):
        if 0 <= k < len(retail) and retail[k] in why:
            print('       retail neighbour #%d %-28s <- `%s` asked by %s' % (k, retail[k], why[retail[k]][0], why[retail[k]][1][-44:]))
    print('       it defines: %s' % ' '.join(xd.get(t, []))[:200])
