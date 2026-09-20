"""ownership_audit2.py -- true per-owner recount of the honest image INCLUDING ld's wrapped map lines
(a long section name sits alone on one line and its address/size/object follow on the next; honest_measure.py
does not parse those and files the words under OTHER).  Also lists the blob pieces that still own bytes no
reconstructed section covers."""
import re
from collections import Counter
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
LOAD = 0x80010000
n = len((ROOT / 'rom/nfs4-f.exe').read_bytes()[0x800:])
lines = (ROOT / 'build/gen_ld/recon_multdef-ok.map').read_text(errors='replace').splitlines()
recon, blob = bytearray(n), bytearray(n)
pieces = []


def mark(a, sz, src):
    src = src.replace('\\', '/')
    t = recon if 'build/recon/' in src else blob if 'build/asm/' in src else None
    if t is None or not sz or not (LOAD <= a < LOAD + n):
        return
    for i in range(a - LOAD, min(a - LOAD + sz, n)):
        t[i] = 1
    if t is blob:
        pieces.append((a, sz, src.split('/')[-1]))


one = re.compile(r'^ \.\S+\s+0x([0-9a-f]{8})\s+0x([0-9a-f]+)\s+(\S+\.o)$')
two = re.compile(r'^\s+0x([0-9a-f]{8})\s+0x([0-9a-f]+)\s+(\S+\.o)$')
for i, ln in enumerate(lines):
    m = one.match(ln)
    if m:
        mark(int(m.group(1), 16), int(m.group(2), 16), m.group(3))
    elif re.match(r'^ \.\S+$', ln) and i + 1 < len(lines):
        m = two.match(lines[i + 1])
        if m:
            mark(int(m.group(1), 16), int(m.group(2), 16), m.group(3))
c = Counter()
for off in range(0, n - 3, 4):
    r, b = sum(recon[off:off + 4]), sum(blob[off:off + 4])
    c['RECON' if r == 4 else 'BLOB' if (b or r) else 'NEITHER'] += 1
print(dict(c))
segs = Counter()
for a, sz, name in pieces:
    k = sum(1 for x in range(a - LOAD, min(a - LOAD + sz, n)) if not recon[x])
    if k:
        segs[name] += k
print(len(segs), 'blob pieces still own bytes;', sum(segs.values()), 'bytes')
for o, k in segs.most_common(14):
    print(f'  {k:6d} bytes  {o}')
