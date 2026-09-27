#!/usr/bin/env python3
"""NFS3 PSX track containers: ZZZTR<NN><v>.TRK ('TRAC') and ZTR<NN><v>.COL ('COLL').

Follows the retail loaders (NFS3 SLUS-006.20, raw oracle nfs3-clean/nfs3-raw-L.txt):
  TRK header + tables     func_800C370C (header read, 'TRAC' + version 0x16 check, StmChunkF /
                          StmCenter / StmMetaI tables), accessors func_8009E694..8009E800
  meta-chunk streaming    func_80079C58 -> func_800C3990 (seek StmChunkF[meta], read MaxMetaChunkSize)
  chunk binder            func_8007A198 (sub-block lookup func_8009E870(chunk, type))
  COL                     func_80068018 (collection dispatch on type)
  census also checks      chunk meta (+0xA first sim slice, +0xC index), LOD vertex nesting, geometry size,
                          quad vertex/material bounds, type 5 = q4, sim slices partition q4, slice total = COL,
                          slice links, type-5 frame < type-0xD count, 0xA/0x11/9 sizes, flare types < 17;
                          .CCM cameras, T{F,B}.BIN tutor prompts, .COP triggers

  python nfs3_trk.py trk    <file.TRK>      header, tables, per-chunk sub-block list
  python nfs3_trk.py col    <file.COL>      collection list
  python nfs3_trk.py census <dir>           validate every TRK/COL in a directory
"""
import os, sys, glob, struct, collections

# Geometry record layout (NFS3 defaults; nfs2_trk.py overrides): vertex size, quad size, quad decoder.
VSIZE, QSIZE = 8, 6
LOD_ONE_PAST = False
ONE_PAST = [0]   # NFS2: tolerate (and count) quads indexing file vertices not transformed at their level


def quad(d, p):
    """NFS3 Trk_Quad {u16 material, u8 v[4]} -> (material, (v0, v1, v2, v3))."""
    mat, a, b, c, e = struct.unpack_from('<H4B', d, p)
    return mat, (a, b, c, e)


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


def geometry(d, c):
    """Geometry header at chunk+0x40 (func_8009E850 / func_8007A198; NFS4 keeps it as group 0x1B):
    u32 offset of the sub-block table (rel. to +0x40); u16 vertex counts n0 <= n1 <= n2 <= n3 (LOD prefixes,
    n0 added to each); u16 quad counts q[6]; vertices (8 B) at +0x18; then the six quad arrays (6 B)."""
    g = c + 0x40
    rel, n0, n1, n2, n3 = struct.unpack_from('<I4H', d, g)
    q = struct.unpack_from('<6H', d, g + 12)
    vbase = g + 0x18
    nv = n0 + n3
    arrays, p = [], vbase + VSIZE * nv
    for n in q:
        arrays.append((p, n)); p += QSIZE * n
    return dict(rel=rel, n=(n0, n1, n2, n3), q=q, vbase=vbase, nv=nv, arrays=arrays, end=p - g)


def check_records(d, t, errs, materials, slices=None):
    run = 0
    for ci, c, s1, s2, blocks in t.chunks():
        tb = {typ: (so, length, num) for so, length, typ, num in blocks}
        first, idx, pad = struct.unpack_from('<hhh', d, c + 10)
        if first != run or idx != ci or pad != 0: errs.append('chunk %d meta' % ci)
        g = geometry(d, c)
        n0, n1, n2, n3 = g['n']
        if not (n0 <= n1 <= n2 <= n3): errs.append('chunk %d LOD vertex counts' % ci)
        if not (0 <= g['rel'] - g['end'] <= 3): errs.append('chunk %d geometry size' % ci)
        lim = [n0 + n1, n0 + n1, n0 + n2, n0 + n2, n0 + n3, n0 + n3]
        for k, (p, n) in enumerate(g['arrays']):
            for i in range(n):
                mat, vv = quad(d, p + QSIZE * i)
                if LOD_ONE_PAST and lim[k] <= max(vv) < n0 + n3 and k < 4 and (materials is None or mat < materials):
                    ONE_PAST[0] += 1; continue
                if max(vv) >= lim[k] or (materials is not None and mat >= materials):
                    errs.append('chunk %d array %d quad %d' % (ci, k, i)); break
        if tb[5][2] != g['q'][4]: errs.append('chunk %d type 5 count' % ci)
        so, length, num = tb[6]; nxt = 0
        for i in range(num):
            fq, qc = struct.unpack_from('<HB', d, c + so + 8 + 8 * i)
            if fq != nxt: errs.append('chunk %d sim slice %d' % (ci, i))
            nxt = fq + qc
        if nxt != g['q'][4]: errs.append('chunk %d sim slices do not cover q4' % ci)
        for i in range(num):                              # links: -1 or a valid global slice
            for ln in struct.unpack_from('<hh', d, c + so + 12 + 8 * i):
                if ln != -1 and (slices is not None and not 0 <= ln < slices):
                    errs.append('chunk %d sim slice %d link %d' % (ci, i, ln))
        nd = tb[0xD][2]
        so5 = tb[5][0]
        if any(d[c + so5 + 8 + 2 * i] >= nd for i in range(tb[5][2])): errs.append('chunk %d type 5 frame' % ci)
        for typ, recsize in ((0xA, 16), (0x11, 16), (9, 4)):
            if typ in tb and tb[typ][1] < 8 + recsize * tb[typ][2]: errs.append('chunk %d type %#x size' % (ci, typ))
        if 0xA in tb:                                     # flare types index the 17-entry table
            if any(struct.unpack_from('<H', d, c + tb[0xA][0] + 20 + 16 * i)[0] >= 17 for i in range(tb[0xA][2])):
                errs.append('chunk %d flare type' % ci)
        run += num
    return run


