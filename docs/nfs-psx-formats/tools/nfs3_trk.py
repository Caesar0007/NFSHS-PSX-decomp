#!/usr/bin/env python3
"""NFS3 PSX track containers: ZZZTR<NN><v>.TRK ('TRAC') and ZTR<NN><v>.COL ('COLL').

Follows the retail loaders (NFS3 SLUS-006.20, raw oracle nfs3-clean/nfs3-raw-L.txt):
  TRK header + tables     func_800C370C (header read, 'TRAC' + version 0x16 check, StmChunkF /
                          StmCenter / StmMetaI tables), accessors func_8009E694..8009E800
  meta-chunk streaming    func_80079C58 -> func_800C3990 (seek StmChunkF[meta], read MaxMetaChunkSize)
  chunk binder            func_8007A198 (sub-block lookup func_8009E870(chunk, type))
  COL                     func_80068018 (collection dispatch on type)

  python nfs3_trk.py trk    <file.TRK>      header, tables, per-chunk sub-block list
  python nfs3_trk.py col    <file.COL>      collection list
  python nfs3_trk.py census <dir>           validate every TRK/COL in a directory
"""
import os, sys, glob, struct, collections

COL_NAMES = {2: '(type 2)', 7: 'kINSTANCE_COLLECTION', 8: 'kOBJECTDEF_COLLECTION',
             0xF: 'slices', 0x12: '(type 0x12)', 0x14: 'kOBJSFXINST_COLLECTION'}


class Trk:
    def __init__(self, d):
        self.d = d
        (self.magic, self.version, self.maxMetaChunkSize, self.maxChunkSize, self.h10, self.h14,
         self.metaCount, self.chunkCount) = struct.unpack_from('<4s7I', d, 0)
        n, m = self.metaCount, self.chunkCount
        self.metaOffsets = list(struct.unpack_from('<%dI' % n, d, 32))            # StmChunkF
        p = 32 + 4 * n
        self.centers = [struct.unpack_from('<3i', d, p + 12 * i) for i in range(m)]  # StmCenter
        p += 12 * m
        self.metaIndex = list(struct.unpack_from('<%dH' % m, d, p))                # StmMetaI
        self.tablesEnd = p + 2 * m

    def metas(self):
        ends = self.metaOffsets[1:] + [len(self.d)]
        for i, (a, b) in enumerate(zip(self.metaOffsets, ends)):
            size, count, zero = struct.unpack_from('<3I', self.d, a)
            offs = struct.unpack_from('<%dI' % count, self.d, a + 12)
            yield i, a, b, size, count, zero, offs

    def chunks(self):
        for i, a, b, size, count, zero, offs in self.metas():
            for j, x in enumerate(offs):
                c = a + x
                s1, s2, nsub = struct.unpack_from('<IIh', self.d, c)
                rel = struct.unpack_from('<I', self.d, c + 0x40)[0]
                subs = struct.unpack_from('<%dI' % nsub, self.d, c + 0x40 + rel)
                blocks = []
                for so in subs:
                    length, typ, num = struct.unpack_from('<IHH', self.d, c + so)
                    blocks.append((so, length, typ, num))
                yield 8 * i + j, c, s1, s2, blocks


