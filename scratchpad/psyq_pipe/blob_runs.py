"""blob_runs.py [MINBYTES] -- inventory of image bytes that ONLY a retail blob piece (build/asm/...) covers.
For each contiguous run: VA range, size, blob piece, the recon sections placed just before / after it (the
likely owner by link order), the SYM/symbol_addrs names inside it, and whether the bytes are all zero."""
import bisect
import re
import sys
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
LOAD = 0x80010000
rom = (ROOT / 'rom/nfs4-f.exe').read_bytes()[0x800:]
n = len(rom)
minb = int(sys.argv[1]) if len(sys.argv) > 1 else 1
lines = (ROOT / 'build/gen_ld/recon_multdef-ok.map').read_text(errors='replace').splitlines()
recon, blob = bytearray(n), bytearray(n)
rsecs, bsecs = [], []
one = re.compile(r'^ (\.\S+)\s+0x([0-9a-f]{8})\s+0x([0-9a-f]+)\s+(\S+\.o)$')
two = re.compile(r'^\s+0x([0-9a-f]{8})\s+0x([0-9a-f]+)\s+(\S+\.o)$')


def mark(sec, a, sz, src):
    src = src.replace('\\', '/')
    if not sz or not (LOAD <= a < LOAD + n):
        return
    if 'build/recon/' in src:
        t = recon
        rsecs.append((a, a + sz, src.split('build/recon/')[-1] + '(' + sec + ')'))
    elif 'build/asm/' in src:
        t = blob
        bsecs.append((a, a + sz, src.split('/')[-1]))
    else:
        return
    for i in range(a - LOAD, min(a - LOAD + sz, n)):
        t[i] = 1


for i, ln in enumerate(lines):
    m = one.match(ln)
    if m:
        mark(m.group(1), int(m.group(2), 16), int(m.group(3), 16), m.group(4))
    else:
        m0 = re.match(r'^ (\.\S+)$', ln)
        if m0 and i + 1 < len(lines):
            m = two.match(lines[i + 1])
            if m:
                mark(m0.group(1), int(m.group(1), 16), int(m.group(2), 16), m.group(3))
rsecs.sort()
bsecs.sort()
names = []
for ln in open(ROOT / 'configs/symbol_addrs.txt', errors='replace'):
    m = re.match(r'(\S+?)\s*=\s*(0x[0-9A-Fa-f]+);', ln)
    if m:
        names.append((int(m.group(2), 16), m.group(1)))
names.sort()
nk = [v for v, _ in names]
rs = [a for a, _, _ in rsecs]
runs = []
off = 0
while off < n:
    if blob[off] and not recon[off]:
        s = off
        while off < n and blob[off] and not recon[off]:
            off += 1
        runs.append((LOAD + s, off - s))
    else:
        off += 1
tot = 0
for va, sz in runs:
    if sz < minb:
        continue
    tot += sz
    piece = next((nm for a, b, nm in bsecs if a <= va < b), '?')
    i = bisect.bisect_right(rs, va) - 1
    before = rsecs[i][2] if i >= 0 else '-'
    after = rsecs[i + 1][2] if i + 1 < len(rsecs) else '-'
    inside = [nm for v, nm in names[bisect.bisect_left(nk, va):bisect.bisect_left(nk, va + sz)]]
    data = rom[va - LOAD:va - LOAD + sz]
    zero = 'ALL-ZERO' if not any(data) else ''
    print(f'{va:#010x} +{sz:5d}  {piece:34s} {zero}')
    print(f'      before: {before}')
    print(f'      after : {after}')
    if inside:
        print('      names : ' + ', '.join(inside[:8]) + (' ...' if len(inside) > 8 else ''))
print(f'{len([r for r in runs if r[1] >= minb])} runs, {tot} bytes')