def check_trk(d, name, st, types, materials=None, slices=None):
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
    nsl = check_records(d, t, errs, materials, slices)
    if slices is not None and nsl != slices: errs.append('sim slices %d != COL slices %d' % (nsl, slices))
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
        v = os.path.basename(f)[5:8]
        colf = os.path.join(dirpath, 'ZTR%s.COL' % v)
        mats = sl = None
        if os.path.exists(colf):
            cols = parse_col(open(colf, 'rb').read())[3]
            mats = next((n for o, l, ty, n in cols if ty == 2), None)
            sl = next((n for o, l, ty, n in cols if ty == 0xF), None)
        ok &= check_trk(open(f, 'rb').read(), os.path.basename(f), st, types, mats, sl)
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
    ok &= census_extras(dirpath, st)
    print('census:', dict(st))
    print('TRK sub-block types (occurrences):', {hex(k): v for k, v in sorted(types.items())})
    print('COL collection types (files):', {hex(k): v for k, v in sorted(ctypes.items())})
    print('problems:', 'none' if ok else 'see above')


COP_SIZE = {1: 20, 2: 20, 3: 72}                          # func_8005AB1C
COP_TRACK = {0: '00A', 1: '01A', 2: '02A', 3: '03A', 4: '04A', 16: '00B', 17: '01B', 19: '03B', 20: '04B'}


def col_slices(dirpath, var):
    cols = parse_col(open(os.path.join(dirpath, 'ZTR%s.COL' % var), 'rb').read())[3]
    return next(n for o, l, ty, n in cols if ty == 0xF)


def census_extras(dirpath, st):
    """.CCM cameras, T{F,B}.BIN tutor prompts, .COP triggers (NFS3_TRACK_FILES.md sections 4-6)."""
    ok = True
    for f in sorted(glob.glob(os.path.join(dirpath, '*.CCM'))):
        d = open(f, 'rb').read(); ver, n = struct.unpack_from('<II', d, 0)
        if ver != 1 or len(d) != 8 + 28 * n: ok = False; print('  %s: CCM header' % os.path.basename(f))
        for i in range(n):
            q = struct.unpack_from('<4h', d, 8 + 28 * i + 12)
            if abs(sum(x * x for x in q) ** 0.5 - 0x4000) > 4: ok = False; print('  %s: camera %d quaternion' % (os.path.basename(f), i))
        st['ccm cameras'] += n
    for f in sorted(glob.glob(os.path.join(dirpath, 'ZTR*T[FB].BIN'))):
        b = os.path.basename(f); ns = col_slices(dirpath, b[3:6])
        d = open(f, 'rb').read(); w = struct.unpack('<%di' % (len(d) // 4), d)
        i = 0; sl = []
        while w[i] != -2:
            j = i + 2
            while w[j] != -1: j += 1
            sl.append(w[i]); i = j + 1
        rising = sl == sorted(sl)
        if i != len(w) - 1 or not all(0 <= x < ns for x in sl) or rising != (b[7] == 'F'):
            ok = False; print('  %s: tutor layout' % b)
        st['tutor prompts'] += len(sl)
    for f in sorted(glob.glob(os.path.join(dirpath, 'ZTR*.COP'))):
        b = os.path.basename(f); ns = col_slices(dirpath, COP_TRACK[int(b[3:5])])
        d = open(f, 'rb').read(); n = struct.unpack_from('<i', d, 0)[0]; p = 4
        for i in range(n):
            t, s_ = struct.unpack_from('<ii', d, p)
            if t not in COP_SIZE or not 0 <= s_ < ns: ok = False; print('  %s: record %d' % (b, i)); break
            p += COP_SIZE[t]
        if p != len(d): ok = False; print('  %s: size' % b)
        st['cop records'] += n
    return ok


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
