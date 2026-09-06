"""Read-only production audit + isolated compiler proof for nine real members.

Constructors cannot be addressed in C++; placement-new callers force their
ordinary native constructor references without fabricating free declarations.
Compiler outputs are confined to this scratch directory. No production writes.
"""
import hashlib
import json
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
WORK = Path(__file__).resolve().parent
CPP = Path('C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-cpp.exe')
CC1PL = Path('C:/Temp/psq43/COMPILER/CC1PLPSX.EXE')
OBJD = Path('C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe')
SYM = Path('C:/Temp/nfs4-clean/nfs4-f-v3.txt')
EXPECTED = {
    'object': {
        'Draw__23ObjectFinishedMultiAnimP13DRender_tViewP11Draw_DCachei': 'ObjectFinishedMultiAnim::Draw',
        '__15ObjectMultiAnimP8coorddefP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectP23ObjectFinishedMultiAnim': 'ObjectMultiAnim::ObjectMultiAnim',
        'Draw__15ObjectMultiAnimP13DRender_tViewP11Draw_DCachei': 'ObjectMultiAnim::Draw',
        'Draw__22ObjectFinishedSignAnimP13DRender_tViewP11Draw_DCachei': 'ObjectFinishedSignAnim::Draw',
        '__14ObjectSignAnimP8coorddefiP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectT1P22ObjectFinishedSignAnim': 'ObjectSignAnim::ObjectSignAnim',
        'Draw__14ObjectSignAnimP13DRender_tViewP11Draw_DCachei': 'ObjectSignAnim::Draw',
    },
    'track': {
        'Save__11SaveSurfaceP14Trk_NewSimQuad': 'SaveSurface::Save',
        '__11SaveSurfacei': 'SaveSurface::SaveSurface',
        'RestoreAll__11SaveSurface': 'SaveSurface::RestoreAll',
    },
}

def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

native = {}
names = {name for group in EXPECTED.values() for name in group}
with SYM.open(encoding='utf-8') as handle:
    for line in handle:
        m = re.match(r'^(\S+): \$([0-9a-fA-F]{8}) 9[46] Def2? class (EXT|STAT) type FCN (.*?) size (\d+)(.*?) name (\S+)\s*$', line)
        if m and m[7] in names:
            native[m[7]] = {'record':m[1], 'va':m[2], 'storage':m[3],
                            'return_type':m[4], 'raw':line.strip()}

root_receipts = json.loads((ROOT / 'scratchpad/root_sym_audit/p875_root_defining_object_receipts.json').read_text())
result = {'round':'P875 root member proof', 'expected_reference_count':9,
          'production_changes':False, 'groups':[]}
for unit, expected in EXPECTED.items():
    source = WORK / (unit + '_members.cpp')
    preprocessed, assembly = source.with_suffix('.i'), source.with_suffix('.s')
    commands = [
        [CPP, '-x', 'c', '-D__cplusplus=1', '-nostdinc', '-undef', '-Dmips',
         '-D__mips__', '-D__psx__', '-I' + str(ROOT / 'recon'), source, '-o', preprocessed],
        [CC1PL, '-quiet', '-O2', '-G4', preprocessed, '-o', assembly],
    ]
    compile_receipts = []
    for command in commands:
        run = subprocess.run([str(v) for v in command], cwd=ROOT, capture_output=True, text=True)
        compile_receipts.append({'command':[str(v) for v in command],
                                 'returncode':run.returncode, 'stdout':run.stdout, 'stderr':run.stderr})
        if run.returncode:
            print(json.dumps({'compile_failure':compile_receipts}, indent=2))
            sys.exit(1)
    emitted = re.findall(r'^\s*(?:\.word|jal)\s+([A-Za-z_]\w*)\s*$', assembly.read_text(), re.M)
    obj = ROOT / 'build/recon/game/common' / (unit + '.cpp.o')
    symtab = subprocess.check_output([str(OBJD), '-t', str(obj)], text=True)
    exports = {line.split()[-1]:line for line in symtab.splitlines()
               if re.match(r'^[0-9a-fA-F]{8}\s+g\s+F\b', line)}
    header = ROOT / 'recon/game/common' / (unit + '.h')
    private = ROOT / 'recon/game/common' / (unit + '_types.h')
    old = subprocess.check_output(['git','show','HEAD:' + header.relative_to(ROOT).as_posix()], cwd=ROOT, text=True, encoding='utf-8')
    saved = next(r for r in root_receipts if r['source'] == 'recon/game/common/' + unit + '.cpp')
    entries = []
    for name, member in expected.items():
        old_lines = [line for line in old.splitlines() if re.search(r'\b' + re.escape(name) + r'\s*\(', line)]
        entries.append({'native_symbol':name, 'source_member':member, 'native':native.get(name),
                        'removed_false_free_declaration':old_lines,
                        'false_declaration_absent_now':not re.search(r'\b' + re.escape(name) + r'\s*\(', header.read_text()),
                        'emitted_reference':name in emitted, 'actual_export':exports.get(name)})
    result['groups'].append({'header':header.relative_to(ROOT).as_posix(),
        'types_header':private.relative_to(ROOT).as_posix(), 'header_sha256':digest(header),
        'types_header_sha256':digest(private), 'probe':source.relative_to(ROOT).as_posix(),
        'compile_receipts':compile_receipts, 'emitted_references':emitted,
        'expected_count':len(expected), 'unexpected_references':sorted(set(emitted)-set(expected)),
        'object_sha256':digest(obj), 'matches_root_unchanged_object_receipt':digest(obj)==saved['before_sha256']==saved['after_sha256'],
        'assembly_sha256':digest(assembly), 'entries':entries})
result['verified_reference_count'] = sum(e['emitted_reference'] and bool(e['actual_export'])
                                        and bool(e['native']) and e['false_declaration_absent_now']
                                        for g in result['groups'] for e in g['entries'])
result['pass'] = result['verified_reference_count']==9 and all(not g['unexpected_references'] for g in result['groups'])
print(json.dumps(result, indent=2))
sys.exit(0 if result['pass'] else 1)
