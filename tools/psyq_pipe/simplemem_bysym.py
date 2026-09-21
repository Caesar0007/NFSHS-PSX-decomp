#!/usr/bin/env python3
"""simplemem_bysym.py -- own the "SimpleMem" head tags by EVIDENCE: the retail SYM says which objects saw the header.

Rule (measured, tools/psyq_pipe/sym_tag_header.py): an object's read-only data opens with the unreferenced literal
"SimpleMem" iff its compilation saw the track / Group header family (type `Trk_NewSimQuad` in the object's SYM type
block) or the SimpleMem class itself (`SimpleMem`).  The linker lays read-only data out object by object in link order,
so the k-th head tag of a section belongs to the k-th such object -- no guessing by neighbourhood.
Supersedes the link-order heuristic of simplemem_apply.py.   usage: simplemem_bysym.py [--apply]"""
import json
import re
import sys
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
sys.path.insert(0, str(ROOT / 'tools'))
APPLY = '--apply' in sys.argv
T = Path(__import__('retail_sym').txt())
TAG = b'SimpleMem' + bytes(1)
BLOCK = ['/* retail: this object\'s read-only data opens with the unreferenced "SimpleMem" tag (0x%08X).  The retail SYM shows the',
         ' * object saw the track / Group header family, whose unused inline leaves the literal behind in every such object',
         ' * (tools/psyq_pipe/simplemem_bysym.py). */',
         'static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }']
rom = (ROOT / 'rom/nfs4-f.exe').read_bytes()
rd = lambda a, n: rom[0x800 + a - 0x80010000:0x800 + a - 0x80010000 + n]

# 1. objects in link order with the SYM verdict
lines = T.read_text(encoding='latin-1').splitlines()
verdict, order = {}, []
cur = None
for l in lines:
    m = re.search(r'Def class FILE type NULL size 0 name (\S+)$', l)
    if m:
        k = m.group(1)
        if cur == k:
            cur = None
        else:
            cur = k
            if k not in verdict:
                verdict[k] = False; order.append(k)
        continue
    if cur and re.search(r'class (STRTAG|TPDEF) .* name (Trk_NewSimQuad|SimpleMem)$', l):
        verdict[cur] = True
# 2. our TU for each retail object (the lane script's comments)
tu = {}
for m in re.finditer(r'^\s+include\s+(recon__\S+)\s*;\s*(\S.*)$', (ROOT / 'build/psyq_off/nfs4.lnk').read_text(encoding='latin-1'), re.M):
    if not m.group(2).startswith('<'):
        tu[m.group(2).strip()] = 'build/' + m.group(1)[:-4].replace('__', '/') + '.o'
# the front-end overlay objects are one contiguous run of the link order (MinFront.obj .. video.obj), wherever their sources live
FLO, FHI = order.index('MinFront.obj'), order.index('video.obj')
front = lambda o: FLO <= order.index(o) <= FHI
# 3. head tags per section = a tag that is not a referenced string of some object: all aligned literals, in address order
def tags(lo, hi):
    blob = rd(lo, hi - lo); out = []
    i = blob.find(TAG)
    while i >= 0:
        if i % 4 == 0:
            out.append(lo + i)
        i = blob.find(TAG, i + 1)
    return out


plan = []
for name, lo, hi, sel in (('front.rdata', 0x80010000, 0x800128F0, True), ('.rdata', 0x80054548, 0x8005797C, False)):
    objs = [o for o in order if verdict[o] and o in tu and front(o) == sel]
    t = tags(lo, hi)
    print('%-12s %3d tags in retail, %3d objects saw the header' % (name, len(t), len(objs)))
    if len(t) != len(objs):
        print('   !! counts differ -- not a 1:1 map; listing both')
        for i in range(max(len(t), len(objs))):
            print('      %s  %s' % ('%08X' % t[i] if i < len(t) else '-', objs[i] if i < len(objs) else '-'))
        continue
    plan += list(zip(t, objs))
