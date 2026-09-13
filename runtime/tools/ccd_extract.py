#!/usr/bin/env python3
"""ccd_extract.py -- read files out of a raw CloneCD PSX image (.IMG, 2352 B/sector).

Identify the disc (SYSTEM.CNF + boot EXE) and optionally extract files.

Usage:
  python runtime/tools/ccd_extract.py <image.IMG>                 # identify
  python runtime/tools/ccd_extract.py <image.IMG> --list          # root listing
  python runtime/tools/ccd_extract.py <image.IMG> --get NAME OUT  # extract file
"""
import hashlib, struct, sys
from pathlib import Path

SECTOR = 2352
USER_OFF = 24          # MODE2/FORM1 user data offset within a raw sector
USER_LEN = 2048

def rd(img, lba, count=1):
    out = bytearray()
    with open(img, 'rb') as f:
        for i in range(count):
            f.seek((lba + i) * SECTOR)
            s = f.read(SECTOR)
            out += s[USER_OFF:USER_OFF + USER_LEN]
    return bytes(out)

def read_extent(img, lba, size):
    data = rd(img, lba, (size + USER_LEN - 1) // USER_LEN)
    return data[:size]

def dir_entries(data):
    i = 0
    while i < len(data):
        n = data[i]
        if n == 0:                       # sector padding: jump to next 2048 boundary
            i = (i // USER_LEN + 1) * USER_LEN
            continue
        rec = data[i:i+n]
        lba = struct.unpack_from('<I', rec, 2)[0]
        size = struct.unpack_from('<I', rec, 10)[0]
        flags = rec[25]
        nlen = rec[32]
        name = rec[33:33+nlen].decode('latin-1').split(';')[0]
        if name not in ('\x00', '\x01'):
            yield name, lba, size, bool(flags & 2)
        i += n

def root_dir(img):
    pvd = rd(img, 16)
    assert pvd[1:6] == b'CD001', 'not an ISO9660 PVD (wrong sector size/offset?)'
    root_rec = pvd[156:156+34]
    lba = struct.unpack_from('<I', root_rec, 2)[0]
    size = struct.unpack_from('<I', root_rec, 10)[0]
    return list(dir_entries(read_extent(img, lba, size)))

def find(img, name):
    for n, lba, size, isdir in root_dir(img):
        if n.upper() == name.upper():
            return lba, size
    return None

def main():
    img = sys.argv[1]
    entries = root_dir(img)
    if '--list' in sys.argv:
        for n, lba, size, isdir in entries:
            print(f'{"DIR " if isdir else "    "}{n:<16} lba={lba:<8} size={size}')
        return
    if '--get' in sys.argv:
        i = sys.argv.index('--get')
        loc = find(img, sys.argv[i+1])
        assert loc, f'{sys.argv[i+1]} not found in root'
        data = read_extent(img, *loc)
        Path(sys.argv[i+2]).write_bytes(data)
        print(f'{sys.argv[i+1]}: {len(data)} bytes -> {sys.argv[i+2]}')
        return
    # identify: SYSTEM.CNF -> BOOT exe -> sha256
    loc = find(img, 'SYSTEM.CNF')
    assert loc, 'SYSTEM.CNF not in root'
    cnf = read_extent(img, *loc).decode('latin-1', 'replace')
    print('--- SYSTEM.CNF ---')
    print(cnf.strip())
    boot = None
    for ln in cnf.splitlines():
        if ln.upper().startswith('BOOT'):
            boot = ln.split('=')[1].strip().split('\\')[-1].split(';')[0]
    assert boot, 'no BOOT line'
    loc = find(img, boot)
    assert loc, f'boot exe {boot} not in root'
    exe = read_extent(img, *loc)
    print(f'--- boot exe {boot}: {len(exe)} bytes sha256 {hashlib.sha256(exe).hexdigest()}')
    # PS-X EXE header: text VA @0x18, size @0x1C
    va, sz = struct.unpack_from('<II', exe, 0x18)
    print(f'    PS-X EXE text: VA 0x{va:08X} size 0x{sz:X}')

if __name__ == '__main__':
    main()
