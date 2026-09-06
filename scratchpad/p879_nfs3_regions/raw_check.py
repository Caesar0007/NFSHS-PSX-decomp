"""Verify startup bytes and every relocated reference, without rewriting objects."""
import csv
import argparse
import hashlib
import json
from pathlib import Path
import struct

ROOT = Path(__file__).resolve().parents[2]
BIN = Path('C:/Temp/nfs4-clean/Binaries')
parser = argparse.ArgumentParser()
parser.add_argument('--objects-dir', type=Path,
                    help='Parent-owned production snapshots; default retains isolated controls')
args = parser.parse_args()

def elf_sections(data):
    header = struct.unpack_from('<16sHHIIIIIHHHHHH', data)
    entries = [struct.unpack_from('<10I', data, header[6] + i * header[11])
               for i in range(header[12])]
    section_names = entries[header[13]]
    names = data[section_names[4]:section_names[4] + section_names[5]]
    return {names[e[0]:].split(b'\0')[0].decode():
            (e, data[e[4]:e[4] + e[5]]) for e in entries}

results = []
for region in ('AU', 'USA'):
    obj = ROOT / ('build/p879_nfs3_regions/scratchpad/p879_nfs3_regions/' + region + '_candidate.cpp.o')
    if args.objects_dir:
        obj = args.objects_dir / ('regiondiff__recon__NFS4-R-' + region + '__game__common__nfs3.cpp.o')
    sections = elf_sections(obj.read_bytes())
    text = sections['.text'][1]
    strings = sections['.strtab'][1]
    symbols = []
    for offset in range(0, len(sections['.symtab'][1]), 16):
        entry = struct.unpack_from('<IIIBBH', sections['.symtab'][1], offset)
        symbols.append((strings[entry[0]:].split(b'\0')[0].decode(), entry))
    symbol = next(e for name, e in symbols if name == 'Nfs2_SystemNLibStartUp__Fv')
    assert symbol[1] == 0 and symbol[2] == 100, symbol
    addresses = {}
    with (BIN / ('NFS4-B-USA/regiondiff/NFS4-R-' + region + '.tsv')).open() as source:
        for row in csv.DictReader(source, delimiter='\t'):
            if row['base_name'] and row['region_va']:
                try:
                    addresses[row['base_name']] = int(row['region_va'], 16)
                except ValueError:
                    pass
    with (ROOT / ('regiondiff/oracles/NFS4-R-' + region + '/symmap.tsv')).open() as source:
        for row in csv.DictReader(source, delimiter='\t'):
            addresses[row['symbol']] = int(row['region_addr'], 16)
    va = addresses['Nfs2_SystemNLibStartUp__Fv']
    raw = (BIN / ('NFS4-R-' + region + '.EXE')).read_bytes()
    load = struct.unpack_from('<I', raw, 24)[0]
    retail = raw[va - load + 0x800:va - load + 0x800 + 100]
    relocations = {}
    for offset in range(0, len(sections['.rel.text'][1]), 8):
        site, info = struct.unpack_from('<II', sections['.rel.text'][1], offset)
        if site < 100:
            relocations[site] = (info & 255, symbols[info >> 8][0])
    sites = []
    for offset in range(0, 100, 4):
        ours = struct.unpack_from('<I', text, offset)[0]
        expected = struct.unpack_from('<I', retail, offset)[0]
        if offset not in relocations:
            assert ours == expected, (region, offset, hex(ours), hex(expected))
            continue
        kind, name = relocations[offset]
        address = addresses[name]
        # The object carries no nonzero addend at any of this function's sites.
        # Verify the unchanged opcode/register bits independently of the field.
        if kind == 4:  # R_MIPS_26
            assert ours & 0x03ffffff == 0
            assert ours & 0xfc000000 == expected & 0xfc000000
            actual_address = ((va + offset + 4) & 0xf0000000) | ((expected & 0x03ffffff) << 2)
            assert actual_address == address
        elif kind in (5, 6):  # HI16 / LO16
            assert ours & 65535 == 0
            assert ours & 0xffff0000 == expected & 0xffff0000
            field = ((address + 0x8000) >> 16) & 65535 if kind == 5 else address & 65535
            assert expected & 65535 == field
        else:
            raise AssertionError((offset, kind, name))
        sites.append({'offset': hex(offset), 'kind': kind, 'symbol': name, 'target': hex(address)})
    results.append({'region': region, 'startup_va': hex(va), 'words_checked': 25,
                    'object': str(obj), 'object_sha256': hashlib.sha256(obj.read_bytes()).hexdigest(),
                    'nonrelocated_words_exact': 25 - len(sites),
                    'all_relocated_opcode_register_and_target_fields_exact': True,
                    'sites': sites})
print(json.dumps(results, indent=2))
