#!/usr/bin/env python3
"""slink_bytes.py -- are the BYTES right?  a slink_lane.py variant vs retail, function by function, position-independent.

Both images are cut at the map names (.text and front.text).  A function is compared with the retail function of the same
name; words that carry an address (jal / j targets, %hi/%lo pairs, gp offsets) legitimately differ while the layout still
drifts, so words are compared after masking: `j/jal` -> opcode only, `lui`/`addiu`/`ori`/load/store -> immediate dropped.
A function is SAME-SHAPE when all masked words agree and SIZE-DIFF when its length differs.
usage: slink_bytes.py [variant] [--show NAME]"""
import os
import re
import struct
import subprocess
import sys
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
OUT = ROOT / os.environ.get('NFS4_LANE_OUT', 'build/psyq_off')
args = [a for a in sys.argv[1:] if not a.startswith('--')]
variant = args[0] if args else 'off'
show = sys.argv[sys.argv.index('--show') + 1] if '--show' in sys.argv else None
if show in args:
    args.remove(show)


def cpe_image(path, extra=None):
    d = Path(path).read_bytes()
    assert d[:4] == b'CPE' + bytes([1])
    mem = {}
    p = 4
    while p < len(d):
        t = d[p]; p += 1
        if t == 0:
            break
        if t == 1:
            a, n = struct.unpack_from('<II', d, p)
            mem[a] = d[p + 8:p + 8 + n]; p += 8 + n
        else:
            p += {2: 4, 3: 6, 4: 4, 5: 3, 6: 8, 7: 4, 8: 1}[t]
    return mem


def reader(chunks):
    lo = min(chunks); hi = max(a + len(b) for a, b in chunks.items())
    flat = bytearray(hi - lo)                       # CPE load chunks are small blocks: flatten them
    for a, blob in chunks.items():
        flat[a - lo:a - lo + len(blob)] = blob

    def rd(a, n):
        return bytes(flat[a - lo:a - lo + n])
    return rd


def names(path):
    out = {}
    for m in re.finditer(r'^ ([0-9A-F]{8})  ?(\S+)\s*$', Path(path).read_text(encoding='latin-1'), re.M):
        out.setdefault(m.group(2).replace('_._', '___'), int(m.group(1), 16))
    return out


def sections(path):
    return {m.group(3): (int(m.group(1), 16), int(m.group(2), 16)) for m in
            re.finditer(r'^ ([0-9A-F]{8}) [0-9A-F]{8} ([0-9A-F]{8}) [0-9A-F]{8} \S+\s+(\S+)\s*$', Path(path).read_text(encoding='latin-1'), re.M)}


def mask(w):
    op = w >> 26
    if op in (2, 3):
        return op << 26
    if op in (9, 13, 15) or 32 <= op <= 46:          # addiu / ori / lui / loads / stores: immediates carry addresses
        return w & 0xFFFF0000
    return w


rom = (ROOT / 'rom/nfs4-f.exe').read_bytes()
ret_rd = lambda a, n: rom[0x800 + a - 0x80010000:0x800 + a - 0x80010000 + n]
mem = cpe_image(OUT / (variant + '.cpe'))
fb = OUT / (variant + '_front.bin')
rmap, omap = 'C:/Temp/nfs4iso/NFS4.MAP', OUT / (variant + '.map')
rn, on = names(rmap), names(omap)
rs, os_ = sections(rmap), sections(omap)
front = fb.read_bytes() if fb.exists() else b''
main_rd = reader(mem)


def our_rd(a, n, sec):
    if sec.startswith('front'):
        off = a - 0x80010000
        return front[off:off + n]
    return main_rd(a, n)


total = same = shape = sized = 0
bad = []
for sec in ('.text', 'front.text'):
    rlo, rsz = rs[sec]; olo, osz = os_[sec]
    # cut both images at the names BOTH maps have, so a piece holds the same functions on both sides (statics included)
    rfun = sorted((a, n) for n, a in rn.items() if rlo <= a < rlo + rsz and n in on)
    ofun = sorted((a, n) for n, a in on.items() if olo <= a < olo + osz and n in rn)
    rend = {n: (rfun[i + 1][0] if i + 1 < len(rfun) else rlo + rsz) for i, (a, n) in enumerate(rfun)}
    oend = {n: (ofun[i + 1][0] if i + 1 < len(ofun) else olo + osz) for i, (a, n) in enumerate(ofun)}
    # aliases share an address: keep one name per address
    seen = set()
    for a, n in rfun:
        if a in seen or n not in on or not (olo <= on[n] < olo + osz):
            continue
        seen.add(a)
        rl, ol = rend[n] - a, oend[n] - on[n]
        if rl <= 0 or ol <= 0:
            continue
        total += 1
        rb, ob = ret_rd(a, rl), our_rd(on[n], ol, sec)
        if rb == ob:
            same += 1; continue
        rw = [mask(w) for w, in struct.iter_unpack('<I', rb[:len(rb) & ~3])]
        ow = [mask(w) for w, in struct.iter_unpack('<I', ob[:len(ob) & ~3])]
        while rw and rw[-1] == 0: rw.pop()
        while ow and ow[-1] == 0: ow.pop()
        if rw == ow:
            shape += 1
        else:
            if len(rw) != len(ow):
                sized += 1
            bad.append((len(ow) - len(rw), sec, n, a, on[n], rl, ol))
print('%s: %d functions compared -- %d byte-identical, %d identical but for addresses, %d DIFFERENT (%d of them differ in length)'
      % (variant, total, same, shape, len(bad), sized))
for d, sec, n, a, oa, rl, ol in sorted(bad, key=lambda r: (-abs(r[0]), r[2]))[:50]:
    print('   %+5d words  %-11s %08X/%08X  %s' % (d, sec, a, oa, n[:70]))
if show:
    B = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
    for d, sec, n, a, oa, rl, ol in bad:
        if n == show:
            for tag, blob, va in (('retail', ret_rd(a, rl), a), ('ours', our_rd(oa, ol, sec), oa)):
                p = ROOT / 'build/tmp/sb.bin'; p.write_bytes(blob)
                t = subprocess.run([B, '-D', '-b', 'binary', '-m', 'mips:3000', '-EL', '--adjust-vma=0x%x' % va, str(p)], capture_output=True, text=True).stdout
                print('==', tag)
                for l in t.splitlines():
                    if re.match(r'^\s*[0-9a-f]+:\t', l):
                        print('   ', ' '.join(l.split('\t')[2:]))
