#!/usr/bin/env python3
"""Replace files inside a raw (2352-byte Mode 2) PSX disc image, for runtime tests.

  psx_iso_inject.py <image.bin> <out.bin> <dir> [glob]

Every file in <dir> whose name (case-insensitive) exists in the image replaces it: in place when it
fits the sectors the original occupies, otherwise appended at the end of the image with the
directory record re-pointed. Directory records (LBA and size, both byte orders) and the PVD volume
size are patched; every written sector gets a fresh header, the original file's XA subheader, and
recomputed EDC / ECC (ECMA-130, Mode 2 Form 1). Writes <out.cue> next to <out.bin>.
"""
import fnmatch, os, shutil, struct, sys

SS = 2352

_ecc_f = [0] * 256
_ecc_b = [0] * 256
_edc = [0] * 256
for _i in range(256):
    _j = (_i << 1) ^ (0x11D if _i & 0x80 else 0)
    _ecc_f[_i] = _j & 0xFF
    _ecc_b[_i ^ (_j & 0xFF)] = _i
    _e = _i
    for _ in range(8):
        _e = (_e >> 1) ^ (0xD8018001 if _e & 1 else 0)
    _edc[_i] = _e


def edc_compute(data: bytes) -> int:
    edc = 0
    for b in data:
        edc = (edc >> 8) ^ _edc[(edc ^ b) & 0xFF]
    return edc


def ecc_block(src, major_count, minor_count, major_mult, minor_inc, dest, dest_off):
    size = major_count * minor_count
    for major in range(major_count):
        index = (major >> 1) * major_mult + (major & 1)
        ecc_a = ecc_b = 0
        for _ in range(minor_count):
            temp = src[index]
            index += minor_inc
            if index >= size:
                index -= size
            ecc_a ^= temp
            ecc_b ^= temp
            ecc_a = _ecc_f[ecc_a]
        ecc_a = _ecc_b[_ecc_f[ecc_a] ^ ecc_b]
        dest[dest_off + major] = ecc_a
        dest[dest_off + major + major_count] = ecc_a ^ ecc_b


