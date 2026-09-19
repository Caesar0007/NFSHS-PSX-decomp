"""gen_cdata.py VA SIZE {u8|u16|u32} -- print a C brace initializer for retail bytes [VA, VA+SIZE).
Used when a reconstructed object takes ownership of a table the retail dump (asm/data) still carried.
Refuses ranges whose words look like addresses (0x80xxxxxx inside the image): those need symbols, not numbers."""
import struct
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
rom = (ROOT / 'rom' / 'nfs4-f.exe').read_bytes()[0x800:]
LOAD = 0x80010000


def initializer(va, size, kind, allow_ptr=False):
    data = rom[va - LOAD:va - LOAD + size]
    w = {'u8': 1, 'u16': 2, 'u32': 4}[kind]
    assert size % w == 0, 'size not a multiple of the element width'
    fmt = {1: 'B', 2: '<H', 4: '<I'}[w]
    vals = [struct.unpack_from(fmt, data, i)[0] for i in range(0, size, w)]
    if w == 4 and not allow_ptr:
        bad = [v for v in vals if LOAD <= v < LOAD + len(rom)]
        assert not bad, f'{len(bad)} words look like image addresses (first {bad[0]:#x}) -- use symbols'
    # trailing zeros can be left to the compiler only if the caller sizes the array explicitly
    per = {1: 16, 2: 12, 4: 8}[w]
    digits = w * 2
    rows = []
    for i in range(0, len(vals), per):
        rows.append('    ' + ', '.join(f'0x{v:0{digits}X}' for v in vals[i:i + per]) + ',')
    return '{\n' + '\n'.join(rows) + '\n}', len(vals)


if __name__ == '__main__':
    va, size, kind = int(sys.argv[1], 16), int(sys.argv[2], 0), sys.argv[3]
    text, n = initializer(va, size, kind)
    print(f'/* {n} x {kind}, retail {va:#010x}..{va + size:#010x} */')
    print(text + ';')
