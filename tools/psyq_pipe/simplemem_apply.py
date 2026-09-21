#!/usr/bin/env python3
"""simplemem_apply.py -- give every unowned retail "SimpleMem" tag an owning translation unit.

Retail's read-only data has the unreferenced 12-byte literal "SimpleMem" at the HEAD of an object's .rdata wherever the
object saw the SimpleMem class header (an unused inline there leaves the string behind in every such TU -- with or
without functions).  52 of the 118 tags had no owner in our sources; Route A covered them with retail filler bytes and
Route C (slink) came out exactly that much short.

Owner rule (the linker lays .rdata out object by object in link order):
  * ANCHORED tag  = our object's placed .rodata starts right behind it (12, or 16 in the 8-aligned overlay): that object.
  * UNANCHORED tag(s) in front of an anchored one = the nearest preceding objects in link order that have no read-only
    data of their own and no tag yet (mostly the function-less objects).  When the window holds more such objects than
    tags the choice is byte-neutral; the nearest ones are taken and the alternatives are printed.
For each owner: add the unused inline at the top of the source (same spelling the four existing carriers use) and move /
add its row in linkers/nfs4_recon.rodata_placement.json.
usage: simplemem_apply.py [--apply]"""
import json
import re
import sys
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
BS = chr(92)
APPLY = '--apply' in sys.argv
TAG = b'SimpleMem' + bytes(1)
LINE = ('/* retail: this object\'s read-only data opens with the unreferenced "SimpleMem" tag (0x%08X): the unused inline of the\n'
        ' * SimpleMem class header leaves it behind in every object that saw the header (tools/psyq_pipe/simplemem_apply.py). */\n'
        'static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }\n')
PL = ROOT / 'linkers/nfs4_recon.rodata_placement.json'
placement = json.load(open(PL))
extra = json.load(open(ROOT / 'linkers/nfs4_recon.rodata_extra.json'))
rows = placement + extra
bybase = {}
for r in rows:
    bybase.setdefault(r['base'], []).append(r)
hasrow = {r['obj'] for r in rows}
rom = (ROOT / 'rom/nfs4-f.exe').read_bytes()
order = []
for m in re.finditer(r'^\s+include\s+(\S+)\s*;\s*(.*)$', (ROOT / 'build/psyq_off/nfs4.lnk').read_text(encoding='latin-1'), re.M):
    fn = m.group(1)
    if fn.startswith('recon__'):
        order.append('build/' + fn[:-4].replace('__', '/') + '.o')
pos = {o: i for i, o in enumerate(order)}


def src_of(obj):
    return ROOT / obj[len('build/'):-2]


def has_tag(obj):
    s = ROOT / (obj[:-2] + '.s')
    return s.exists() and b'SimpleMem' in s.read_bytes()


tags = []
for lo, hi in ((0x80010000, 0x800128F0), (0x80054548, 0x8005797C)):
    blob = rom[0x800 + lo - 0x80010000:0x800 + hi - 0x80010000]
    i = blob.find(TAG)
    while i >= 0:
        if i % 4 == 0 and not [r for r in rows if r['base'] <= lo + i and lo + i + 10 <= r['base'] + r['size']]:
            tags.append(lo + i)
        i = blob.find(TAG, i + 1)
plan = []          # (tag address, object, anchored row or None)
pending = []
for a in tags:
    nxt = [r for d in (12, 16) for r in bybase.get(a + d, [])]
    if not nxt:
        pending.append(a)
        continue
    row = nxt[0]
    anchor = row['obj']
    own = not has_tag(anchor)
    if not own:
        pending.append(a)          # the object behind it opens with its OWN tag: this one belongs to an object in front of it
    # unanchored tags in front of it: nearest preceding objects without rodata and without a tag
    j = pos.get(anchor)
    cands = []
    k = (j or 0) - 1
    while k >= 0 and order[k] not in hasrow:
        if not has_tag(order[k]) and src_of(order[k]).exists():
            cands.append(order[k])
        k -= 1
    if len(cands) < len(pending):
        print('!! %08X: %d unanchored tags but only %d candidate objects (%s)' % (a, len(pending), len(cands), cands))
    take = cands[:len(pending)][::-1]
    if len(cands) > len(pending) and pending:
        print('   note: %d tag(s) before %s, %d possible owners: %s -> taking %s' % (len(pending), Path(anchor).name, len(cands),
              ' '.join(Path(c).name[:-2] for c in cands[::-1]), ' '.join(Path(c).name[:-2] for c in take)))
    for t, o in zip(pending[-len(take):] if take else [], take):
        plan.append((t, o, None))
    if own:
        plan.append((a, anchor, row))
    pending = []
print('%d unowned tags -> %d owners planned' % (len(tags), len(plan)))
for a, o, row in plan:
    print('   %08X  %-52s %s' % (a, o[len('build/recon/'):-2], 'anchored (row base %08X -> %08X)' % (row['base'], a) if row else 'no other read-only data: new row'))
if not APPLY:
    sys.exit(0)
for a, o, row in plan:
    src = src_of(o)
    text = src.read_text(encoding='utf-8', errors='surrogateescape')
    if 'SimpleMem_ClassName' in text:
        continue
    lines = text.split('\n')
    last = max((i for i, l in enumerate(lines[:120]) if l.lstrip().startswith('#include')), default=-1)
    # stay outside any preprocessor conditional that wraps the include block
    ins = last + 1
    lines[ins:ins] = ['', *(LINE % a).rstrip('\n').split('\n')]
    src.write_text('\n'.join(lines), encoding='utf-8', errors='surrogateescape', newline='')
    if row is not None:
        for r in placement:
            if r is row:
                r['size'] += r['base'] - a; r['base'] = a
        for r in extra:
            if r is row:
                r['size'] += r['base'] - a; r['base'] = a
                if 'words' in r:
                    r['words'] = (r['size'] + 3) // 4
    else:
        placement.append({'obj': o, 'base': a, 'end': a + 12, 'size': 12, 'ok': True, 'regions': []})
placement.sort(key=lambda r: r['base'])
PL.write_text(json.dumps(placement, indent=1) + '\n')
(ROOT / 'linkers/nfs4_recon.rodata_extra.json').write_text(json.dumps(extra, indent=1) + '\n')
print('applied: rebuild the listed files, then gen_ld --link, honest_measure, full_link')
