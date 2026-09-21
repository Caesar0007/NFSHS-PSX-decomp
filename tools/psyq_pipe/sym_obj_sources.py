#!/usr/bin/env python3
"""sym_obj_sources.py -- which SOURCE FILES went into each retail object?  from the retail SYM's line records.

Every `Set SLD to line N of file F` record lies inside the FILE block of the object whose compilation produced it.  An
object normally shows its own source (+ headers with inline code).  An object that shows ANOTHER .C / .CPP / .ASM file
had that file #included (SPCHEVNT.C inside Speech.obj), and a source file that shows up in no object of its own name is
not a translation unit.  Prints every object with more than one non-header source, and checks our tree: a recon source
whose retail file appears only inside another object must not be built as its own TU.
usage: sym_obj_sources.py [--all]"""
import re
import sys
from collections import OrderedDict
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
sys.path.insert(0, str(ROOT / 'tools'))
T = Path(__import__('retail_sym').txt())
BS = chr(92)
blocks = OrderedDict()
cur = None
for l in T.read_text(encoding='latin-1').splitlines():
    m = re.search(r'Def class FILE type NULL size 0 name (\S+)$', l)
    if m:
        k = m.group(1)
        cur = None if cur == k else k
        if cur:
            blocks.setdefault(cur, OrderedDict())
        continue
    if cur:
        m = re.search(r'Set SLD to line \d+ of file (\S.*)$', l)
        if m:
            f = m.group(1).strip()
            blocks[cur][f] = blocks[cur].get(f, 0) + 1
is_hdr = lambda f: f.lower().endswith(('.h', '.hpp', '.inl', '.inc'))
stem = lambda f: f.split(BS)[-1].rsplit('.', 1)[0].lower()
own = {}                      # source file -> objects that contain it
for obj, files in blocks.items():
    for f in files:
        if not is_hdr(f):
            own.setdefault(f, []).append(obj)
n = 0
for obj, files in blocks.items():
    srcs = [f for f in files if not is_hdr(f)]
    hdrs = [f for f in files if is_hdr(f)]
    o = stem(obj.split('(')[-1].rstrip(')'))
    foreign = [f for f in srcs if stem(f) != o]
    if foreign or '--all' in sys.argv:
        n += 1
        print('%-28s own: %-30s OTHER SOURCES: %s%s' % (obj[-28:], ' '.join(f.split(BS)[-1] for f in srcs if stem(f) == o)[:30],
              ' '.join(f.split(BS)[-1] for f in foreign) or '-', ('   headers with code: ' + ' '.join(h.split(BS)[-1] for h in hdrs)) if hdrs else ''))
print('%d objects with line records, %d contain a source file that is not their own' % (len(blocks), n))
# our tree: recon sources that match a FOREIGN-only retail file
import importlib.util
recon = {p.stem.lower(): p for p in [*(ROOT / 'recon').rglob('*.c'), *(ROOT / 'recon').rglob('*.cpp')]}
for f, objs in own.items():
    if all(stem(f) != stem(o.split('(')[-1].rstrip(')')) for o in objs):
        p = recon.get(stem(f))
        print('   %-24s appears only inside %-24s -> ours: %s' % (f.split(BS)[-1], ' '.join(objs)[:24], p.relative_to(ROOT).as_posix() if p else '(no file of that name)'))
