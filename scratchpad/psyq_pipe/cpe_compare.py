#!/usr/bin/env python3
"""cpe_compare.py -- flatten build/psyq/nfs4.cpe into an image and byte-compare it with
rom/nfs4-f.exe per retail section (front overlay included: the CPE carries the front
group at 0x80010000 like the merged retail image)."""
import struct
from pathlib import Path
ROOT = Path('C:/Temp/nfs4-decomp')
LOAD = 0x80010000; FOFF = 0x800
rom = (ROOT / 'rom/nfs4-f.exe').read_bytes()[FOFF:]
cpe = (ROOT / 'build/psyq/nfs4.cpe').read_bytes()
assert cpe[:4] == b'CPE\x01', cpe[:4]
img = bytearray(len(rom)); cov = bytearray(len(rom)); i = 4; nrec = 0
while i < len(cpe):
    t = cpe[i]; i += 1
    if t == 0:
        break
    if t == 1:
        addr, ln = struct.unpack_from('<II', cpe, i); i += 8
        d = cpe[i:i + ln]; i += ln; nrec += 1
        o = addr - LOAD
        if 0 <= o and o + ln <= len(rom):
            img[o:o + ln] = d; cov[o:o + ln] = b'\x01' * ln
    elif t == 2:
        i += 4
    elif t == 3:
        i += 6
    elif t == 4:
        i += 2
    elif t == 5:
        i += 4
    elif t == 6:
        i += 4
    elif t == 7:
        i += 4
    elif t == 8:
        i += 1
    else:
        raise SystemExit('unknown CPE record %d at %d' % (t, i))
SECS = [('front.rdata', 0x80010000, 0x800128F0), ('front.text', 0x800128F0, 0x80051260), ('front.data', 0x80051260, 0x80052B38),
        ('.rdata', 0x80054548, 0x8005797C), ('.text', 0x8005797C, 0x8010CCD4), ('.data', 0x8010CCD4, 0x8013C54C),
        ('.sdata', 0x8013C54C, 0x8013DD7C)]
print('CPE records %d; covered bytes %d of %d' % (nrec, sum(cov), len(rom)))
tot = eq = 0
for n, lo, hi in SECS:
    t = e = c = 0
    for off in range(lo - LOAD, hi - LOAD, 4):
        if cov[off]:
            c += 1
            if img[off:off + 4] == rom[off:off + 4]:
                e += 1
        t += 1
    tot += c; eq += e
    print('  %-12s words %6d covered %6d identical %6d (%.2f%% of covered)' % (n, t, c, e, 100.0 * e / c if c else 0))
print('TOTAL covered %d identical %d = %.3f%%' % (tot, eq, 100.0 * eq / tot if tot else 0))