def check_trk(d, name, st, types):
    t = Trk(d)
    errs = []
    if t.magic != b'TRAC' or t.version != 0x16: errs.append('magic/version')
    if t.metaCount != (t.chunkCount + 7) // 8: errs.append('metaCount != ceil(chunks/8)')
    if t.metaIndex != [i // 8 for i in range(t.chunkCount)]: errs.append('StmMetaI != i/8')
    if t.metaOffsets[0] != (t.tablesEnd + 3) & ~3: errs.append('first meta not after tables')
    maxmeta = maxchunk = 0
    for i, a, b, size, count, zero, offs in t.metas():
        if zero != 0 or count != min(8, t.chunkCount - 8 * i): errs.append('meta %d header' % i)
        if not (size <= b - a < size + 4): errs.append('meta %d size' % i)
        if offs[0] != 12 + 4 * count: errs.append('meta %d first chunk' % i)
        ends = list(offs[1:]) + [size]
        for x, y in zip(offs, ends):
            s1, s2 = struct.unpack_from('<II', d, a + x)
            if s1 != y - x or s2 != s1: errs.append('meta %d chunk size' % i)
            maxchunk = max(maxchunk, s1)
        maxmeta = max(maxmeta, size)
    if maxmeta != t.maxMetaChunkSize: errs.append('MaxMetaChunkSize != largest meta')
    if maxchunk != t.maxChunkSize: errs.append('header+0xC != largest chunk')
    for ci, c, s1, s2, blocks in t.chunks():
        for so, length, typ, num in blocks:
            types[typ] += 1
            if so + length > s1: errs.append('chunk %d block overruns' % ci)
    st['trk files'] += 1; st['chunks'] += t.chunkCount
    for e in errs: print('  %s: %s' % (name, e))
    return not errs


def parse_col(d):
    magic, version, size, count = struct.unpack_from('<4sIII', d, 0)
    offs = struct.unpack_from('<%dI' % count, d, 16)
    cols = []
    for o in offs:
        length, typ, num = struct.unpack_from('<IHH', d, 16 + o)
        cols.append((16 + o, length, typ, num))
    return magic, version, size, cols


def census(dirpath):
    st = collections.Counter(); types = collections.Counter(); ctypes = collections.Counter()
    ok = True
    for f in sorted(glob.glob(os.path.join(dirpath, '*.TRK'))):
        ok &= check_trk(open(f, 'rb').read(), os.path.basename(f), st, types)
    for f in sorted(glob.glob(os.path.join(dirpath, '*.COL'))):
        d = open(f, 'rb').read()
        magic, version, size, cols = parse_col(d)
        st['col files'] += 1
        if magic != b'COLL' or version != 11 or size != len(d):
            ok = False; print('  %s: header' % os.path.basename(f))
        ends = [c[0] for c in cols[1:]] + [len(d)]
        for (o, length, typ, num), e in zip(cols, ends):
            ctypes[typ] += 1
            if o + length > e: ok = False; print('  %s: collection %#x overruns' % (os.path.basename(f), typ))
    print('census:', dict(st))
    print('TRK sub-block types (occurrences):', {hex(k): v for k, v in sorted(types.items())})
    print('COL collection types (files):', {hex(k): v for k, v in sorted(ctypes.items())})
    print('problems:', 'none' if ok else 'see above')


def main():
    cmd = sys.argv[1]
    if cmd == 'census':
        census(sys.argv[2]); return
    d = open(sys.argv[2], 'rb').read()
    if cmd == 'trk':
        t = Trk(d)
        print('TRAC v%d  MaxMetaChunkSize %#x  MaxChunkSize %#x  +10 %#x  +14 %#x  meta %d  chunks %d'
              % (t.version, t.maxMetaChunkSize, t.maxChunkSize, t.h10, t.h14, t.metaCount, t.chunkCount))
        for ci, c, s1, s2, blocks in t.chunks():
            cx, cy, cz = (v / 65536 for v in t.centers[ci])
            print('  chunk %3d @%#x size %#x centre (%.1f, %.1f, %.1f): %s' % (
                ci, c, s1, cx, cy, cz, ' '.join('%x:%d' % (typ, num) for so, l, typ, num in blocks)))
    elif cmd == 'col':
        magic, version, size, cols = parse_col(d)
        print(magic, 'v%d' % version, 'size', size)
        for o, length, typ, num in cols:
            print('  @%#x type %#x %-24s num %d length %d' % (o, typ, COL_NAMES.get(typ, ''), num, length))


if __name__ == '__main__':
    main()
