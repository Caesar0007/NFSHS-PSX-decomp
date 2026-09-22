#!/usr/bin/env python3
"""slink_census.py -- who supplies each byte of the byte-identical Route C image, per section.

Sums the section sizes of every object slink linked: OUR objects (game sources + the EA libraries built from recon/eaclib)
against the Sony prebuilt library members retail pulled (tools/psyq_pipe/sym_obj_order.json = the retail SYM's object order,
Sony members tagged lib(member)).  Sizes come from the object records themselves (our .obj files in the lane dir, the members
from the LIB files the script inclibs), so the split needs no map.  The section lengths of the retail image are the check:
ours + Sony + slink's alignment padding must reach them.
usage: slink_census.py"""
import json
import os
import re
import sys
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tools'))
import psyq_extract as X
OUT = ROOT / os.environ.get('NFS4_LANE_OUT', 'build/psyq_off')
BS = chr(92)
RET = {'front.rdata': 0x28F0, 'front.text': 0x3E970, 'front.data': 0x18D8, 'front.bss': 0x1A10, '.rdata': 0x4797C, '.text': 0xB5358,
       '.data': 0x2F878, '.sdata': 0x1830, '.sbss': 0x164, '.bss': 0xAC24}

def sizes(o):
    """bytes per section name: code + uninitialised blocks (already zero-filled into code) + COMMONs (XBSS records,
    which slink allocates at the end of the section they name -- .bss/.sbss for ASPSX)"""
    out = defaultdict(int)
    for sid, name in o['sections'].items():
        out[name] += len(o['code'].get(sid, b''))
    for x in o['xdefs']:
        if 'bss' in x:
            out[o['sections'].get(x['sect'], '?')] += x['bss']
    return out

script = (OUT / 'off.lnk').read_text(encoding='latin-1')
ours = defaultdict(int); sony = defaultdict(int); nobj = [0, 0]
front = set()
for m in re.finditer(r'^\s+include\s+(\S+?)(,front)?\s*(;.*)?$', script, re.M):
    p = OUT / m.group(1)
    if not p.exists():
        continue
    o = X.parse_obj(p.read_bytes())
    nobj[0] += 1
    pre = 'front' if m.group(2) else ''
    for key, size in sizes(o).items():
        ours[(pre + key) if pre else key] += size
# Sony members retail linked
order = json.load(open(ROOT / 'tools/psyq_pipe/sym_obj_order.json'))
want = {}
for n, *_ in order:
    k = n.split(BS)[-1].lower()
    mm = re.match(r'(\w+)\.lib\((\w+)\.obj\)', k)
    if mm:
        want.setdefault(mm.group(1), set()).add(mm.group(2))
for m in re.finditer(r'^\s+inclib\s+"([^"]+)"', script, re.M):
    raw = Path(m.group(1)).read_bytes()
    lib = Path(m.group(1)).stem.lower()
    if raw[:4] == b'LIB' + bytes([2]):               # PSYLIB2 output = OUR EA library (recon/eaclib), members = lane objects
        for name in want.get(lib, ()):
            hits = list(OUT.glob('recon__eaclib__psx__%s__%s.c.obj' % (lib, name)))
            if not hits:
                print('   EA member without object:', lib, name)
                continue
            o = X.parse_obj(hits[0].read_bytes())
            nobj[0] += 1
            for key, size in sizes(o).items():
                ours[key] += size
        continue
    if raw[:4] != b'LIB' + bytes([1]):
        continue
    for mem in X.lib_members(raw)[0]:
        if mem['name'].lower() not in want.get(lib, ()):
            continue
        o = X.parse_obj(mem['data'])
        nobj[1] += 1
        for key, size in sizes(o).items():
            sony[key] += size
print('objects: ours %d, Sony members %d' % tuple(nobj))
print('%-12s %8s %8s %8s %8s' % ('section', 'retail', 'ours', 'Sony', 'pad'))
for sec, tot in RET.items():
    a, b = ours.get(sec, 0), sony.get(sec, 0)
    print('%-12s %8d %8d %8d %8d' % (sec, tot, a, b, tot - a - b))
