#!/usr/bin/env python3
"""fix_symsizes.py OBJ [OBJ...] -- give size-less GLOBAL text symbols a real st_size.

WHY: hand-written file-scope __asm__ blocks (BIOS thunks, libsn/libc thunks,
eacpsxz transcriptions, ...) declare `.globl name` + label but no `.size`/
`.type`. GNU as then emits the symbol with st_size=0 / STT_NOTYPE. Our gate
(tools/verify_asm.py) diffs by ADDRESS so it doesn't care -- but objdiff sizes
every function from st_size, so all such units report 0% on decomp.dev even
when sealed PASS (2026-07-26 sweep: 92 objects affected).

WHAT: for every GLOBAL symbol with st_size==0 defined in an SHF_EXECINSTR
section, set st_size = (next-higher symbol value in the same section, else
section size) - value, and mark it STT_FUNC. Symbols that already carry a
size (all compiler-emitted code, plus explicit `.size` directives) are
untouched; aliases at a shared address all receive the same computed size.
Pure symtab metadata -- code bytes, relocs, and the byte-match gate are
unaffected. Idempotent. Wired into tools/build.py after every assemble.
"""
import struct, sys


def fix(path):
    with open(path, 'rb') as fh:
        d = bytearray(fh.read())
    if d[:4] != b'\x7fELF' or d[4] != 1 or d[5] != 1:      # ELF32 LE only
        return 0
    e_shoff, = struct.unpack_from('<I', d, 0x20)
    e_shentsize, e_shnum = struct.unpack_from('<HH', d, 0x2E)
    secs = []
    for i in range(e_shnum):
        off = e_shoff + i * e_shentsize
        name, typ, flags, addr, offset, size, link = struct.unpack_from('<7I', d, off)
        secs.append({'type': typ, 'flags': flags, 'size': size, 'off': offset, 'link': link})
    symtab = next((s for s in secs if s['type'] == 2), None)   # SHT_SYMTAB
    if not symtab:
        return 0
    n = symtab['size'] // 16
    syms = []
    for i in range(n):
        off = symtab['off'] + i * 16
        st_name, st_value, st_size = struct.unpack_from('<3I', d, off)
        st_info, st_other, st_shndx = struct.unpack_from('<BBH', d, off + 12)
        syms.append({'i': i, 'off': off, 'value': st_value, 'size': st_size,
                     'info': st_info, 'shndx': st_shndx})
    # per-section sorted value lists (all defined symbols, any binding)
    by_sec = {}
    for s in syms:
        if 0 < s['shndx'] < len(secs):
            by_sec.setdefault(s['shndx'], set()).add(s['value'])
    fixed = 0
    for s in syms:
        bind, typ = s['info'] >> 4, s['info'] & 0xF
        if bind != 1 or s['size'] != 0:                       # STB_GLOBAL, size-less only
            continue
        if not (0 < s['shndx'] < len(secs)):
            continue
        sec = secs[s['shndx']]
        if not (sec['flags'] & 0x4):                          # SHF_EXECINSTR
            continue
        higher = [v for v in by_sec[s['shndx']] if v > s['value']]
        end = min(higher) if higher else sec['size']
        if end <= s['value']:
            continue
        struct.pack_into('<I', d, s['off'] + 8, end - s['value'])
        struct.pack_into('<B', d, s['off'] + 12, (bind << 4) | 2)   # STT_FUNC
        fixed += 1
    if fixed:
        with open(path, 'wb') as fh:
            fh.write(d)
    return fixed


if __name__ == '__main__':
    total = 0
    for p in sys.argv[1:]:
        total += fix(p)
    print('fix_symsizes: %d symbol(s) sized across %d object(s)' % (total, len(sys.argv) - 1))
