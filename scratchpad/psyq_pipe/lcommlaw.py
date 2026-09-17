#!/usr/bin/env python3
"""lcommlaw.py -- retail alignment law for local statics: pair the SYM's type-6 (local) .bss /
front.bss symbols with their Def2 sizes (same name, size>0) and report, per size bucket, the
minimum address alignment observed (lowest set bit), so the retail assembler's .lcomm rule can be read off."""
import re, sys, collections
SYM = 'C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt'
BSS = [(0x80052B38, 0x80054548, 'front.bss'), (0x8013DD7C, 0x8013DEE0, '.sbss'), (0x8013DEE0, 0x80148B04, '.bss')]
loc = []; sizes = collections.defaultdict(set)
for l in open(SYM, errors='replace'):
    m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) 6 (\S+)$', l)
    if m: loc.append((int(m.group(1), 16), m.group(2))); continue
    m = re.match(r'^[0-9a-f]+: \$[0-9a-f]{8} 9[46] Def2? class STAT type (.*?) size (\d+) .* name (\S+)$', l)
    if m and int(m.group(2)) > 0: sizes[m.group(3)].add((int(m.group(2)), m.group(1).split()[0]))
def align(a): return a & -a
rows = []
for a, n in loc:
    sec = next((s for lo, hi, s in BSS if lo <= a < hi), None)
    if not sec: continue
    base = n.split('.')[0]
    if base in sizes and len(sizes[base]) == 1:
        (sz, ty), = sizes[base]; rows.append((sec, sz, min(align(a), 64), n, a, ty))
by = collections.defaultdict(list)
for sec, sz, al, n, a, ty in rows: by[(sec, sz)].append((al, n, a, ty))
for (sec, sz), v in sorted(by.items()):
    als = sorted(x[0] for x in v)
    print(f'{sec:9s} size {sz:4d}: n={len(v):3d} min-align {als[0]:2d}  (aligns {sorted(set(als))})  e.g. {v[0][1]}@{v[0][2]:08x} {v[0][3]}')
