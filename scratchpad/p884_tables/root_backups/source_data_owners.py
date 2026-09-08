"""P881: explicit source-owned data windows and their oracle-only raw copies.

This is link-input/placement metadata, never an instruction rewrite. A native
local static needs one source backing cell, not an asm-labelled extern view or
a second raw copy in the reconstruction lane. The src lane retains its raw
oracle objects. Callers validate the compiler-emitted payload before excluding
the corresponding raw object; missing or stale source objects fail closed.
"""
from pathlib import Path
import hashlib
import struct

ROOT = Path(__file__).resolve().parents[1]
SOURCE_DATA_OWNERS = (
    {
        'source': 'recon/frontend/common/fecredits.cpp',
        'section': '.data',
        'address': 0x80051AA0,
        'size': 8,
        'payload': bytes.fromhex('bc02000000000000'),
        'global': 'CREDFADETICKS',
        'static': 'lasttick',
        'oracle_source': 'asm/data/front_data_fecredits_legacy.data.s',
        'record': 'SYM5f1f9a: STAT INT lasttick, object-relative offset4',
    },
    # P882: independent raw GP/MAP anchors and complete relocation-free
    # payloads prove these native .sdata owners. The fragment selects their
    # source sections; its SUBALIGN(4) supplies the verified terminal padding.
    # Backups/evidence: scratchpad/p882_gprel, omitted_sections.json.
    {
        'source': 'recon/game/common/hudpmx.cpp', 'section': '.sdata',
        'address': 0x8013C84C, 'size': 0x535, 'oracle_size': 0x538,
        'payload_sha256': '3351804d144ffcc98ae338b917cea61b12696514f5f521a41548423b16ec36af',
        'oracle_source': 'asm/data/sdata_hudpmx_legacy.sdata.s',
        'placement': 'fragment', 'record': 'P882: two raw GP anchors; exact native payload',
    },
    {
        'source': 'recon/game/common/copspeak.cpp', 'section': '.sdata',
        'address': 0x8013D07C, 'size': 0x7E, 'oracle_size': 0x80,
        'payload_sha256': '9916e2deea22d489a0ca65a78ff2ed67c7beb13ff564c1b52beea4cbe70767f1',
        'oracle_source': 'asm/data/sdata_copspeak_legacy.sdata.s',
        'placement': 'fragment', 'record': 'P882: 140 consistent native/raw anchors; exact payload',
    },
    {
        'source': 'recon/game/common/nfs3.cpp', 'section': '.sdata',
        'address': 0x8013D270, 'size': 0x58,
        'payload_sha256': '2d87c1156c33b9e238babab757c4501968dbe30f9d5b9a645429665ea21c068a',
        'oracle_source': 'asm/data/sdata_nfs3_legacy.sdata.s',
        'placement': 'fragment', 'record': 'P882: 17 consistent native/raw anchors; exact payload',
    },
    {
        'source': 'recon/game/common/r3dcar.cpp', 'section': '.sdata',
        'address': 0x8013D324, 'size': 0x9C,
        'payload_sha256': '8e3a0d3cbd549fdabdaf42d3c37494688098efef57ecf6410d273f468b77c9ca',
        'oracle_source': 'asm/data/sdata_r3dcar_legacy.sdata.s',
        'placement': 'fragment', 'record': 'P882: 112 consistent native/raw anchors; exact payload',
    },
    {
        'source': 'recon/game/common/sim.cpp', 'section': '.sdata',
        'address': 0x8013D40C, 'size': 0x28,
        'payload_sha256': '58eec09fc902fa59a719ff705a371adb51f37cf5bd2342194f9ff25f778af04d',
        'oracle_source': 'asm/data/sdata_sim_legacy.sdata.s',
        'placement': 'fragment', 'record': 'P882: 14 consistent native/raw anchors; exact payload',
    },
    # P883: canonical mutable CTYPE data belongs in the main data fragment,
    # not its stale .rodata selector. Only this raw table is oracle-only;
    # the surrounding r18 padding and other legacy tables stay intact.
    # Backups/proofs: scratchpad/p883_data_layout and scratchpad/p883_ctype.
    {
        'source': 'recon/syslib/psx/libc/CTYPE0.c', 'section': '.data',
        'address': 0x801371D0, 'size': 129,
        'payload_sha256': 'd3ca4007e97054deeb66d809e73c7b766c1156c598fb7b92d403aa7b71fbbb0a',
        'oracle_source': 'asm/data/data_ctype_legacy.data.s',
        'placement': 'fragment', 'record': 'SYM016504 and native MAP: _ctype_ at801371D0; PsyQ CTYPE0 mutable char[129]',
    },
    # The front_data fragment is not consumed by gen_ld. Like fecredits,
    # FETextRender needs an explicit native output section, not membership
    # in an inactive fragment. Native SYM52293b/522963 bound both globals.
    {
        'source': 'recon/frontend/common/fetextrender.cpp', 'section': '.data',
        'address': 0x800515B8, 'size': 88,
        'payload_sha256': '82a7158d55efa9688e94d835ee9d71f3780c8a4d17881e69f4ce1edb5a605053',
        'oracle_source': 'asm/data/front_data_o00.data.s',
        'record': 'SYM52293b CHAR[14][6] textDefinitions +84 BOOL gSemiTransText (522963)',
    },
)


