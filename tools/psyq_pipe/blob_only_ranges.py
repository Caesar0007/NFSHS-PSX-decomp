"""blob_only_ranges.py [LO HI] -- address ranges of the honest link that only a retail blob piece covers (no reconstructed
section), from the link map.  Same marking as ownership_audit2.py."""
import re
import sys
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
LOAD = 0x80010000
n = len((ROOT / 'rom/nfs4-f.exe').read_bytes()[0x800:])
lo = int(sys.argv[1], 16) if len(sys.argv) > 2 else LOAD
hi = int(sys.argv[2], 16) if len(sys.argv) > 2 else LOAD + n
lines = (ROOT / 'build/gen_ld/recon_multdef-ok.map').read_text(errors='replace').splitlines()
recon, blob = bytearray(n), bytearray(n)
who = {}
one = re.compile(r'^ \.\S+\s+0x([0-9a-f]{8})\s+0x([0-9a-f]+)\s+(\S+\.o)$')
two = re.compile(r'^\s+0x([0-9a-f]{8})\s+0x([0-9a-f]+)\s+(\S+\.o)$')


def mark(a, sz, src):
    src = src.replace(chr(92), '/')
    t = recon if 'build/recon/' in src else blob if 'build/asm/' in src else None
    if t is None or not sz or not (LOAD <= a < LOAD + n):
        return
    for i in range(a - LOAD, min(a - LOAD + sz, n)):
        t[i] = 1
        if t is blob:
            who[i] = src.split('/')[-1]


for i, ln in enumerate(lines):
    m = one.match(ln)
    if m:
        mark(int(m.group(1), 16), int(m.group(2), 16), m.group(3))
    elif re.match(r'^ \.\S+$', ln) and i + 1 < len(lines):
        m = two.match(lines[i + 1])
        if m:
            mark(int(m.group(1), 16), int(m.group(2), 16), m.group(3))
s = None
tot = 0
for off in range(lo - LOAD, hi - LOAD + 1):
    bo = off < n and off < hi - LOAD and blob[off] and not recon[off]
    if bo and s is None:
        s = off
    if not bo and s is not None:
        print('%08x..%08x %5d  %s' % (LOAD + s, LOAD + off, off - s, who[s]))
        tot += off - s
        s = None
print('total', tot)
