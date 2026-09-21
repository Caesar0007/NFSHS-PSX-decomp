#!/usr/bin/env python3
"""slink_datadiff.py -- WHAT data is a slink_lane.py variant missing?  the section contents themselves, aligned.

The initialised data sections of the variant and of retail are cut into 4-byte words, every word that is an address
(0x80010000..0x80150000) is replaced by one token (addresses legitimately differ while the layout drifts), and the two
word streams are aligned with difflib.  Each non-matching block is printed with: the retail address, the owning
neighbourhood (the nearest retail MAP labels below / above), and the bytes -- so a block reads "retail has these 12
bytes `SimpleMem` between X and Y, ours has nothing".
usage: slink_datadiff.py [variant] [section ...]      sections: .rdata front.rdata .data front.data .sdata"""
import difflib
import os
import re
import struct
import sys
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
OUT = ROOT / os.environ.get('NFS4_LANE_OUT', 'build/psyq_off')
sys.path.insert(0, str(Path(__file__).resolve().parent))
args = [a for a in sys.argv[1:] if not a.startswith('--')]
variant = args[0] if args else 'off'
want = args[1:] or ['front.rdata', 'front.data', '.rdata', '.data', '.sdata']
BIGBUF = 282000


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


def sections(path):
    return {m.group(3): (int(m.group(1), 16), int(m.group(2), 16)) for m in
            re.finditer(r'^ ([0-9A-F]{8}) [0-9A-F]{8} ([0-9A-F]{8}) [0-9A-F]{8} \S+\s+(\S+)\s*$', Path(path).read_text(encoding='latin-1'), re.M)}


def labels(path):
    out = {}
    for m in re.finditer(r'^ ([0-9A-F]{8})  ?(\S+)\s*$', Path(path).read_text(encoding='latin-1'), re.M):
        out.setdefault(int(m.group(1), 16), m.group(2))
    return out


rom = (ROOT / 'rom/nfs4-f.exe').read_bytes()
ret_rd = lambda a, n: rom[0x800 + a - 0x80010000:0x800 + a - 0x80010000 + n]
base, flat = cpe_flat(OUT / (variant + '.cpe'))
front = (OUT / (variant + '_front.bin')).read_bytes()
rs, os_ = sections('C:/Temp/nfs4iso/NFS4.MAP'), sections(OUT / (variant + '.map'))
rl, ol = labels('C:/Temp/nfs4iso/NFS4.MAP'), labels(OUT / (variant + '.map'))
rla, ola = sorted(rl), sorted(ol)
PTR = 0xFFFFFFFF


def words(b):
    out = []
    for w, in struct.iter_unpack('<I', b[:len(b) & ~3]):
        out.append(PTR if 0x80010000 <= w < 0x80150000 else w)
    return out


def near(addrs, table, a):
    import bisect
    i = bisect.bisect_right(addrs, a)
    lo = table[addrs[i - 1]] + '+%X' % (a - addrs[i - 1]) if i else '-'
    return lo


def show(b):
    txt = re.findall(rb'[\x20-\x7e]{3,}', b)
    if txt and sum(len(t) for t in txt) * 2 >= len(b):
        return '"' + ' | '.join(t.decode() for t in txt)[:90] + '"'
    return b[:24].hex() + ('..' if len(b) > 24 else '')


for sec in want:
    ra, rn = rs[sec]; oa, on = os_[sec]
    if sec == '.rdata':                      # skip bigbuf.obj's zero reservation (the overlay is linked over it)
        ra += BIGBUF; rn -= BIGBUF; oa += BIGBUF; on -= BIGBUF
    rb = ret_rd(ra, rn)
    ob = front[oa - 0x80010000:oa - 0x80010000 + on] if sec.startswith('front') else flat[oa - base:oa - base + on]
    rw, ow = words(rb), words(ob)
    sm = difflib.SequenceMatcher(None, rw, ow, autojunk=False)
    print('== %s: retail %d B, ours %d B (%+d)' % (sec, rn, on, on - rn))
    miss = extra = 0
    for tag, i1, i2, j1, j2 in sm.get_opcodes():
        if tag == 'equal':
            continue
        r, o = rb[i1 * 4:i2 * 4], ob[j1 * 4:j2 * 4]
        miss += len(r); extra += len(o)
        print('  %-7s retail %08X %4d B  %-44s | ours %4d B  %s' % (tag, ra + i1 * 4, len(r), near(rla, rl, ra + i1 * 4)[:44], len(o), near(ola, ol, oa + j1 * 4)[:40]))
        if r:
            print('          retail: %s' % show(r))
        if o:
            print('          ours  : %s' % show(o))
    print('   blocks only in retail: %d B, only in ours: %d B' % (miss, extra))
