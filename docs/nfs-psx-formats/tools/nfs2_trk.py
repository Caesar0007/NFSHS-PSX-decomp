#!/usr/bin/env python3
"""NFS2 PSX track containers: ZTR<NN>.TRK ('TRAC' v22) and ZTR<NN>.COL ('COLL' v11).

Same container versions as NFS3, so this reuses the NFS3 walkers/validators in nfs3_trk.py; only the file
naming differs (NFS2: one variant per track, ZTR<NN>.TRK / ZTR<NN>.COL).
Reference disc: PAL SLES-00658 (== nfs2-clean/NFS2-F.EXE after the FRONT.BIN splice).

  python nfs2_trk.py census <dir>           validate every ZTR*.TRK / .COL in a directory
  python nfs2_trk.py trk    <file.TRK>      (as nfs3_trk.py)
  python nfs2_trk.py col    <file.COL>      (as nfs3_trk.py)
"""
import os, sys, glob, struct, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import nfs3_trk as T   # noqa: E402


def quad(d, p):
    """NFS2 quad (8 B) {u16 material, u16 flags, u8 v[4]} -> (material, (v0, v1, v2, v3))."""
    mat, fl, a, b, c, e = struct.unpack_from('<HH4B', d, p)
    return mat, (a, b, c, e)


T.VSIZE, T.QSIZE, T.quad = 6, 8, quad      # NFS2 vertices are 3 x i16 (no colour word)
T.LOD_ONE_PAST = True                     # 21 exporter off-by-one quads (NFS2_TRACK_FILES.md 1.7)


def check_records2(d, name, st):
    """NFS2 records: vis list (4), instances (7/0x12/0x13), object definitions (8), road lines (9)."""
    t = T.Trk(d); errs = []
    for ci, c, s1, s2, blocks in t.chunks():
        tb = {typ: (so, length, num) for so, length, typ, num in blocks}
        g = T.geometry(d, c)
        so, length, num = tb[4]
        v = struct.unpack_from('<%dh' % num, d, c + so + 8)
        if not all(0 <= x < t.chunkCount for x in v) or ci not in v: errs.append('chunk %d vis' % ci)
        for typ in (7, 0x12, 0x13):
            if typ not in tb: continue
            so, length, num = tb[typ]; p = c + so + 8
            for i in range(num):
                size, kind, obj = struct.unpack_from('<HBB', d, p)
                if kind == 3:
                    if size != 8 + 20 * struct.unpack_from('<H', d, p + 4)[0]: errs.append('chunk %d anim inst' % ci)
                elif (kind, size) not in ((1, 16), (4, 20)): errs.append('chunk %d inst kind %d' % (ci, kind))
                p += size; st['instances'] += 1
            if not 0 <= c + so + length - p < 4: errs.append('chunk %d type %#x end' % (ci, typ))
        objs = []
        for typ in (7, 0x12, 0x13):
            if typ in tb:
                so, length, num = tb[typ]; p = c + so + 8
                for i in range(num):
                    size, kind, obj = struct.unpack_from('<HBB', d, p); objs.append(obj); p += size
        if sorted(objs) != list(range(tb[8][2] if 8 in tb else 0)): errs.append('chunk %d instance/def pairing' % ci)
        if 8 in tb:
            so, length, num = tb[8]; p = c + so + 8
            for i in range(num):
                size, nv, nq = struct.unpack_from('<IHH', d, p)
                if size - (8 + 6 * nv + 8 * nq) not in (0, 2): errs.append('chunk %d objdef size' % ci)
                for k in range(nq):
                    if max(quad(d, p + 8 + 6 * nv + 8 * k)[1]) >= nv: errs.append('chunk %d objdef quad' % ci); break
                p += size; st['object defs'] += 1
        if 9 in tb:
            so, length, num = tb[9]; ns = tb[6][2]
            for i in range(num):
                fp, sl, ty, qi = d[c + so + 8 + 4 * i: c + so + 12 + 4 * i]
                if fp >= g['nv'] or sl >= ns or not (ty <= 9 or ty == 0xFF): errs.append('chunk %d line %d' % (ci, i))
            st['road lines'] += num
    for e in errs: print('  %s: %s' % (name, e))
    return not errs


def census(dirpath):
    st = collections.Counter(); types = collections.Counter(); ctypes = collections.Counter()
    ok = True
    for f in sorted(glob.glob(os.path.join(dirpath, 'ZTR[0-9][0-9].TRK'))):
        colf = f[:-4] + '.COL'
        mats = sl = None
        if os.path.exists(colf):
            cols = T.parse_col(open(colf, 'rb').read())[3]
            mats = next((n for o, l, ty, n in cols if ty == 2), None)
            sl = next((n for o, l, ty, n in cols if ty == 0xF), None)
        ok &= T.check_trk(open(f, 'rb').read(), os.path.basename(f), st, types, mats, sl)
    for f in sorted(glob.glob(os.path.join(dirpath, 'ZTR[0-9][0-9].COL'))):
        d = open(f, 'rb').read()
        magic, version, size, cols = T.parse_col(d)
        st['col files'] += 1
        if magic != b'COLL' or version != 11 or size != len(d):
            ok = False; print('  %s: header' % os.path.basename(f))
        ends = [c[0] for c in cols[1:]] + [len(d)]
        for (o, length, typ, num), e in zip(cols, ends):
            ctypes[typ] += 1
            if o + length > e: ok = False; print('  %s: collection %#x overruns' % (os.path.basename(f), typ))
    for f in sorted(glob.glob(os.path.join(dirpath, 'ZTR[0-9][0-9].TRK'))):
        ok &= check_records2(open(f, 'rb').read(), os.path.basename(f), st)
    st['quads using untransformed vertices (known)'] = T.ONE_PAST[0]
    print('census:', dict(st))
    print('TRK sub-block types (occurrences):', {hex(k): v for k, v in sorted(types.items())})
    print('COL collection types (files):', {hex(k): v for k, v in sorted(ctypes.items())})
    print('problems:', 'none' if ok else 'see above')


def main():
    cmd = sys.argv[1]
    if cmd == 'census':
        census(sys.argv[2])
    else:
        T.main()


if __name__ == '__main__':
    main()
