"""P883 read-only validation of the generated production link's eight owners.

Run only AFTER the orchestrator's full builds and gen_ld --link. No compiler,
linker, source, object or production-tool mutation occurs here. Existing
SHF_ALLOC output overlaps are recorded, not mistaken for a flattened image.
"""
import ast
import hashlib
import json
from pathlib import Path
import re
import struct
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT/'tools'))
import source_data_owners as owners

tree = ast.parse((ROOT/'scratchpad/p882_gprel/audit.py').read_text())
node = next(n for n in tree.body if isinstance(n, ast.ClassDef) and n.name == 'Elf')
exec(compile(ast.Module(body=[node], type_ignores=[]), 'p883_owner_elf', 'exec'))

REPORT = HERE/'production_receipt.json'
report = {'status': 'RUNNING', 'qualification': (
    'Native owner/data/reference proof in the diagnostic production ELF; not a '
    'whole-image match. Existing output-section overlaps and other unrelated '
    'layout/reference debt remain explicitly reported.')}


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def map_inputs(text):
    """Retain output identity and both one-/two-line GNU map input records."""
    text = text.split('Linker script and memory map', 1)[-1]
    output = pending = None
    result = []
    for line in text.splitlines():
        if line.startswith('.'):
            output = line.split()[0]
            pending = None
            continue
        m = re.match(r'^\s+(\.\S+)\s+0x([0-9a-f]+)\s+0x([0-9a-f]+)\s+(build/\S+\.o)\s*$', line)
        if m:
            result.append(dict(object=m[4], section=m[1], address=int(m[2],16),
                               size=int(m[3],16), output=output))
            pending = None
            continue
        m = re.match(r'^\s+(\.\S+)\s*$', line)
        if m:
            pending = m[1]
            continue
        m = re.match(r'^\s+0x([0-9a-f]+)\s+0x([0-9a-f]+)\s+(build/\S+\.o)\s*$', line)
        if m and pending:
            result.append(dict(object=m[3], section=pending, address=int(m[1],16),
                               size=int(m[2],16), output=output))
            pending = None
    return result