def object_path(source, object_root=None):
    return (object_root or ROOT/'build') / (source+'.o')


def oracle_only_objects(object_root=None):
    return {object_path(row['oracle_source'], object_root).resolve()
            for row in SOURCE_DATA_OWNERS}


def validate_source_data_owners(object_root=None):
    """Check exact owner data and real global/local symbols, not only filenames."""
    for row in SOURCE_DATA_OWNERS:
        obj = object_path(row['source'], object_root)
        assert obj.is_file(), f'{obj}: rebuild the source-data owner before linking'
        data = obj.read_bytes()
        assert data[:6] == b'\x7fELF\x01\x01', f'{obj}: expected little-endian ELF32'
        off = struct.unpack_from('<I', data, 32)[0]
        width, count, names_index = struct.unpack_from('<HHH', data, 46)
        headers = [struct.unpack_from('<10I', data, off+i*width) for i in range(count)]
        sh = headers[names_index]
        names = data[sh[4]:sh[4]+sh[5]]
        labels = [names[h[0]:].split(b'\0')[0].decode() for h in headers]
        index = labels.index(row['section'])
        section = headers[index]
        payload = data[section[4]:section[4]+section[5]]
        payload_ok = (payload == row['payload'] if 'payload' in row
                      else hashlib.sha256(payload).hexdigest() == row['payload_sha256'])
        assert section[5] == row['size'] and payload_ok, (
            obj, 'source-owned data layout/payload is stale or not native', row['record'])
        # Every registered payload is fully initialized and has no unresolved
        # data relocations. A future pointer-bearing owner needs its own
        # native relocation proof instead of silently using this hash check.
        assert section[1] == 1 and all(h[5] == 0 for h in headers
                                     if h[1] in (4,9) and h[7] == index), (
            obj, 'unexpected data relocation in exact raw owner')
        if 'global' not in row:
            continue
        symtab = headers[labels.index('.symtab')]
        strings_header = headers[symtab[6]]
        strings = data[strings_header[4]:strings_header[4]+strings_header[5]]
        syms = []
        for at in range(symtab[4], symtab[4]+symtab[5], symtab[9]):
            name, value, size, info, other, owner = struct.unpack_from('<IIIBBH', data, at)
            syms.append((strings[name:].split(b'\0')[0].decode(), value, size, info, owner))
        # PsyQ data labels normally reach ELF as NOTYPE/size0; the exact
        # eight-byte payload plus offsets bound both cells. Size4 is accepted
        # too when an assembler preserves object-size metadata. Source/-g
        # declaration checks establish INT separately, not this layout check.
        assert any(n == row['global'] and v == 0 and s in (0,4) and info>>4 == 1 and own == index
                   for n,v,s,info,own in syms), (obj, 'missing native global at data+0')
        assert sum(n.startswith(row['static']+'.') and v == 4 and s in (0,4) and info>>4 == 0 and own == index
                   for n,v,s,info,own in syms) == 1, (obj, 'missing unique function-local static at data+4')
