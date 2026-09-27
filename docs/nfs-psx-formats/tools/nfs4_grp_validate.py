#!/usr/bin/env python3
"""Validate decoded NFS4 GRP semantics against every chunk of every file.
Each check encodes one claim from the loader/renderer (see formats/NFS4_TRACK_GRP.md)."""
import struct, sys, glob, os, collections
sys.path.insert(0, os.path.dirname(__file__))
import nfs4_grp as G

def payload(b, g): return b[g['off']+16 : g['off']+g['length']]

def check_file(fn, stats):
    b, out = G.parse(fn)
    groups = out['groups']
    fails = collections.Counter()
    mats = [g for g in groups if g['type'] == 0x02][0]
    nmat = (mats['length'] - 16) // 10
    # children of each chunk
    chunks = [g for g in groups if g['type'] == 0x1d and g['depth'] == 1]
    first_slice_expect = 0
    for ci, ch in enumerate(chunks):
        kids = [g for g in groups if g['path'][:2] == [0x1e, 0x1d] and g['off'] > ch['off'] and g['off'] < ch['off'] + ch['length']]
        by = collections.defaultdict(list)
        for k in kids: by[k['type']].append(k)
        meta = payload(b, by[0x1c][0])
        firstSlice, chunkInd = struct.unpack_from('<hh', meta, 10)
        if chunkInd != ci: fails['chunkInd!=index'] += 1
        if firstSlice != first_slice_expect: fails['firstSimSliceInd!=running_sum'] += 1
        ns = by[0x06][0]['n'] if by[0x06] else 0
        if by[0x06] and (by[0x06][0]['length'] - 16) < 5 * ns: fails['simSlice_short'] += 1
        first_slice_expect += ns
        vtx = by[0x18][0]; nv = (vtx['length'] - 16) // 8
        stats['vtx_n_vs_count'][(vtx['n'] == nv)] += 1
        stats['max_verts'] = max(stats['max_verts'], nv)
        qc = struct.unpack_from('<6B', payload(b, by[0x1b][0]), 12)[::1]
        qc = [payload(b, by[0x1b][0])[12 + 2*i] for i in range(6)]
        # strips (full + lorez)
        for st in (0x1a, 0x25):
            for sg in by[st]:
                p = payload(b, sg); o = 0
                for s in range(sg['n']):
                    top, bot, qn, size = p[o], p[o+1], p[o+2], p[o+3]
                    if size != 4 + 2*qn and size != ((4 + 2*qn + 3) & ~3): fails[f'{st:#x}_size'] += 1
                    stats['strip_size_pad'][size - (4 + 2*qn)] += 1
                    if top + qn >= nv or bot + qn >= nv: fails[f'{st:#x}_vert_oob'] += 1
                    for q in range(qn):
                        m = struct.unpack_from('<h', p, o + 4 + 2*q)[0]
                        if not (0 <= m < nmat): fails[f'{st:#x}_mat_oob'] += 1
                    o += size
                if o != len(p) and (len(p) - o) > 3: fails[f'{st:#x}_tail'] += 1
        # render quads partitions
        rq = by[0x19][0] if by[0x19] else None
        nrq = (rq['length'] - 16) // 6 if rq else 0
        if nrq != qc[0] + qc[1] + qc[4] + qc[5]: fails['renderQuads!=qc0+1+4+5'] += 1
        for t, idx, vsrc in ((0x28, 2, 0x27), (0x29, 3, 0x27)):
            g = by[t][0] if by[t] else None
            n = (g['length'] - 16) // 6 if g else 0
            if n != qc[idx]: fails[f'{t:#x}!=qc{idx}'] += 1
        def chkquads(g, nverts, tag):
            p = payload(b, g)
            for q in range((len(p)) // 6):
                m, a0, a1, a2, a3 = struct.unpack_from('<h4B', p, q*6)
                if not (0 <= m < nmat): fails[tag + '_mat_oob'] += 1
                if max(a0, a1, a2, a3) >= nverts: fails[tag + '_vert_oob'] += 1
        if rq: chkquads(rq, nv, 'rq')
        nov = (by[0x27][0]['length'] - 16) // 8 if by[0x27] else 0
        for t in (0x28, 0x29):
            if by[t]: chkquads(by[t][0], nov, f'{t:#x}')
        # vis list
        if by[0x04]:
            vg = by[0x04][0]; p = payload(b, vg)
            for k in range(vg['n']):
                v = struct.unpack_from('<H', p, 2*k)[0]
                if (v & 0x3ff) >= len(chunks): fails['vis_oob'] += 1
                stats['vis_cat'][v >> 10] += 1
            stats['vis_len'][min(vg['n'], 40)] += 1
    return fails, len(chunks)

if __name__ == '__main__':
    stats = dict(vtx_n_vs_count=collections.Counter(), max_verts=0, strip_size_pad=collections.Counter(),
                 vis_cat=collections.Counter(), vis_len=collections.Counter())
    total = collections.Counter(); nch = 0
    for fn in sorted(glob.glob(os.path.join(sys.argv[1], '*.GRP'))):
        f, n = check_file(fn, stats); nch += n
        total.update(f)
        print(f"{os.path.basename(fn):<12} chunks={n:<4} " + ('OK' if not f else str(dict(f))))
    print('\nTOTAL chunks', nch, 'failures', dict(total) or 'none')
    print('vertex group n == payload/8 :', dict(stats['vtx_n_vs_count']), ' max verts/chunk', stats['max_verts'])
    print('strip size - (4+2*quads)    :', dict(stats['strip_size_pad']))
    print('vis category (v>>10)        :', dict(sorted(stats['vis_cat'].items())))
    print('vis list length histogram   :', dict(sorted(stats['vis_len'].items())))
