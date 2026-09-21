#!/usr/bin/env python3
"""slink_addrdrift.py -- WHERE do the addresses in a slink_lane.py image differ from retail?  a drift map from the code.

When the layouts agree instruction for instruction, every remaining byte difference is an ADDRESS.  This walks the retail
and our .text / front.text in step, pairs each `lui` with the `addiu` / load / store that completes it, and collects
(retail address, our address) for every reference whose two sides differ (plus differing 32-bit pointers in the data
sections).  Sorted by retail address, the difference stays constant until something in between is bigger / smaller /
missing: each change point is printed with the retail names around it (globals AND statics, from the retail SYM).
usage: slink_addrdrift.py [variant]"""
import bisect
import os
import re
import struct
import sys
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
sys.path.insert(0, str(ROOT / 'tools'))
OUT = ROOT / os.environ.get('NFS4_LANE_OUT', 'build/psyq_off')
variant = sys.argv[1] if len(sys.argv) > 1 and not sys.argv[1].startswith('--') else 'off'
T = Path(__import__('retail_sym').txt())


def cpe_flat(path):
    d = Path(path).read_bytes()
    chunks = {}
    p = 4
    while p < len(d):
        t = d[p]; p += 1
        if t == 0:
            break
        if t == 1:
            a, n = struct.unpack_from('<II', d, p)
            chunks[a] = d[p + 8:p + 8 + n]; p += 8 + n
        else:
            p += {2: 4, 3: 6, 4: 4, 5: 3, 6: 8, 7: 4, 8: 1}[t]
    lo = min(chunks); hi = max(a + len(b) for a, b in chunks.items())
    flat = bytearray(hi - lo)
    for a, b in chunks.items():
        flat[a - lo:a - lo + len(b)] = b
    return lo, bytes(flat)


rom = (ROOT / 'rom/nfs4-f.exe').read_bytes()[0x800:]
base, flat = cpe_flat(OUT / (variant + '.cpe'))
front = (OUT / (variant + '_front.bin')).read_bytes()
REG = [('front.text', 0x800128F0, 0x80051260, True), ('.text', 0x8005797C, 0x8010CCD4, False)]
pairs = {}


def s16(x):
    return x - 0x10000 if x & 0x8000 else x


for name, lo, hi, isfront in REG:
    r = rom[lo - 0x80010000:hi - 0x80010000]
    o = front[lo - 0x80010000:hi - 0x80010000] if isfront else flat[lo - base:hi - base]
    n = min(len(r), len(o)) // 4
    rw = struct.unpack('<%dI' % n, r[:n * 4]); ow = struct.unpack('<%dI' % n, o[:n * 4])
    hi_r, hi_o = {}, {}
    for k in range(n):
        a, b = rw[k], ow[k]
        op = a >> 26
        if op == 15:                                   # lui
            hi_r[(a >> 16) & 31] = a & 0xFFFF; hi_o[(b >> 16) & 31] = b & 0xFFFF
            continue
        if (op == 9 or 32 <= op <= 46) and (a >> 26) == (b >> 26):
            rs = (a >> 21) & 31
            if rs in hi_r and rs in hi_o:
                ra = ((hi_r[rs] << 16) + s16(a & 0xFFFF)) & 0xFFFFFFFF
                oa = ((hi_o[rs] << 16) + s16(b & 0xFFFF)) & 0xFFFFFFFF
                if 0x80010000 <= ra < 0x80200000 and ra != oa:
                    pairs.setdefault(ra, oa)
            if op == 9 and ((a >> 16) & 31) == rs:
                hi_r.pop(rs, None); hi_o.pop(rs, None)
        if op in (2, 3) or (op == 0 and (a & 0x3F) in (8, 9)):    # j / jal / jr / jalr: end of the pairing window
            pass
# pointers in the initialised data
for lo, hi in ((0x80054548, 0x8005797C), (0x8010CCD4, 0x8013DD7C)):
    r = rom[lo - 0x80010000:hi - 0x80010000]; o = flat[lo - base:hi - base]
    for k in range(0, min(len(r), len(o)) - 3, 4):
        a, = struct.unpack_from('<I', r, k); b, = struct.unpack_from('<I', o, k)
        if a != b and 0x80010000 <= a < 0x80200000 and 0x80010000 <= b < 0x80200000:
            pairs.setdefault(a, b)
names = {}
for l in T.read_text(encoding='latin-1').splitlines():
    m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) (?:2 (\S+)|9[46] Def2? class (?:EXT|STAT) .* name (\S+))$', l)
    if m:
        names.setdefault(int(m.group(1), 16), m.group(2) or m.group(3))
na = sorted(names)


def near(a):
    i = bisect.bisect_right(na, a)
    return '%s+%X' % (names[na[i - 1]], a - na[i - 1]) if i else '-'


rows = sorted(pairs.items())
print('%d distinct addresses are referenced differently' % len(rows))
prev = None
for ra, oa in rows:
    d = oa - ra
    if d != prev:
        print('   from %08X  ours %+5d   %s' % (ra, d, near(ra)))
        prev = d
