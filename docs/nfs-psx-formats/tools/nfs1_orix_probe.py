#!/usr/bin/env python3
"""NFS1 PSX `ORIX` models inside Z<track>_POR.FAM: census of the header layout documented in
formats/NFS1_TRACK_FILES.md §2 (oriload = func_80081610, version 800).

Checks per model: version 800; sections contiguous (joints, polygons, UVs, textures, texture numbers, render order, FX/labels, vertices, pool,
end = +4 size + 12); every polygon is a quad (type 0x84 / 0x8C) whose 4 vertex indices are < vertex count; the
single NON-SORT render-order entry lists every polygon once.

  python nfs1_orix_probe.py <dir>
"""
import sys, glob, os, struct, collections


def entries(d, base=0):
    for i in range(struct.unpack_from('<I', d, base + 4)[0]):
        o = struct.unpack_from('<I', d, base + 8 + 4 * i)[0]
        if not o:
            continue
        if d[base + o:base + o + 4] == b'wwww':
            yield from entries(d, base + o)
        else:
            yield base + o


def check(d, B):
    h = struct.unpack_from('<30i', d, B); errs = []
    nv, nuv, np_, ntex, ngrp, nlab, njnt = h[4], h[7], h[9], h[14], h[18], h[23], h[27]   # 0x48 render-order count, 0x5C labels
    if d[B:B + 4] != b'ORIX' or h[2] != 800: errs.append('tag/version')
    chain = [(0x78 + 8 * njnt, h[10]), (h[10] + 16 * np_, h[8]), (h[8] + 8 * nuv, h[15]), (h[15] + 24 * ntex, h[17]), (h[17] + 20 * h[16], h[19]),
             (h[19] + 28 * ngrp, h[22]), (h[22] + 12 * nlab, h[6]), (h[6] + 12 * nv, h[20])]
    if njnt and h[28] != 0x78: errs.append('joint table')
    if any(a != b for a, b in chain): errs.append('section chain %r' % chain)
    pool = struct.unpack_from('<%di' % ((h[1] + 12 - h[20]) // 4), d, B + h[20])
    polys = [struct.unpack_from('<BBHiii', d, B + h[10] + 16 * i) for i in range(np_)]
    for t, fl, tex, k, va, ua in polys:
        if t not in (0x84, 0x8C) or k != 12 or tex >= ntex or any(not 0 <= v < nv for v in pool[va:va + 4]):
            errs.append('polygon'); break
    name, start, cnt, z = struct.unpack_from('<16s3i', d, B + h[19])
    if ngrp != 1 or name.rstrip(b'\0') != b'NON-SORT' or sorted(pool[start:start + cnt]) != list(range(np_)):
        errs.append('group')
    return errs, np_, collections.Counter((t, fl) for t, fl, *_ in polys)


def main(dirpath):
    n = quads = 0; kinds = collections.Counter(); ok = True
    for f in sorted(glob.glob(os.path.join(dirpath, 'Z*_POR.FAM'))):
        d = open(f, 'rb').read()
        for B in entries(d):
            errs, q, k = check(d, B); n += 1; quads += q; kinds.update(k)
            for e in errs:
                print('  %s+%x: %s' % (os.path.basename(f), B, e))
            ok &= not errs
    print('ORIX models %d, quads %d, (type, flags) %s' % (n, quads, dict(kinds)))
    print('problems:', 'none' if ok else 'see above')


if __name__ == '__main__':
    main(sys.argv[1])
