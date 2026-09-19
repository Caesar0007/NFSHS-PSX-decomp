"""rogaps.py [MIN] -- blob-only gaps inside the two read-only regions, decoded: strings are printed as text, other
words as hex, with the reconstructed .rodata windows on either side (the object that should emit the literal)."""
import bisect
import json
import struct
import sys
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
LOAD = 0x80010000
rom = (ROOT / 'rom/nfs4-f.exe').read_bytes()[0x800:]
minb = int(sys.argv[1]) if len(sys.argv) > 1 else 8
rows = sorted((r['base'], r['end'], r['obj'].split('build/recon/')[-1]) for r in json.load(open(ROOT / 'linkers/nfs4_recon.rodata_placement.json')))
extra = ROOT / 'linkers/nfs4_recon.rodata_extra.json'
if extra.exists():
    rows += [(r['base'], r['end'], r['obj'].split('build/recon/')[-1]) for r in json.load(open(extra))]
rows.sort()
starts = [a for a, _, _ in rows]
REGIONS = [(0x80010000, 0x800128F0), (0x80054548, 0x8005797C)]
for lo, hi in REGIONS:
    cur = lo
    gaps = []
    for a, b, o in rows:
        if a < lo or a >= hi:
            continue
        if a > cur:
            gaps.append((cur, a))
        cur = max(cur, b)
    if cur < hi:
        gaps.append((cur, hi))
    for a, b in gaps:
        if b - a < minb:
            continue
        i = bisect.bisect_right(starts, a) - 1
        before = rows[i][2] if i >= 0 else '-'
        after = rows[i + 1][2] if i + 1 < len(rows) else '-'
        data = rom[a - LOAD:b - LOAD]
        out = []
        p = 0
        while p < len(data):
            if 32 <= data[p] < 127:
                q = data.find(b'\0', p)
                q = len(data) if q < 0 else q
                s = data[p:q]
                if all(32 <= c < 127 or c in (9, 10) for c in s) and len(s) >= 2:
                    out.append(repr(s.decode('latin1')))
                    p = q + 1
                    continue
            if p % 4 == 0 and p + 4 <= len(data):
                w = struct.unpack_from('<I', data, p)[0]
                if w:
                    out.append(f'{w:#x}')
                p += 4
            else:
                p += 1
        text = ' '.join(out)
        print(f'{a:#010x} +{b - a:4d}  [{before} | {after}]')
        print('      ' + (text[:230] if text else '(all zero)'))
