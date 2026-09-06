"""Check the AU LoadPerps candidate against raw bytes and native references."""
import csv
import argparse
import hashlib
import json
from pathlib import Path
import struct

ROOT = Path(__file__).resolve().parents[2]
BIN = Path('C:/Temp/nfs4-clean/Binaries')
parser = argparse.ArgumentParser()
parser.add_argument('--object', type=Path,
                    default=ROOT / 'build/p879_nfs3_regions/scratchpad/p879_nfs3_regions/AU_perps.cpp.o')
args = parser.parse_args()
data = args.object.read_bytes()
h = struct.unpack_from('<16sHHIIIIIHHHHHH', data)
entries = [struct.unpack_from('<10I', data, h[6] + i * h[11]) for i in range(h[12])]
names = data[entries[h[13]][4]:entries[h[13]][4] + entries[h[13]][5]]
sections = {names[e[0]:].split(b'\0')[0].decode(): data[e[4]:e[4]+e[5]] for e in entries}
strings = sections['.strtab']
symbols = []
for offset in range(0, len(sections['.symtab']), 16):
    e = struct.unpack_from('<IIIBBH', sections['.symtab'], offset)
    symbols.append((strings[e[0]:].split(b'\0')[0].decode(), e))
_, fn = next(x for x in symbols if x[0] == 'NFS4_LoadPerps__Fv')
assert fn[1] == 0x11c and fn[2] == 172 * 4
relocations = {}
for offset in range(0, len(sections['.rel.text']), 8):
    site, info = struct.unpack_from('<II', sections['.rel.text'], offset)
    if fn[1] <= site < fn[1] + fn[2]:
        relocations[site - fn[1]] = (info & 255, symbols[info >> 8][0])
raw = (BIN / 'NFS4-R-AU.EXE').read_bytes()
load = struct.unpack_from('<I', raw, 24)[0]
va = 0x800a4a70
retail = raw[va-load+0x800:va-load+0x800+fn[2]]
ours = sections['.text'][fn[1]:fn[1]+fn[2]]
addresses = {}
with (BIN / 'NFS4-B-USA/regiondiff/NFS4-R-AU.tsv').open() as source:
    for row in csv.DictReader(source, delimiter='\t'):
        try:
            addresses[row['base_name']] = int(row['region_va'], 16)
        except ValueError:
            pass
with (ROOT / 'regiondiff/oracles/NFS4-R-AU/symmap.tsv').open() as source:
    for row in csv.DictReader(source, delimiter='\t'):
        addresses[row['symbol']] = int(row['region_addr'], 16)
text_base = va - fn[1]
checked_calls = []
nonrelocated = 0
# These section-relative literal anchors are verified from the raw strings
# below. They describe this function's references, not a claim that the whole
# regional small-data owner layout has already been reconstructed.
reference_bases = {'.sdata': 0x8013e578, '.rodata': 0x800567ac}
reference_bases.update(addresses)
assert va == addresses['NFS4_LoadPerps__Fv']
rodata = sections['.rodata']
rodata_offset = reference_bases['.rodata'] - load + 0x800
assert len(rodata) == 71 and rodata == raw[rodata_offset:rodata_offset+len(rodata)]
for offset in range(0, fn[2], 4):
    a = struct.unpack_from('<I', ours, offset)[0]
    b = struct.unpack_from('<I', retail, offset)[0]
    if offset not in relocations:
        assert a == b, (hex(offset), hex(a), hex(b))
        nonrelocated += 1
        continue
    kind, symbol = relocations[offset]
    mask = 0xfc000000 if kind == 4 else 0xffff0000
    assert a & mask == b & mask
    if kind == 4:
        target = ((va+offset+4) & 0xf0000000) | ((b & 0x03ffffff) << 2)
        expected = text_base + ((a & 0x03ffffff) << 2) if symbol == '.text' else addresses[symbol]
        assert target == expected, (offset, symbol, hex(target), hex(expected))
        checked_calls.append({'offset': hex(offset), 'symbol': symbol, 'target': hex(target)})
    elif kind in (5, 6):
        base = reference_bases[symbol]
        addend = a & 65535
        addend = addend - 65536 if addend & 32768 else addend
        if kind == 5:
            assert addend == 0
            # None of the target's paired LO addends crosses a signed-HI page.
            expected_field = ((base + 0x8000) >> 16) & 65535
        else:
            expected_field = (base + addend) & 65535
        assert b & 65535 == expected_field, (hex(offset), symbol, hex(b), hex(expected_field))
    else:
        raise AssertionError((offset, kind, symbol))

def raw_word(offset):
    return struct.unpack_from('<I', retail, offset)[0]

def address_pair(hi_offset, lo_offset):
    lo = raw_word(lo_offset) & 65535
    return (((raw_word(hi_offset) & 65535) << 16) + (lo-65536 if lo & 32768 else lo)) & 0xffffffff

def cstring(blob, offset):
    return blob[offset:blob.index(0, offset)].decode('ascii')

assert address_pair(4, 8) == addresses['GameSetup_gData'] == 0x801144d0
assert address_pair(0x2c, 0x30) == addresses['Paths_Paths'] == 0x8011774c
# The added retail gate loads GameSetup_gData.trafficDensity at +0x18.
assert raw_word(0x44) == 0x8c820018
assert raw_word(0x4c) == 0x1c400004
refs = [('.sdata', 0x24, 0x24, 0x28),
        ('.rodata', 0, 0x54, 0x5c),
        ('.rodata', 12, 0x50, 0x60),
        ('.rodata', 24, 0x88, 0x8c)]
string_refs = []
for section, section_offset, hi_offset, lo_offset in refs:
    address = address_pair(hi_offset, lo_offset)
    compiled = cstring(sections[section], section_offset)
    original = cstring(raw, address-load+0x800)
    assert compiled == original, (section, hex(section_offset), hex(address), compiled, original)
    string_refs.append({'section': section, 'offset': hex(section_offset),
                        'retail_va': hex(address), 'value': original})
print(json.dumps({'region': 'AU', 'function_va': hex(va), 'words': 172,
                  'object': str(args.object), 'object_sha256': hashlib.sha256(data).hexdigest(),
                  'whole_rodata_bytes_exact': len(rodata),
                  'nonrelocated_words_exact_including_conditional_branch_offsets': nonrelocated,
                  'relocated_opcode_and_register_fields_exact': len(relocations),
                  'all_relocated_target_fields_verified': True,
                  'call_and_internal_jump_targets': checked_calls,
                  'data_targets': {'GameSetup_gData': hex(addresses['GameSetup_gData']),
                                   'Paths_Paths': hex(addresses['Paths_Paths'])},
                  'string_references': string_refs,
                  'qualification': 'Source literal content and raw targets checked; not a whole-regional-data-layout or full-linked-image claim.'}, indent=2))
