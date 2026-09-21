#!/usr/bin/env python3
"""ro_view.py LO HI -- retail bytes in [LO, HI) item by item (strings / words), with retail MAP labels and the recon object
whose placed .rodata / .data row covers each item (from the honest GNU link map).  For reading data layout by eye."""
import re
import struct
import sys
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
BS = chr(92)
lo, hi = int(sys.argv[1], 16), int(sys.argv[2], 16)
rom = (ROOT / 'rom/nfs4-f.exe').read_bytes()
rd = lambda a, n: rom[0x800 + a - 0x80010000:0x800 + a - 0x80010000 + n]
labels = {}
for m in re.finditer(r'^ ([0-9A-F]{8}) (\S+)\s*$', Path('C:/Temp/nfs4iso/NFS4.MAP').read_text(encoding='latin-1'), re.M):
    labels.setdefault(int(m.group(1), 16), []).append(m.group(2))
M = re.compile(r'^ (\.\S+)\s+0x([0-9a-f]+)\s+0x([0-9a-f]+)\s+(\S+\.o)$', re.M)
rows = []
for m in M.finditer((ROOT / 'build/gen_ld/recon_multdef-ok.map').read_text(errors='replace')):
    va, sz, o = int(m.group(2), 16), int(m.group(3), 16), m.group(4).replace(BS, '/')
    if sz and 'bigbuf' not in o:
        rows.append((va, va + sz, re.sub(r'^build/(recon/)?', '', o)[:-2]))


def owner(a):
    c = [o for l, h, o in rows if l <= a < h]
    real = [o for o in c if not o.startswith('asm/')]
    return (real or c or ['-'])[-1]


a = lo
while a < hi:
    b = rd(a, 64)
    m = re.match(rb'[\x09\x0a\x20-\x7e]{2,}\x00', b)
    if m and a % 4 == 0:
        n = (len(m.group(0)) + 3) & ~3
        item = '"%s"' % m.group(0)[:-1].decode().replace('\n', BS + 'n')
    else:
        n = 4
        w, = struct.unpack('<I', b[:4])
        item = '%08X' % w
    names = [x for k in range(a, a + n) for x in labels.get(k, [])]
    print('%08X %-44s %-34s %s' % (a, item[:44], owner(a)[-34:], ' '.join(sorted(set(names)))[:60]))
    a += n
