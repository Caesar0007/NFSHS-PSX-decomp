#!/usr/bin/env python3
"""NFS4 PSX .PSH (SHPP/GIMX shape file) reader -- follows the retail routines:
  shapecount / shapepointer / shapename  eaclib/psx/eacpsxz/shpsubs.c
  shapedepth                              eaclib/psx/eacpsxz/shpdepth.c
  block chain / CLUT lookup               eaclib/psx/eacpsxz/shpclut.c
  upload (stride, palette = next block)   game/psx/texture.cpp Texture_LoadPmx / Texture_Vramcf
Packed files (.QPS, or any Q-packed PSH) are unpacked first with nfs4_codecs.

  python nfs4_psh.py info   <file>             list shapes and blocks
  python nfs4_psh.py png    <file> <outdir>    export every shape as PNG (needs Pillow)
  python nfs4_psh.py census <dir>              validate every PSH/QPS in a directory
"""
import os, sys, glob, struct, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import nfs4_codecs

DEPTH = {0x41: 8, 0x40: 4, 0x42: 16, 0x23: 16, 0x44: 1, 0x43: 24, 0x72: 8}


def depth(t):
    return DEPTH.get(t & 0x77, 1)


def load(path):
    d = open(path, 'rb').read()
    if nfs4_codecs.unpacksize(d):
        d = nfs4_codecs.unpack(d)
    return d


def parse(d):
    if d[:4] != b'SHPP':
        raise ValueError('not SHPP')
    total, count = struct.unpack_from('<Ii', d, 4)
    tag = d[12:16]
    shapes = []
    for i in range(count):
        name = d[0x10 + 8 * i:0x14 + 8 * i]
        off = struct.unpack_from('<i', d, 0x14 + 8 * i)[0]
        blocks = []
        o = off
        while True:
            word = struct.unpack_from('<I', d, o)[0]
            t = word & 0xFF
            nxt = word >> 8
            w, h, cx, cy, packed = struct.unpack_from('<hhhhI', d, o + 4)
            blocks.append(dict(off=o, type=t, next=nxt, w=w, h=h, cx=cx, cy=cy, packed=packed))
            if nxt == 0:
                break
            o += nxt
        shapes.append(dict(index=i, name=name, off=off, blocks=blocks))
    return dict(total=total, count=count, tag=tag, shapes=shapes, size=len(d))


def image_info(b):
    """Image block: bpp code = type & 3; row stride padded to 16 bits (Texture_Vramcf)."""
    bits = b['w'] * depth(b['type'])
    stride = ((bits + 15) & ~15) >> 3
    return stride, stride * b['h']


def c1555(v):
    r = (v & 0x1F) << 3; g = ((v >> 5) & 0x1F) << 3; bl = ((v >> 10) & 0x1F) << 3
    a = 0 if v == 0 else 255          # PSX: colour 0x0000 is transparent
    return (r, g, bl, a)


def to_rgba(d, shape):
    img = shape['blocks'][0]
    stride, size = image_info(img)
    px = d[img['off'] + 16: img['off'] + 16 + size]
    code = img['type'] & 3
    w, h = img['w'], img['h']
    pal = None
    if code in (0, 1) and len(shape['blocks']) > 1:
        cb = shape['blocks'][1]
        n = 16 if code == 0 else 256
        pal = [c1555(struct.unpack_from('<H', d, cb['off'] + 16 + 2 * k)[0]) for k in range(n)]
    out = []
    for y in range(h):
        row = px[y * stride:(y + 1) * stride]
        for x in range(w):
            if code == 0:
                idx = (row[x >> 1] >> (4 * (x & 1))) & 0xF; out.append(pal[idx] if pal else (idx * 17,) * 3 + (255,))
            elif code == 1:
                idx = row[x]; out.append(pal[idx] if pal else (idx, idx, idx, 255))
            else:
                out.append(c1555(struct.unpack_from('<H', row, 2 * x)[0]))
    return w, h, out


def census(dirpath):
    st = collections.Counter(); btypes = collections.Counter(); problems = []
    files = [f for f in sorted(glob.glob(os.path.join(dirpath, '*')))
             if os.path.isfile(f) and os.path.splitext(f)[1].upper() in ('.PSH', '.QPS')]
    for f in files:
        name = os.path.basename(f)
        d = load(f)
        try:
            p = parse(d)
        except Exception as e:
            problems.append((name, 'parse: ' + str(e))); continue
        st['files'] += 1; st['shapes'] += p['count']
        if p['total'] != len(d):
            st['header size != file size'] += 1
        if p['tag'] != b'GIMX':
            st[f"tag {p['tag']}"] += 1
        for s in p['shapes']:
            img = s['blocks'][0]
            btypes[('image', img['type'])] += 1
            for b in s['blocks'][1:]:
                btypes[('chained', b['type'])] += 1
            stride, size = image_info(img)
            room = (img['next'] if img['next'] else None)
            if room is not None and 16 + size > room:
                problems.append((name, s['index'], f"image {img['w']}x{img['h']} type {img['type']:#x} needs {16 + size} > next {room}"))
            if room is None and img['off'] + 16 + size > len(d):
                problems.append((name, s['index'], 'image runs past EOF'))
            code = img['type'] & 3
            if code in (0, 1):
                if len(s['blocks']) < 2:
                    problems.append((name, s['index'], 'paletted image without palette block'))
                else:
                    cb = s['blocks'][1]
                    need = 16 if code == 0 else 256
                    st['palette block type %#x' % cb['type']] += 1
                    st['palette entries %s' % ('ok' if cb['w'] * cb['h'] >= need else 'short')] += 1
            if img['type'] & 0x80:
                st['image type has bit 0x80 (compressed?)'] += 1
    print('census:', dict(st))
    print('block types:', dict(sorted(btypes.items())))
    print('problems:', len(problems))
    for p in problems[:15]:
        print('  ', p)


def main():
    cmd = sys.argv[1]
    if cmd == 'census':
        census(sys.argv[2]); return
    d = load(sys.argv[2]); p = parse(d)
    if cmd == 'info':
        print(f"size {p['size']} header-size {p['total']} count {p['count']} tag {p['tag']}")
        for s in p['shapes']:
            desc = ', '.join(f"{b['type']:#04x} {b['w']}x{b['h']}" for b in s['blocks'])
            print(f"  {s['index']:3} {s['name']!r:10} @{s['off']:#x}: {desc}")
    elif cmd == 'png':
        from PIL import Image
        out = sys.argv[3]; os.makedirs(out, exist_ok=True)
        for s in p['shapes']:
            w, h, px = to_rgba(d, s)
            if w <= 0 or h <= 0:
                continue
            im = Image.new('RGBA', (w, h)); im.putdata(px)
            nm = s['name'].decode('latin1').replace('/', '_').replace('\\', '_').replace('!', 'x').replace('#', 'h')
            im.save(os.path.join(out, f"{s['index']:03d}_{nm}.png"))
        print('exported', len(p['shapes']), 'shapes to', out)


if __name__ == '__main__':
    main()
