#!/usr/bin/env python3
"""NFS4 PSX .GRP (SerializedGroup) walker -- follows the retail loader semantics.

Loader authority (nfs4-decomp recon):
  group.cpp   SerializedGroup::LocateGroupType / LocateNextGroupType / CreateLiteGroup
  track.cpp   Track_Init, Track_InitPersistentData
  chunk.cpp   Chunk::InstanceGroup
Header = 16 bytes LE: m_type, m_length (incl. header), dummy, m_num_elements.
Children of a container start at +16 and are laid out back to back; the loader
rounds m_length up to a multiple of 4 while walking (group.cpp LocateGroupType).
"""
import struct, sys, os, collections, json

CONTAINERS = {0x1e, 0x1d, 0x21, 0x17}          # root, chunk, persistent, chunk-geometry
NAMES = {
    0x1e: 'root', 0x1f: 'TrackHeader', 0x20: 'chunkCenters', 0x21: 'persistent',
    0x23: 'lightTable', 0x1d: 'chunk', 0x1c: 'chunkMeta', 0x03: 'objInstances',
    0x0b: 'simObjects', 0x15: 'objSpecialInstances', 0x0a: 'sfx', 0x05: 'simQuads',
    0x06: 'simSlices', 0x09: 'lines', 0x04: 'visList', 0x17: 'geometry',
    0x1b: 'quadCounts', 0x19: 'renderQuads', 0x1a: 'strips', 0x25: 'lorezStrips',
    0x18: 'vertices', 0x27: 'objVertices', 0x28: 'objQuads', 0x29: 'objQuadInstances',
    0x02: 'materials', 0x0f: 'bworldSm', 0x24: 'midgroundObjInst', 0x07: 'objInst',
    0x08: 'objDefs', 0x26: 'objDefOffsets',
}

def hdr(b, o):
    return struct.unpack_from('<iiIi', b, o)

def walk(b, o, end, depth, path, out):
    """Walk sibling groups in [o, end); recurse into containers."""
    while o + 16 <= end:
        t, ln, dummy, n = hdr(b, o)
        if ln < 16:
            out['errors'].append(f'bad length {ln} at 0x{o:x} ({path})'); return
        ln4 = (ln + 3) & ~3
        rec = dict(off=o, type=t, length=ln, dummy=dummy, n=n, path=path, depth=depth)
        out['groups'].append(rec)
        if t in CONTAINERS:
            walk(b, o + 16, o + ln, depth + 1, path + [t], out)
        o += ln4

def parse(fn):
    b = open(fn, 'rb').read()
    out = dict(file=os.path.basename(fn), size=len(b), groups=[], errors=[])
    walk(b, 0, len(b), 0, [], out)
    return b, out

def census(files):
    per = collections.defaultdict(lambda: dict(groups=0, elems=0, payload=0, ratios=collections.Counter(), parents=collections.Counter(), dummies=collections.Counter()))
    tops = collections.Counter()
    for fn in files:
        b, out = parse(fn)
        for e in out['errors']: print('ERR', out['file'], e)
        tops[tuple(g['type'] for g in out['groups'] if g['depth'] == 0)] += 1
        for g in out['groups']:
            p = per[g['type']]; p['groups'] += 1; p['elems'] += g['n']; pay = g['length'] - 16; p['payload'] += pay
            p['parents'][g['path'][-1] if g['path'] else None] += 1
            p['dummies'][g['dummy']] += 1
            if g['n'] > 0 and g['type'] not in CONTAINERS:
                p['ratios'][round(pay / g['n'], 2)] += 1
    print('top-level sequences:', {tuple(hex(x) for x in k): v for k, v in tops.items()})
    print(f"{'type':>6} {'name':<20} {'groups':>6} {'elems':>8} {'payload':>9}  parents  bytes/elem (top)  dummy")
    for t in sorted(per):
        p = per[t]
        r = ', '.join(f'{k}x{v}' for k, v in p['ratios'].most_common(4))
        par = ','.join(hex(k) if k is not None else '-' for k in p['parents'])
        dm = ','.join(hex(k) for k in p['dummies'])
        print(f"0x{t:02x}   {NAMES.get(t,'?'):<20} {p['groups']:>6} {p['elems']:>8} {p['payload']:>9}  {par:<8} {r}  [{dm}]")

if __name__ == '__main__':
    args = sys.argv[1:]
    if args and args[0] == 'census':
        census(args[1:])
    else:
        b, out = parse(args[0])
        for g in out['groups']:
            print('  ' * g['depth'] + f"0x{g['type']:02x} {NAMES.get(g['type'],'?'):<18} len={g['length']:<7} n={g['n']:<6} @0x{g['off']:x}")
        for e in out['errors']: print('ERR', e)