def main():
    assert len(owners.SOURCE_DATA_OWNERS) == 8, 'P883 proof expects all eight registered owners'
    owners.validate_source_data_owners()
    elf_path = ROOT/'build/gen_ld/recon_multdef-ok.elf'
    map_path = ROOT/'build/gen_ld/recon_multdef-ok.map'
    rsp_path = ROOT/'build/gen_ld/recon_link.rsp'
    ld_path = ROOT/'linkers/nfs4_recon.ld'
    linked = Elf(elf_path)
    symbols = {s['name']: s for s in linked.symbols if s['section'] != 0}
    rom = (ROOT/'rom/nfs4-f.exe').read_bytes()
    maptext = map_path.read_text(errors='replace')
    placements = map_inputs(maptext)
    inputs = [line.strip().strip('"').replace('\\','/')
              for line in rsp_path.read_text().splitlines() if line.strip()]
    # Linker filename tokens can contain slash-star (build/src/*(.text)).
    # That is a wildcard, not a comment opener. All real comments in these
    # scripts start at a whitespace/token boundary; do not swallow selectors
    # between a filename wildcard and the next genuine comment terminator.
    ld = re.sub(r'(?<!\S)/\*.*?\*/', '', ld_path.read_text(), flags=re.S)
    src_ld = re.sub(r'(?<!\S)/\*.*?\*/', '', (ROOT/'linkers/nfs4.ld').read_text(), flags=re.S)
    report['artifacts'] = {str(p.relative_to(ROOT)): sha(p)
                           for p in (elf_path,map_path,rsp_path,ld_path)}
    report['owners'] = []
    report['owner_window_overlap_observations'] = []

    # Enumerate EVERY intersecting allocated output-section pair, including
    # NOBITS. The diagnostic linker permits overlaps; do not silently select
    # an arbitrary payload when two sections cover a requested native VA.
    alloc = sorted((s for s in linked.sections if s['flags'] & 2 and s['size']),
                   key=lambda s: (s['addr'], s['index']))
    active = []
    overlaps = []
    for section in alloc:
        active = [s for s in active if s['addr']+s['size'] > section['addr']]
        for prior in active:
            lo = max(prior['addr'], section['addr'])
            hi = min(prior['addr']+prior['size'], section['addr']+section['size'])
            if hi > lo:
                overlaps.append(dict(first=prior['name'], second=section['name'],
                                     start=hex(lo), end_exclusive=hex(hi), bytes=hi-lo,
                                     first_type=prior['type'], second_type=section['type']))
        active.append(section)
    report['allocated_output_overlaps'] = overlaps
    report['allocated_output_overlap_count'] = len(overlaps)

    def raw(va, size):
        offset = va-0x8000f800
        assert 0 <= offset and offset+size <= len(rom), (hex(va),size)
        return rom[offset:offset+size]

    def readva(va, size, section_name):
        matches = [s for s in linked.sections if s['type'] != 8 and s['flags'] & 2
                   and s['addr'] <= va and va+size <= s['addr']+s['size']]
        if len(matches) > 1:
            report['owner_window_overlap_observations'].append(
                dict(address=hex(va), bytes=size, sections=[s['name'] for s in matches],
                     selected_verified_owner_section=section_name))
        selected = [s for s in matches if s['name'] == section_name]
        assert len(selected) == 1, (hex(va),size,section_name,matches)
        section = selected[0]
        start = va-section['addr']
        return linked.payload(section)[start:start+size]

    def placed(obj, section, address, size, output):
        found = [p for p in placements if p['object'] == obj and p['section'] == section]
        assert len(found) == 1, (obj,section,'missing or duplicate input placement',found)
        assert found[0] == dict(object=obj, section=section, address=address,
                               size=size, output=output), (obj,found[0],hex(address),size,output)
        selector = re.escape(obj)+r'\(\s*'+re.escape(section)+r'\s*\)'
        assert len(re.findall(selector, ld)) == 1, (obj,section,'source selector count')
        return found[0]

    for index, row in enumerate(owners.SOURCE_DATA_OWNERS):
        base, size = row['address'], row['size']
        # Critical P883 correction: CTYPE is .data-fragment owned, not .sdata;
        # FETextRender is explicit registry index7, not always .source_data_0.
        output = row['section'] if row.get('placement') == 'fragment' else f'.source_data_{index}'
        obj = 'build/'+row['source']+'.o'
        oracle = 'build/'+row['oracle_source']+'.o'
        assert inputs.count(obj) == 1, (obj,'source input count')
        assert oracle not in inputs, (oracle,'raw owner duplicate remains in recon inputs')
        assert re.search(re.escape(oracle)+r'\(', src_ld), (oracle,'src lane lost raw selector')
        placement = placed(obj,row['section'],base,size,output)
        actual = readva(base,size,output)
        assert actual == raw(base,size), (row['source'],'linked owner payload differs from ROM')
        reserved = row.get('oracle_size',size)
        if reserved > size:
            pad = readva(base+size,reserved-size,output)
            assert pad == raw(base+size,reserved-size) == b'\0'*(reserved-size)
        report['owners'].append(dict(index=index,source=row['source'],section=row['section'],
            output_section=output,native_address=hex(base),bytes=size,reserved=reserved,
            padding_bytes=reserved-size,raw_equal=True,payload_sha256=hashlib.sha256(actual).hexdigest(),
            actual_map_placement=placement,source_selector_count=1,source_input_count=1,
            oracle_input_excluded=True,src_oracle_selector_retained=True))

    # CTYPE byte extent, implicit alignment, retained explicit gap and all
    # following native table selectors must be restored, not shifted by132.
    assert symbols['_ctype_']['value'] == 0x801371d0
    # asintbl is NOT one of this checkpoint's registered owners. Its typed
    # section is checked below at the native slot, but the old raw duplicate
    # can still win global-symbol binding in this diagnostic link. Record this
    # genuine pre-existing debt, rather than pretending a section-placement
    # improvement has also solved its separate duplicate ownership.
    asinsym=symbols['asintbl']
    asinsection=linked.sections[asinsym['section']]
    assert asinsection['name']=='.data.asintbl_blob'
    assert asinsym['value']==asinsection['addr'] and asinsym['value']!=0x80137260
    assert linked.payload(asinsection)==raw(0x80137260,512)
    report['unregistered_neighbor_symbol_debt']=[dict(name='asintbl',
        native_address='0x80137260',actual_symbol_address=hex(asinsym['value']),
        actual_owner_section=asinsection['name'],
        reason='Pre-existing raw duplicate still wins binding; typed native section placement alone is not a public-symbol fix.')]
    assert readva(0x80137251,3,'.data') == raw(0x80137251,3) == b'\0'*3
    assert re.search(r'\*fill\*\s+0x0*80137251\s+0x0*3\b',maptext)
    assert readva(0x80137254,12,'.data') == raw(0x80137254,12) == b'\0'*12
    neighbors = [
        ('build/recon/syslib/psx/libc/CTYPE0.c.o','.data',0x801371d0,129),
        ('build/asm/data/data_8010CCD4_r18.data.s.o','.data.r18_gap_after_ctype',0x80137254,12),
        ('build/recon/eaclib/psx/eacpsxz/asintbl.c.o','.data',0x80137260,0x200),
        ('build/asm/data/data_8010CCD4_r18.data.s.o','.data.r18_gap_after_asintbl',0x80137460,4),
        ('build/recon/eaclib/psx/eacpsxz/sintbl.c.o','.data',0x80137464,0x404),
        ('build/recon/eaclib/psx/eacpsxz/fatantbl.c.o','.data',0x80137868,0x404),
    ]
    report['ctype_and_table_neighbors'] = []
    for obj,section,address,size in neighbors:
        p = placed(obj,section,address,size,'.data')
        assert readva(address,size,'.data') == raw(address,size), (obj,'table/gap bytes')
        report['ctype_and_table_neighbors'].append(dict(**p,end_exclusive=hex(address+size),raw_equal=True))
    ordered_last = [p for p in placements if p['object'] == 'build/asm/data/data_8010CCD4_r21.data.s.o'
                    and p['section'] == '.data' and p['output'] == '.data']
    assert len(ordered_last) == 1
    ordered_end = ordered_last[0]['address']+ordered_last[0]['size']
    assert ordered_end == 0x8013c54c, ('native ordered .data end',hex(ordered_end))
    report['ordered_data_run'] = dict(last_native_input=ordered_last[0],
        end_exclusive=hex(ordered_end),native_sdata_start='0x8013c54c',
        actual_output_data_end=hex(linked.byname['.data']['addr']+linked.byname['.data']['size']),
        appended_or_overlap_bytes=max(0,linked.byname['.data']['addr']+linked.byname['.data']['size']-ordered_end))

    # Both FETextRender records are GLOBAL labels, not fecredits-style local
    # static storage. ELF data symbols may legitimately be NOTYPE/size0.
    text_index = next(i for i,r in enumerate(owners.SOURCE_DATA_OWNERS)
                      if r['source'] == 'recon/frontend/common/fetextrender.cpp')
    text_output = f'.source_data_{text_index}'
    report['fetextrender_globals'] = []
    for name,address,span in [('textDefinitions',0x800515b8,84),('gSemiTransText',0x8005160c,4)]:
        symbol = symbols[name]
        assert symbol['bind'] == 1 and symbol['value'] == address
        assert linked.sections[symbol['section']]['name'] == text_output
        assert symbol['size'] in (0,span), (name,symbol)
        report['fetextrender_globals'].append(dict(name=name,address=hex(address),
            native_storage_bytes=span,elf_size=symbol['size'],elf_type=symbol['type'],output_section=text_output))

    # Preserve P882's34 storage-free Hud string labels and their actual raw
    # pointer table references. Validate byte identity in the owner output,
    # not merely that an alias happens to have hex-looking name/value.
    legacy = Elf(ROOT/'build/asm/data/sdata_hudpmx_legacy.sdata.s.o')
    old = {s['name']:s for s in legacy.symbols}
    aliases = []
    for i in range(34):
        address = 0x8013c84c+8*i
        name = f'D_{address:08X}'
        assert old[name]['value'] == 8*i
        assert symbols[name]['value'] == address
        assert readva(address,8,'.sdata') == raw(address,8)
        aliases.append(dict(name=name,offset=8*i,target=hex(address)))
    alias_names = {r['name'] for r in aliases}
    table_section = linked.sections[symbols['D_80055A54']['section']]['name']
    raw_table = (ROOT/'asm/data/rdata_80054548_r08.rodata.s').read_text()
    references = []
    for m in re.finditer(r'/\*\s+\w+\s+([0-9a-fA-F]{8})\s+([0-9a-fA-F]{8})\s*\*/\s*\.word\s+(\w+)',raw_table):
        address,raw_bytes,name = m.groups()
        if name not in alias_names:
            continue
        at = int(address,16)
        actual = readva(at,4,table_section)
        assert actual == bytes.fromhex(raw_bytes) == raw(at,4)
        assert struct.unpack('<I',actual)[0] == symbols[name]['value']
        references.append(dict(table_address=hex(at),target_symbol=name))
    assert {r['target_symbol'] for r in references} == alias_names
    report['legacy_pointer_aliases'] = aliases
    report['raw_pointer_table_references'] = references

    errors = (ROOT/'build/gen_ld/recon_multdef-ok.err').read_text(errors='replace')
    lower = errors.lower()
    assert 'undefined reference' not in lower and 'relocation truncated' not in lower
    report['link_diagnostics'] = dict(undefined_references=0,relocation_truncations=0,
        warning_or_error_lines=[line for line in errors.splitlines() if 'warning' in line.lower() or 'error' in line.lower()])
    report['status'] = 'PASS'


try:
    main()
except Exception as error:
    report['status'] = 'FAIL'
    report['failure'] = {'type':type(error).__name__,'message':str(error)}
    REPORT.write_text(json.dumps(report,indent=2)+'\n')
    raise
else:
    REPORT.write_text(json.dumps(report,indent=2)+'\n')
    print('PASS: all8 native source owners; exact padding and CTYPE/table seam; '
          'FETextRender globals;34 Hud aliases/raw references. '
          f"Existing allocated output overlaps recorded: {report['allocated_output_overlap_count']}.")
