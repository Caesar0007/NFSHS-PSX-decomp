#!/usr/bin/env python3
"""unowned_data.py -- the DATA no source owns yet, as a worklist.

Route A is byte-identical because every byte a recon object does not define is supplied by a retail-byte filler
(asm/data/*.s pieces) or sits in a hole between placed sections.  Those bytes are exactly what Route C (slink_lane.py)
is short of.  This lists every such run from the honest GNU link map: address, size, the recon objects on both sides
(PSYLINK/slink lay sections out object by object, so the owner is one of the two neighbours or an object between them
in link order), the retail labels inside it, and what the bytes look like.
usage: unowned_data.py [section ...] [--min N] [--sdk]     (--sdk: also list runs bracketed by Sony library objects)"""
import re
import struct
import sys
from collections import defaultdict
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
BS = chr(92)
RET = [('front.rdata', 0x80010000, 0x800128F0), ('front.text', 0x800128F0, 0x80051260), ('front.data', 0x80051260, 0x80052B38),
       ('front.bss', 0x80052B38, 0x80054548), ('.rdata', 0x80054548, 0x8005797C), ('.text', 0x8005797C, 0x8010CCD4),
       ('.data', 0x8010CCD4, 0x8013C54C), ('.sdata', 0x8013C54C, 0x8013DD7C), ('.sbss', 0x8013DD7C, 0x8013DEE0), ('.bss', 0x8013DEE0, 0x80148B04)]
args = [a for a in sys.argv[1:] if not a.startswith('--')]
MIN = int(sys.argv[sys.argv.index('--min') + 1]) if '--min' in sys.argv else 1
if '--min' in sys.argv:
    args.remove(sys.argv[sys.argv.index('--min') + 1])
SDK = '--sdk' in sys.argv
M = re.compile(r'^ (\.\S+)\s+0x([0-9a-f]+)\s+0x([0-9a-f]+)\s+(\S+\.o)$', re.M)


def sec(a):
    for n, lo, hi in RET:
        if lo <= a < hi:
            return n


rows = []
for m in M.finditer((ROOT / 'build/gen_ld/recon_multdef-ok.map').read_text(errors='replace')):
    va, sz = int(m.group(2), 16), int(m.group(3), 16)
    if sz and sec(va) and 'bigbuf' not in m.group(4):
        rows.append((va, sz, m.group(4).replace(BS, '/')))
rows.sort()
rom = (ROOT / 'rom/nfs4-f.exe').read_bytes()
rd = lambda a, n: rom[0x800 + a - 0x80010000:0x800 + a - 0x80010000 + n]
labels = defaultdict(list)
for m in re.finditer(r'^ ([0-9A-F]{8}) (\S+)\s*$', Path('C:/Temp/nfs4iso/NFS4.MAP').read_text(encoding='latin-1'), re.M):
    labels[int(m.group(1), 16)].append(m.group(2))
lab_addrs = sorted(labels)
is_fill = lambda o: '/asm/' in o or o.startswith('asm/') or 'build/asm' in o
short = lambda o: re.sub(r'^build/recon/', '', o)[:-2] if o else '-'

# merge fillers + holes into runs of unowned bytes, per section
runs = []
cur = None
prev_end = None
prev_obj = None
for va, sz, o in rows:
    s = sec(va)
    if prev_end is not None and sec(prev_end - 1) == s and va > prev_end:          # hole
        if cur and cur[1] == prev_end:
            cur[1] = va
        else:
            cur = [prev_end, va, prev_obj, None]; runs.append(cur)
    if is_fill(o):
        if cur and cur[1] == va and sec(cur[0]) == s:
            cur[1] = va + sz
        else:
            cur = [va, va + sz, prev_obj, None]; runs.append(cur)
    else:
        if cur and cur[3] is None:
            cur[3] = o
        prev_obj = o
        cur = None if not (cur and cur[1] == va + sz) else cur
    prev_end = max(prev_end or 0, va + sz)


def look(b, s):
    if s.endswith('bss'):
        return 'bss'
    if not any(b):
        return 'zeros'
    txt = re.findall(rb'[\x20-\x7e]{4,}', b)
    if txt and sum(len(t) for t in txt) * 2 >= len(b):
        return 'text: ' + ' | '.join(t.decode() for t in txt[:4])[:70]
    if len(b) % 4 == 0:
        ws = [w for w, in struct.iter_unpack('<I', b)]
        if all(w == 0 or 0x80010000 <= w < 0x80150000 for w in ws):
            return 'pointers/vtable: ' + ' '.join('%08X' % w for w in ws[:5])
    return 'bytes: ' + b[:16].hex()


# retail link order (the PSYLINK lane's script: include order + retail names in the comments)
lane = (ROOT / 'build/psyq_off/nfs4.lnk')
if not lane.exists():
    lane = ROOT / 'build/psyq/nfs4.lnk'
order, retname = [], {}
for m in re.finditer(r'^\s+include\s+(\S+)\s*;\s*(.*)$', lane.read_text(encoding='latin-1'), re.M):
    order.append(m.group(1)); retname[m.group(1)] = m.group(2).strip()
pos = {o: i for i, o in enumerate(order)}
lanefn = lambda o: o.split('build/', 1)[-1][:-2].replace('/', '__') + '.obj' if o else None


def window(before, after):
    """retail objects strictly between the two neighbours in link order = the other possible owners"""
    i, j = pos.get(lanefn(before)), pos.get(lanefn(after))
    if i is None or j is None or j <= i:
        return []
    return [retname[o] for o in order[i + 1:j] if not retname[o].startswith('<')]


tot = defaultdict(int)
for lo, hi, before, after in runs:
    s = sec(lo)
    tot[s] += hi - lo
    if (args and s not in args) or hi - lo < MIN:
        continue
    lib = lambda o: o and '/syslib/' in o
    if not SDK and lib(before) and lib(after):
        continue
    names = [n for a in lab_addrs if lo <= a < hi for n in labels[a]]
    names = sorted(set(names), key=names.index)
    win = window(before, after)
    if not SDK and (lib(before) or lib(after)) and all('syslib' in w for w in win):
        continue                                   # Sony's own data: Route C gets it from Sony's LIB files
    win = [w.split(BS)[-1] for w in win]
    print('%-11s %08X..%08X %6d  after %-34s before %-34s' % (s, lo, hi, hi - lo, short(before)[-34:], short(after)[-34:]))
    print('            %s%s' % (look(rd(lo, hi - lo), s), ('   labels: ' + ' '.join(names)[:120]) if names else ''))
    if win:
        print('            between them in link order: ' + ' '.join(win)[:150])
print()
for n, _, _ in RET:
    if tot[n]:
        print('unowned in %-12s %7d B' % (n, tot[n]))
