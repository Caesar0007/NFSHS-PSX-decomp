"""vtdump.py VA [VA ...] -- print retail vtable entries at VA (8-byte {half,half,word} entries,
leading null entry) until an entry whose pfn is not a text address; pfns named by nearest
type:func symbol from configs/symbol_addrs.txt."""
import bisect
import re
import struct
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
rom = (ROOT / 'rom' / 'nfs4-f.exe').read_bytes()
TEXT_VA = 0x80010000 - 0x800   # PS-EXE header 0x800, load address from the header
load = struct.unpack_from('<I', rom, 0x18)[0]
fn = []
for ln in open(ROOT / 'configs' / 'symbol_addrs.txt', errors='replace'):
    m = re.match(r'(\S+?)\s*=\s*(0x[0-9A-Fa-f]+);\s*//\s*type:func', ln)
    if m:
        fn.append((int(m.group(2), 16), m.group(1)))
fn.sort()
keys = [v for v, _ in fn]


def name(va):
    i = bisect.bisect_right(keys, va) - 1
    if i < 0:
        return '?'
    v, n = fn[i]
    return n if v == va else f'{n}+{va - v:#x}'


def word(va):
    off = va - load + 0x800
    return struct.unpack_from('<I', rom, off)[0]


for a in sys.argv[1:]:
    va = int(a, 16)
    print(f'== {va:#x}')
    i = 0
    while True:
        d = word(va + 8 * i)
        p = word(va + 8 * i + 4)
        if i == 0:
            print(f'  [{i}] {d:#010x} {p:#010x}  (null)')
        elif 0x80010000 <= p < 0x80150000 and d == 0:
            print(f'  [{i}] {p:#010x}  {name(p)}')
        else:
            print(f'  -- end at [{i}] ({d:#010x} {p:#010x})')
            break
        i += 1
        if i > 40:
            break
