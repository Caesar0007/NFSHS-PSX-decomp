#!/usr/bin/env python3
"""Minimal ISO9660 reader for PSX disc images (raw 2352-byte Mode 2 .bin/.img, or 2048-byte .iso).

  psx_iso.py ls  <image>                 list every file (path, LBA, size)
  psx_iso.py get <image> <outdir> [glob] extract files (Form 1 user data; XA/STR Form 2 files are
                                         extracted as raw 2336-byte subheader+data sectors, suffix .raw2336)
"""
import struct, sys, os, fnmatch

class Disc:
    def __init__(self, path):
        self.f = open(path, 'rb'); size = os.path.getsize(path)
        self.raw = size % 2352 == 0 and size % 2048 != 0 or self._probe_raw()
        self.ss = 2352 if self.raw else 2048
    def _probe_raw(self):
        self.f.seek(0); return self.f.read(12) == b'\x00' + b'\xff' * 10 + b'\x00'
    def sector(self, lba):
        self.f.seek(lba * self.ss); s = self.f.read(self.ss)
        if not self.raw: return s, False
        mode = s[15]
        if mode == 1: return s[16:16+2048], False
        form2 = bool(s[18] & 0x20)
        return (s[16:16+2336] if form2 else s[24:24+2048]), form2
    def read(self, lba, size):
        out = bytearray(); n = (size + 2047) // 2048
        for i in range(n): out += self.sector(lba + i)[0][:2048]
        return bytes(out[:size])
    def walk(self, lba=None, size=None, prefix=''):
        if lba is None:
            pvd = self.sector(16)[0]; assert pvd[1:6] == b'CD001', 'no ISO9660 PVD'
            root = pvd[156:156+34]; lba, size = struct.unpack_from('<I', root, 2)[0], struct.unpack_from('<I', root, 10)[0]
        data = self.read(lba, size); o = 0
        while o < len(data):
            ln = data[o]
            if ln == 0: o = (o // 2048 + 1) * 2048; continue
            rec = data[o:o+ln]; flba = struct.unpack_from('<I', rec, 2)[0]; fsz = struct.unpack_from('<I', rec, 10)[0]
            flags = rec[25]; nl = rec[32]; name = rec[33:33+nl]
            if name not in (b'\x00', b'\x01'):
                nm = name.decode('ascii', 'replace').split(';')[0]
                p = prefix + nm
                if flags & 2: yield from self.walk(flba, fsz, p + '/')
                else: yield p, flba, fsz
            o += ln

def main():
    cmd, img = sys.argv[1], sys.argv[2]; d = Disc(img)
    if cmd == 'ls':
        for p, lba, sz in d.walk(): print(f'{lba:>7} {sz:>10} {p}')
    elif cmd == 'get':
        out = sys.argv[3]; pat = sys.argv[4] if len(sys.argv) > 4 else '*'
        n = 0
        for p, lba, sz in d.walk():
            if not fnmatch.fnmatch(p.upper(), pat.upper()): continue
            dst = os.path.join(out, p); os.makedirs(os.path.dirname(dst) or out, exist_ok=True)
            if d.raw and d.sector(lba)[1]:
                with open(dst + '.raw2336', 'wb') as g:
                    for i in range((sz + 2047) // 2048): g.write(d.sector(lba + i)[0])
            else:
                open(dst, 'wb').write(d.read(lba, sz))
            n += 1
        print(f'extracted {n} files -> {out}')

if __name__ == '__main__':
    main()
