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

`.L*` EXCLUSION (2026-07-26b): splat's `jlabel` macro (include/macro.inc) emits
`.global .L800F3D94` for every switch jump-table case target, because the jtbl
word lives in a *different* translation unit (asm/data/rdata_*.rodata.s) and so
must reference the case label across objects -- 350 such symbols, referenced UND
by the two rodata data objects, so they CANNOT be made local or stripped without
breaking the link. Being GLOBAL + size-less they were swept up by the pass above
and promoted to sized STT_FUNC, at which point objdiff counts each one as an
extra, always-unmatched FUNCTION row: fileroot alone gained 6 phantom 0%
rows (240 B) and fell from 99.97% to 88.54% on decomp.dev.

So: (a) `.L*` symbols are never sized/typed, and (b) their addresses are not
used as the "next symbol" boundary when sizing a real function (a `.L` label is
always *interior* to a function, never a function start -- using it as a
boundary would truncate the enclosing function's size). (c) a repair pass
resets any `.L*` exec-section symbol that a previous run already promoted back
to STT_NOTYPE/size 0, so stale objects heal in place without a full rebuild.
"""
import re, struct, sys


def _is_local_label(name):
    """GNU as local-label prefix. Never a function start."""
    # GCC 2.7.x's normal debug/maspsx lane also emits bare `LM<n>` line
    # markers (for example LM1 inside FOG_01::SetFogNear).  They are local
    # compiler markers even though the old assembler spelling lacks `.L`.
    return name.startswith('.L') or re.fullmatch(r'LM\d+', name) is not None


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
    strtab = secs[symtab['link']] if symtab['link'] < len(secs) else None

    def sym_name(st_name):
        if strtab is None:
            return ''
        base = strtab['off'] + st_name
        end = d.index(b'\x00', base)
        return d[base:end].decode('utf-8', 'replace')

    n = symtab['size'] // 16
    syms = []
    for i in range(n):
        off = symtab['off'] + i * 16
        st_name, st_value, st_size = struct.unpack_from('<3I', d, off)
        st_info, st_other, st_shndx = struct.unpack_from('<BBH', d, off + 12)
        syms.append({'i': i, 'off': off, 'value': st_value, 'size': st_size,
                     'info': st_info, 'shndx': st_shndx, 'name': sym_name(st_name)})
    fixed = 0

    # (c) repair pass: undo any earlier promotion of a `.L*` local label to a
    # sized STT_FUNC -- objdiff would report it as a phantom 0% function row.
    for s in syms:
        if not _is_local_label(s['name']):
            continue
        if not (0 < s['shndx'] < len(secs)) or not (secs[s['shndx']]['flags'] & 0x4):
            continue
        bind, typ = s['info'] >> 4, s['info'] & 0xF
        if s['size'] == 0 and typ != 2:
            continue
        struct.pack_into('<I', d, s['off'] + 8, 0)                  # st_size = 0
        struct.pack_into('<B', d, s['off'] + 12, bind << 4)         # STT_NOTYPE
        s['size'], s['info'] = 0, bind << 4
        fixed += 1

    # per-section sorted value lists (all defined symbols, any binding) --
    # excluding `.L*` interior labels, see (b).
    by_sec = {}
    for s in syms:
        if 0 < s['shndx'] < len(secs) and not _is_local_label(s['name']):
            by_sec.setdefault(s['shndx'], set()).add(s['value'])
    for s in syms:
        bind, typ = s['info'] >> 4, s['info'] & 0xF
        if bind != 1 or s['size'] != 0:                       # STB_GLOBAL, size-less only
            continue
        if _is_local_label(s['name']):                        # (a) never size a .L label
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
