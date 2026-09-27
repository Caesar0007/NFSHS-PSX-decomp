#!/usr/bin/env python3
"""Compare an nfs3_track_probe.py dump with the file-spec predictions (NFS3_TRACK_FILES.md).

  python compare_nfs3_chunks.py <probe outdir> <ZZZTR..TRK> [<ZTR..COL>]

Checks: TRK header + StmChunkF/StmCenter/StmMetaI tables; each captured chunk's stream-buffer source
== the file bytes; the loaded (copied + relocated) chunk == file bytes after the predicted relocation
(bound points minus the chunk centre; chunk and object-definition vertices x/y/z >> 2; the first n0
chunk vertices re-based from the next chunk's centre); every Chunk_tChunkDat slot == the pointer
the parser predicts; the loaded COL buffer vs the file.
"""
import os, sys, json, struct, collections
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
import nfs3_trk  # noqa: E402

TYPES_SLOTS = {0x08: 8, 0x0C: 7, 0x10: 0x14, 0x14: 0x12, 0x18: 0x13, 0x1C: 6, 0x20: 0xD, 0x24: 5,
               0x28: 0xB, 0x2C: 0x11, 0x30: 0xA}


def predict_loaded(t, c, size, centre):
    d = bytearray(t.d[c:c + size])
    for k in range(4):                                   # bound points (func_80079F4C)
        for ax in range(3):
            o = 0x10 + 12 * k + 4 * ax
            v = struct.unpack_from('<i', d, o)[0] - centre[ax]
            struct.pack_into('<i', d, o, v)
    g = nfs3_trk.geometry(t.d, c)
    vb = g['vbase'] - c
    for i in range(g['nv']):                             # vertices >> 2 (arithmetic)
        for ax in range(3):
            o = vb + 8 * i + 2 * ax
            struct.pack_into('<h', d, o, struct.unpack_from('<h', d, o)[0] >> 2)
    ci = next(i for i, cc, *_ in t.chunks() if cc == c)  # seam vertices: first n0 re-based from the
    nxt = t.centers[(ci + 1) % t.chunkCount]              # next chunk's centre (wraps to chunk 0)
    for ax in range(3):
        dd = nxt[ax] - centre[ax]
        delta = (dd + (dd >> 7)) >> 10
        for i in range(g['n'][0]):
            o = vb + 8 * i + 2 * ax
            v = (struct.unpack_from('<h', d, o)[0] + delta) & 0xFFFF
            struct.pack_into('<H', d, o, v)
    for ci, cc, s1, s2, blocks in t.chunks():            # object-definition vertices >> 2 as well
        if cc != c: continue
        for so, length, typ, num in blocks:
            if typ != 8: continue
            q = so + 8
            for k in range(num):
                sz, nv, nq = struct.unpack_from('<IHH', d, q)
                for i in range(nv):
                    for ax in range(3):
                        o = q + 8 + 8 * i + 2 * ax
                        struct.pack_into('<h', d, o, struct.unpack_from('<h', d, o)[0] >> 2)
                q += sz
    return bytes(d), g


def diff_ranges(a, b):
    out, start = [], None
    for i in range(min(len(a), len(b))):
        if a[i] != b[i]:
            if start is None: start = i
        elif start is not None:
            out.append((start, i)); start = None
    if start is not None: out.append((start, min(len(a), len(b))))
    return out


def region(t, c, off):
    """Name the chunk region an offset falls into."""
    g = nfs3_trk.geometry(t.d, c)
    if off < 0x40: return 'header'
    if off < g['vbase'] - c: return 'geometry header'
    if off < g['vbase'] - c + 8 * g['nv']: return 'vertices'
    if off < 0x40 + g['end']: return 'quad arrays'
    for ci, cc, s1, s2, blocks in t.chunks():
        if cc == c:
            for so, length, typ, num in blocks:
                if so <= off < so + length: return 'type %#x' % typ
    return 'table/pad'


def main():
    outdir, trkf = sys.argv[1], sys.argv[2]
    meta = json.load(open(os.path.join(outdir, 'meta.json')))
    t = nfs3_trk.Trk(open(trkf, 'rb').read())
    res = collections.OrderedDict()
    rb = lambda n: open(os.path.join(outdir, n), 'rb').read()
    res['header'] = rb('trk_header.bin') == t.d[:32]
    n, m = t.metaCount, t.chunkCount
    res['StmChunkF'] = rb('StmChunkF.bin') == t.d[32:32 + 4 * n]
    p = 32 + 4 * n
    res['StmCenter'] = rb('StmCenter.bin') == t.d[p:p + 12 * m]
    res['StmMetaI'] = rb('StmMetaI.bin') == t.d[p + 12 * m:p + 14 * m]
    byidx = {ci: (c, s1) for ci, c, s1, s2, blocks in t.chunks()}
    blocks_of = {ci: blocks for ci, c, s1, s2, blocks in t.chunks()}
    stats = collections.Counter(); residual = collections.Counter()
    for ch in meta['chunks']:
        ci = ch['index']; c, size = byidx[ci]
        tag = 'chunk%03d' % ci
        src, loaded, dat = rb(tag + '_src.bin'), rb(tag + '_loaded.bin'), rb(tag + '_dat.bin')
        stats['src==file' if src == t.d[c:c + size] else 'src!=file'] += 1
        pred, g = predict_loaded(t, c, size, t.centers[ci])
        dr = diff_ranges(pred, loaded)
        stats['loaded==predicted' if not dr else 'loaded differs'] += 1
        for a, b in dr:
            residual[region(t, c, a)] += b - a
        # ChunkDat slots
        base = int(ch['chunkDat'], 16) + 0x58
        slots = struct.unpack_from('<22I', dat)
        exp = {0: base, 4: base + 0x40}
        tb = {typ: so for so, length, typ, num in blocks_of[ci]}
        for off, typ in TYPES_SLOTS.items():
            exp[off] = base + tb[typ] if typ in tb else 0
        for k, (ap, nq) in enumerate(g['arrays']):
            exp[0x34 + 4 * k] = base + (ap - c)
        exp[0x4C] = base + tb[4] + 8
        exp[0x50] = [num for so, length, typ, num in blocks_of[ci] if typ == 4][0]
        exp[0x54] = struct.unpack_from('<h', t.d, c + 10)[0]
        bad = [hex(o) for o, v in exp.items() if slots[o // 4] != (v & 0xFFFFFFFF)]
        stats['ChunkDat slots ok' if not bad else 'ChunkDat slots bad'] += 1
        if bad: print('  %s bad slots %s' % (tag, bad))
    res['chunks'] = dict(stats)
    res['unexplained loaded-vs-predicted bytes by region'] = dict(residual)
    if len(sys.argv) > 3 and os.path.exists(os.path.join(outdir, 'col_loaded.bin')):
        colf = open(sys.argv[3], 'rb').read(); coll = rb('col_loaded.bin')
        dr = diff_ranges(colf, coll)
        res['COL loaded == file'] = not dr and len(colf) == len(coll)
        if dr:
            cols = nfs3_trk.parse_col(colf)[3]
            where = collections.Counter()
            for a, b in dr:
                name = next(('type %#x' % ty for o, l, ty, num in cols if o <= a < o + l), 'header')
                where[name] += b - a
            res['COL differing bytes by collection'] = dict(where)
    for k, v in res.items():
        print('%-45s %s' % (k, v))


if __name__ == '__main__':
    main()
