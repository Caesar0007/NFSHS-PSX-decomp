#!/usr/bin/env python3
"""NFS1 PSX track container: Z<track>.TRI (Road & Track Presents The Need for Speed, SLUS-00204).

Follows the retail loaders (raw disassembly of SLUS_002.04 at C:/Temp/nfs1_analysis):
  func_80037058 track load ("RenderInfo" 0x16DB0), func_80036EE8 ("RoadSection" 0x1621C, "TrackSlices"),
  "RoadObjects" read after the 12-byte OBJS header.

Layout: RoadSection (0x1621C bytes) | OBJS block (12-byte header {tag, size 17036, 0} incl.) |
        n x TRKD record (12-byte header {'TRKD', 276, 0} + 276 bytes) | CRCF {'CRCF', 12, crc}
  n = second short of RoadSection+4; RoadSection+0x24 = n * 288.

  OBJS body: 64 x 16-byte definitions, then (from record RoadSection+0x16214) 16-byte placements
  {i32 node, u8 def, u8 rot, ...} terminated by node -1.
  .FAM: nested {0x77777777, count, offset[count]} container (FUN_8004C2E4).
  CRCF: CRC-16 (reflected 0xA001 table, init 0xFBEA) over the data before the 12-byte chunk (FUN_800B4850).

  python nfs1_tri.py census <dir>      TRI container + placement checks
  python nfs1_tri.py fam <dir>         FAM container checks
  python nfs1_tri.py crc <dir>         CRCF check of every file (and every BIGF entry)
"""
import os, sys, glob, struct, collections

ROAD = 0x1621C
OBJS = 17036


def parse(d):
    n = struct.unpack_from('<2h', d, 4)[1]
    h9 = struct.unpack_from('<i', d, 0x24)[0]
    o = ROAD
    otag, osz, oz = struct.unpack_from('<4sii', d, o)
    o += OBJS
    recs = []
    for i in range(n):
        tag, sz, w3 = struct.unpack_from('<4sii', d, o)
        recs.append((o, tag, sz, w3)); o += 12 + sz
    etag, esz, crc = struct.unpack_from('<4sii', d, o)
    return dict(n=n, h9=h9, objs=(otag, osz, oz), recs=recs, end=(etag, esz, crc, o + 12 == len(d)))


def crc16(b, c=0xFBEA):
    for x in b:
        c ^= x
        for _ in range(8):
            c = (c >> 1) ^ 0xA001 if c & 1 else c >> 1
    return c


def placements(d):
    body = ROAD + 12
    o = body + 16 * struct.unpack_from('<i', d, 0x16214)[0]; out = []
    while True:
        node = struct.unpack_from('<i', d, o)[0]
        if node == -1:
            return out
        out.append((node, d[o + 4], d[o + 5]) + struct.unpack_from('<3h', d, o + 10)); o += 16


def census(dirpath):
    st = collections.Counter(); ok = True
    for f in sorted(glob.glob(os.path.join(dirpath, 'Z*.TRI'))):
        d = open(f, 'rb').read(); p = parse(d); b = os.path.basename(f); errs = []
        if struct.unpack_from('<i', d, 0)[0] != 17: errs.append('version')
        if p['h9'] != 288 * p['n']: errs.append('slice size')
        if p['objs'][0] not in (b'OBJS', b'SJBO') or p['objs'][1:] != (OBJS, 0): errs.append('OBJS header')
        if any(t != b'TRKD' or s != 276 or w for o, t, s, w in p['recs']): errs.append('TRKD record')
        if p['end'][:2] != (b'CRCF', 12) or not p['end'][3]: errs.append('CRCF end')
        pl = placements(d); nodes = [x[0] for x in pl]
        if nodes != sorted(nodes) or any(x[1] >= 64 for x in pl) or len(pl) > struct.unpack_from('<i', d, 0x16218)[0]:
            errs.append('placements')
        st['placements'] += len(pl)
        for e in errs: print('  %s: %s' % (b, e))
        ok &= not errs
        st['files'] += 1; st['TRKD records'] += p['n']; st['OBJS tag ' + p['objs'][0].decode()] += 1
    print('census:', dict(st)); print('problems:', 'none' if ok else 'see above')


def fam(dirpath):
    ok = True; n = 0
    for f in sorted(glob.glob(os.path.join(dirpath, 'Z*.FAM'))):
        d = open(f, 'rb').read(); b = os.path.basename(f)
        magic, cnt = struct.unpack_from('<2I', d, 0)
        offs = struct.unpack_from('<%dI' % cnt, d, 8)
        ends = list(offs[1:]) + [len(d) - 12]
        tags = {d[o:o + 4] for o in offs}
        good = (magic == 0x77777777 and offs[0] == 8 + 4 * cnt and list(offs) == sorted(offs)
                and tags <= ({b'ORIX'} if '_POR' in b else {b'SHPP'}) | {struct.pack('<I', 0x77777777)}
                and all(e > o for o, e in zip(offs, ends)))
        if not good:
            print('  %s: bad container %r' % (b, (hex(magic), cnt, offs, tags)))
        ok &= good; n += 1
    print('fam: %d files' % n, 'problems:', 'none' if ok else 'see above')


def crc(dirpath):
    st = collections.Counter()
    for f in sorted(glob.glob(os.path.join(dirpath, '*'))):
        d = open(f, 'rb').read()
        parts = [d]
        if d[:4] == b'BIGF':
            cnt = struct.unpack_from('>I', d, 8)[0]; o = 16; parts = []
            for _ in range(cnt):
                off, sz = struct.unpack_from('>II', d, o); o = d.index(b'\0', o + 8) + 1
                parts.append(d[off:off + sz])
            st['BIGF files'] += 1
        for b in parts:
            if b[-12:-8] != b'CRCF':
                st['no CRCF'] += 1; continue
            good = crc16(b[:-12]) == struct.unpack_from('<I', b, len(b) - 4)[0]
            st['ok' if good else 'BAD'] += 1
            if not good:
                print('  bad CRC', os.path.basename(f))
    print('crc:', dict(st))


if __name__ == '__main__':
    {'census': census, 'fam': fam, 'crc': crc}[sys.argv[1]](sys.argv[2])
