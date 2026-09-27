#!/usr/bin/env python3
"""Compare a runtime Track_Init() RAM dump (nfs4_track_probe.py) against what the file spec predicts.

Every prediction is computed from the pristine .GRP with the loader rules in
formats/NFS4_TRACK_GRP.md, including the two retail quirks (1024-byte light copy, 64-byte vis rows).
Usage: python compare_track_init.py <dumpdir> <path-to-GRP>
"""
import os, sys, json, struct
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))
import nfs4_grp as G

def main():
    dd, grp = sys.argv[1], sys.argv[2]
    rd = lambda n: open(os.path.join(dd, n + '.bin'), 'rb').read()
    b, out = G.parse(grp); gs = out['groups']
    top = lambda t: [g for g in gs if g['type'] == t][0]
    pay = lambda g: b[g['off'] + 16: g['off'] + g['length']]
    res = []
    def chk(name, ok, detail=''):
        res.append((name, ok)); print(f"{'PASS' if ok else 'FAIL'}  {name} {detail}")

    chk('TrackHeader == file 0x1F payload', rd('header') == pay(top(0x1F)))
    chk('chunk centers == file 0x20 payload', rd('chunkCenters') == pay(top(0x20)))
    chk('slices == file 0x0F payload', rd('slices') == pay(top(0x0F)))
    lt = top(0x23)
    N = (lt['length'] - 16) // 4
    chk('light table entries == file 0x23 payload (the 1024-byte copy then overruns EOF into heap)',
        rd('lightTable')[:4 * N] == pay(lt),
        f"({N} entries; group ends at EOF: {lt['off'] + lt['length'] == len(b)}; {1024 - 4 * N} bytes of heap copied)")

    chunks = [g for g in gs if g['type'] == 0x1D]
    n = len(chunks)
    cl = rd('chunkList'); vc = rd('inViewCount'); vl = bytearray(n * 0x48)
    meta_ok = qc_ok = 0
    exp_counts = []
    for i, ch in enumerate(chunks):
        kids = {}
        for g in gs:
            if ch['off'] < g['off'] < ch['off'] + ch['length']:
                kids.setdefault(g['type'], g)
        meta = pay(kids[0x1C]); c = cl[i * 0x70:(i + 1) * 0x70]
        # Chunk: boundPts[4]+chunkboundPts[4] (32) | quadCounts[6] | pad[2] | 16 ptrs | firstSimSliceInd, chunkInd | vertexBuf
        if c[0:32] == meta[16:48] and c[0x68:0x6C] == meta[10:14]:
            meta_ok += 1
        qd = pay(kids[0x1B])
        if list(c[32:38]) == [qd[12 + 2 * k] for k in range(6)]:
            qc_ok += 1
        # visibility, exactly as Track_Init does it (rows at i<<6, up to 36 entries, 0x3FF pad)
        v = pay(kids[0x04]); cnt = min(kids[0x04]['n'], 36)
        ents = [struct.unpack_from('<H', v, 2 * k)[0] for k in range(cnt)]
        ents = [e for e in ents if (e & 0x3FF) < n]
        exp_counts.append(len(ents))
        row = ents + [0x3FF] * (36 - len(ents))
        for k, e in enumerate(row):
            struct.pack_into('<H', vl, (i << 6) + 2 * k, e)
    chk('Chunk.boundPts/chunkboundPts/firstSimSliceInd/chunkInd from 0x1C meta', meta_ok == n, f'({meta_ok}/{n})')
    chk('Chunk.quadCounts = low bytes of 0x1B s[6..11]', qc_ok == n, f'({qc_ok}/{n})')
    chk('Track_gInViewCount = filtered, clamped vis count', list(vc) == exp_counts)
    live = rd('inViewList'); span = (n - 1) * 64 + 72   # rows at 64-byte stride; alloc is n*72
    chk('Track_gInViewList == simulated 64-byte-stride write (incl. 36-entry overlap)',
        live[:span] == bytes(vl[:span]), f'(written span {span} of {n * 0x48} allocated)')
    over = sum(1 for x in exp_counts if x > 32)
    print(f'chunks with >32 visible entries (overlap bug active): {over}')
    print(f"\n{sum(ok for _, ok in res)}/{len(res)} checks passed")

if __name__ == '__main__':
    main()