want = {tu[o]: a for a, o in plan}
PL = ROOT / 'linkers/nfs4_recon.rodata_placement.json'
EX = ROOT / 'linkers/nfs4_recon.rodata_extra.json'
placement, extra = json.load(open(PL)), json.load(open(EX))


def has_tag(obj):
    s = ROOT / (obj[:-2] + '.s')
    return s.exists() and b'.ascii\t"SimpleMem' in s.read_bytes()


add = [(o, a) for o, a in want.items() if not has_tag(o)]
allobjs = {'build/' + str(p.relative_to(ROOT).as_posix()) + '.o' for p in (ROOT / 'recon/game').rglob('*.cpp')} | \
          {'build/' + str(p.relative_to(ROOT).as_posix()) + '.o' for p in (ROOT / 'recon/frontend').rglob('*.cpp')}
drop = sorted(o for o in allobjs if o not in want and has_tag(o))
print('tag to ADD   : %d  %s' % (len(add), ' '.join(Path(o).name[:-6] for o, _ in add)))
print('tag to REMOVE: %d  %s' % (len(drop), ' '.join(Path(o).name[:-6] for o in drop)))
if not APPLY:
    sys.exit(0)
for o, a in add:
    src = ROOT / o[len('build/'):-2]
    L = src.read_text(encoding='utf-8', errors='surrogateescape').split('\n')
    last = max((i for i, l in enumerate(L[:120]) if l.lstrip().startswith('#include')), default=-1)
    L[last + 1:last + 1] = [''] + [b % a if '%08X' in b else b for b in BLOCK]
    src.write_text('\n'.join(L), encoding='utf-8', errors='surrogateescape', newline='')
manual = []
for o in drop:
    src = ROOT / o[len('build/'):-2]
    L = src.read_text(encoding='utf-8', errors='surrogateescape').split('\n')
    idx = [i for i, l in enumerate(L) if l.startswith('static inline const char *SimpleMem_ClassName(void)')]
    if not idx:
        manual.append(o); continue
    i = idx[0]
    j = i
    while j > 0 and (L[j - 1].startswith('/* retail:') or L[j - 1].startswith(' *')):
        j -= 1
    if j > 0 and L[j - 1].strip() == '':
        j -= 1
    del L[j:i + 1]
    src.write_text('\n'.join(L), encoding='utf-8', errors='surrogateescape', newline='')
# placement rows: an owner's row starts AT its tag; a non-owner's row must not
def fix(rows):
    out = []
    for r in rows:
        o = r['obj']
        if r['base'] >= 0x80060000:
            out.append(r); continue
        starts_tag = rd(r['base'], 10) == TAG
        if o in want:
            a = want[o]
            if r['base'] != a and starts_tag and r['size'] <= 12:
                r['base'] = a                             # a tag-only row the old heuristic put on a neighbour's tag
            elif r['base'] != a and r['base'] - a in (12, 16):
                r['size'] += r['base'] - a; r['base'] = a
        elif starts_tag:
            if r['size'] <= 12:
                continue                                  # the row was only the tag
            step = 16 if rd(r['base'] + 12, 4) == bytes(4) and r['base'] < 0x80054548 else 12
            r['base'] += step; r['size'] -= step
        r['end'] = r['base'] + r['size']
        out.append(r)
    return out


placement, extra = fix(placement), fix(extra)
have = {r['obj'] for r in placement + extra if r['base'] < 0x80060000}
for o, a in want.items():
    if o not in have:
        placement.append({'obj': o, 'base': a, 'end': a + 10, 'size': 10, 'ok': True, 'regions': []})
placement.sort(key=lambda r: r['base'])
PL.write_text(json.dumps(placement, indent=1) + '\n')
EX.write_text(json.dumps(extra, indent=1) + '\n')
print('applied.  carriers to remove BY HAND (older `if (0)` spelling):', ' '.join(manual) or '-')
