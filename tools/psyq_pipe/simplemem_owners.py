#!/usr/bin/env python3
"""simplemem_owners.py -- which object owns each unreferenced "SimpleMem" tag in the retail read-only data?

Retail has the 12-byte literal "SimpleMem" at the HEAD of the read-only data of (nearly) every object that saw the
SimpleMem class header: an unused inline in that header makes cc1plus emit the string in every such TU, functions or not.
A tag sits at the head of its owner's .rdata, and the linker lays .rdata out object by object in link order, so for a run
of n tags the owners are n consecutive objects in link order ending at the object whose own read-only data follows the
run (or objects with no other read-only data at all -- the function-less ones).
Prints every retail tag run with the link-order window, and whether our object already emits the tag.
usage: simplemem_owners.py"""
import re
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
BS = chr(92)
TAG = b'SimpleMem' + bytes(1)
rom = (ROOT / 'rom/nfs4-f.exe').read_bytes()
RANGES = [('front.rdata', 0x80010000, 0x800128F0), ('.rdata', 0x80054548 + 282000 - 282000, 0x8005797C)]
M = re.compile(r'^ (\.\S+)\s+0x([0-9a-f]+)\s+0x([0-9a-f]+)\s+(\S+\.o)$', re.M)
rows = []
for m in M.finditer((ROOT / 'build/gen_ld/recon_multdef-ok.map').read_text(errors='replace')):
    va, sz, o = int(m.group(2), 16), int(m.group(3), 16), m.group(4).replace(BS, '/')
    if sz and '/asm/' not in o and 'bigbuf' not in o and m.group(1).startswith(('.rodata', '.rdata')):
        rows.append((va, va + sz, o))
rows.sort()
lane = ROOT / 'build/psyq_off/nfs4.lnk'
order, retname = [], {}
for m in re.finditer(r'^\s+include\s+(\S+)\s*;\s*(.*)$', lane.read_text(encoding='latin-1'), re.M):
    order.append(m.group(1)); retname[m.group(1)] = m.group(2).strip().split(BS)[-1]
pos = {o: i for i, o in enumerate(order)}
lanefn = lambda o: o.split('build/', 1)[-1][:-2].replace('/', '__') + '.obj'


def has_tag(lane_obj):
    p = ROOT / 'build/psyq_off' / lane_obj.replace('.obj', '.s')
    return p.exists() and b'SimpleMem' in p.read_bytes()


# all retail tags
tags = []
for name, lo, hi in RANGES:
    blob = rom[0x800 + lo - 0x80010000:0x800 + hi - 0x80010000]
    i = blob.find(TAG)
    while i >= 0:
        if i % 4 == 0:
            tags.append(lo + i)
        i = blob.find(TAG, i + 1)
print('%d "SimpleMem" tags in retail read-only data' % len(tags))
# runs of adjacent tags (12 apart, or 16 in the 8-aligned overlay)
runs = []
for a in tags:
    if runs and a - runs[-1][-1] in (12, 16):
        runs[-1].append(a)
    else:
        runs.append([a])
need = []
for run in runs:
    lo, hi = run[0], run[-1] + 12
    before = [r for r in rows if r[1] <= lo]
    after = [r for r in rows if r[0] >= lo]
    b = before[-1][2] if before else None
    a = after[0][2] if after else None
    i = pos.get(lanefn(b), -1) if b else -1
    j = pos.get(lanefn(a), len(order)) if a else len(order)
    cands = order[i + 1:j + 1]                        # objects after `before`, up to and including `after`
    state = ['%s%s' % (retname[c], '' if has_tag(c) else ' (NO TAG IN OURS)') for c in cands]
    missing = [c for c in cands if not has_tag(c)]
    have = len(cands) - len(missing)
    print('%08X  %d tag(s)  candidates in link order: %s' % (lo, len(run), ', '.join(state)[:230]))
    if len(run) > have:
        need.append((lo, len(run) - have, missing))
print()
print('runs where ours emits fewer tags than retail:')
for lo, n, missing in need:
    print('   %08X  %d more needed among: %s' % (lo, n, ' '.join(m.replace('recon__', '').replace('.obj', '') for m in missing)[:200]))