def bcd(v: int) -> int:
    return ((v // 10) << 4) | (v % 10)


def build_sector(lba: int, subheader: bytes, data: bytes) -> bytes:
    """Mode 2 Form 1 sector: sync, header, 8-byte subheader, 2048 data, EDC, ECC."""
    assert len(data) == 2048 and len(subheader) == 8
    s = bytearray(SS)
    s[0:12] = b'\x00' + b'\xff' * 10 + b'\x00'
    m, rest = divmod(lba + 150, 75 * 60)
    sec, frame = divmod(rest, 75)
    s[12:16] = bytes((bcd(m), bcd(sec), bcd(frame), 2))
    s[16:24] = subheader
    s[24:24 + 2048] = data
    struct.pack_into('<I', s, 0x818, edc_compute(bytes(s[0x10:0x818])))
    # ECC over [header(as zeros) + subheader + data + EDC]
    src = bytearray(s[0xC:0x81C])
    src[0:4] = b'\0\0\0\0'
    ecc_block(src, 86, 24, 2, 86, s, 0x81C)      # P parity (86 x 24)
    src = bytearray(s[0xC:0x8C8])                # Q parity covers P as well (52 x 43)
    src[0:4] = b'\0\0\0\0'
    ecc_block(src, 52, 43, 86, 88, s, 0x8C8)
    return bytes(s)


class Image:
    def __init__(self, path):
        self.f = open(path, 'r+b')
        self.size = os.path.getsize(path)
        assert self.size % SS == 0, 'raw 2352-byte image expected'
        self.sectors = self.size // SS

    def raw(self, lba):
        self.f.seek(lba * SS)
        return self.f.read(SS)

    def data(self, lba):
        return self.raw(lba)[24:24 + 2048]

    def read(self, lba, size):
        out = bytearray()
        for i in range((size + 2047) // 2048):
            out += self.data(lba + i)
        return bytes(out[:size])

    def records(self, lba=None, size=None, prefix=''):
        """Yield (path, record_image_offset, lba, size) for every file."""
        if lba is None:
            pvd = self.data(16)
            assert pvd[1:6] == b'CD001'
            lba, size = struct.unpack_from('<I', pvd, 158)[0], struct.unpack_from('<I', pvd, 166)[0]
        n = (size + 2047) // 2048
        for i in range(n):
            sec = self.data(lba + i)
            o = 0
            while o < 2048:
                ln = sec[o]
                if ln == 0:
                    break
                rec = sec[o:o + ln]
                flba, fsz = struct.unpack_from('<I', rec, 2)[0], struct.unpack_from('<I', rec, 10)[0]
                flags, nl = rec[25], rec[32]
                name = rec[33:33 + nl]
                if name not in (b'\x00', b'\x01'):
                    nm = name.decode('ascii', 'replace').split(';')[0]
                    p = prefix + nm
                    if flags & 2:
                        yield from self.records(flba, fsz, p + '/')
                    else:
                        yield p, (lba + i) * SS + 24 + o, flba, fsz
                o += ln

    def write_sector(self, lba, raw):
        self.f.seek(lba * SS)
        self.f.write(raw)

    def patch_record(self, off, lba, size):
        self.f.seek(off + 2)
        self.f.write(struct.pack('<I', lba) + struct.pack('>I', lba) + struct.pack('<I', size) + struct.pack('>I', size))
        # the directory sector's EDC/ECC must follow the change
        sec_lba = off // SS
        raw = bytearray(self.raw(sec_lba))
        self.write_sector(sec_lba, build_sector(sec_lba, bytes(raw[16:24]), bytes(raw[24:24 + 2048])))

    def patch_pvd_size(self, sectors):
        raw = bytearray(self.raw(16))
        struct.pack_into('<I', raw, 24 + 80, sectors)
        struct.pack_into('>I', raw, 24 + 84, sectors)
        self.write_sector(16, build_sector(16, bytes(raw[16:24]), bytes(raw[24:24 + 2048])))


def main():
    src, dst, folder = sys.argv[1:4]
    pattern = sys.argv[4] if len(sys.argv) > 4 else '*'
    shutil.copyfile(src, dst)
    img = Image(dst)
    files = {n.upper(): os.path.join(folder, n) for n in os.listdir(folder) if fnmatch.fnmatch(n.upper(), pattern.upper())}
    end = img.sectors
    done = 0
    for path, rec_off, lba, size in list(img.records()):
        name = path.split('/')[-1].upper()
        if name not in files:
            continue
        data = open(files[name], 'rb').read()
        n_old = (size + 2047) // 2048
        n_new = (len(data) + 2047) // 2048
        sub_first, sub_last = img.raw(lba)[16:24], img.raw(lba + n_old - 1)[16:24]
        if n_new <= n_old:
            new_lba, where = lba, 'in place'
        else:
            new_lba, where = end, f'appended @ {end}'
            end += n_new
        for i in range(n_new):
            chunk = data[2048 * i:2048 * (i + 1)].ljust(2048, b'\0')
            img.write_sector(new_lba + i, build_sector(new_lba + i, sub_last if i == n_new - 1 else sub_first, chunk))
        img.patch_record(rec_off, new_lba, len(data))
        print(f'{path:<24} {size:>8} -> {len(data):>8} bytes, {where}')
        done += 1
    if end != img.sectors:
        img.patch_pvd_size(end)
    img.f.close()
    cue = os.path.splitext(dst)[0] + '.cue'
    open(cue, 'w', newline='\n').write(f'FILE "{os.path.basename(dst)}" BINARY\n  TRACK 01 MODE2/2352\n    INDEX 01 00:00:00\n')
    print(f'{done} files replaced; image {end} sectors; cue {cue}')


if __name__ == '__main__':
    main()
