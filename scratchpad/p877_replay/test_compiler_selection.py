"""P877 whole-TU compiler selector tests; no production source edits.

Verifies selection isolation, required-tool failure, real one-pass compilation,
CI kit availability and whole-object equality with the old mixed outputs.
"""
from pathlib import Path
import ast
import hashlib
import json
import sys
import zipfile

ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT/'tools'))
import build as b

EXPECTED={'recon/game/common/replay.cpp':'replay.mixed.before.o',
          'recon/game/psx/night.cpp':'night.mixed.before.o'}
HASH='70319c94de27924f5720af361afd2aa7e6de051a7718e0c1a7f07b57fa92109c'
old_tree=ast.parse((HERE/'build.py.before').read_text())
old_flags=next(ast.literal_eval(node.value) for node in old_tree.body
               if isinstance(node,ast.Assign) and
               any(isinstance(t,ast.Name) and t.id=='PER_TU_FLAGS' for t in node.targets))
expected_flags={k:dict(v) for k,v in old_flags.items()}
expected_flags['recon/game/common/replay.cpp']={'cc1plus_ver':'2.8.1-sn'}
expected_flags['recon/game/psx/night.cpp']['cc1plus_ver']='2.8.1-sn'
# P878's independently verified AudioClc input flag changes no compiler choice.
expected_flags['recon/game/common/audioclc.cpp']={'no_thread_jumps':True}
assert b.PER_TU_FLAGS==expected_flags
assert b.per_tu_flags(ROOT/'recon/game/psx/night.cpp')['g_value']=='8'
assert not b.PER_FN_CC1PLUS_VER_SPLICE
sources=sorted((ROOT/'recon').rglob('*.cpp'))
selected={p.relative_to(ROOT).as_posix() for p in sources
          if b.per_tu_flags(p).get('cc1plus_ver')}
assert selected==set(EXPECTED),selected
retail=b._resolve_cc1plus_rung('2.8.1-sn')
assert retail and hashlib.sha256(retail.read_bytes()).hexdigest()==HASH
for src in sources:
    expected=retail if src.relative_to(ROOT).as_posix() in EXPECTED else b.CC1PL
    assert b.cpp_compiler(src)==expected,src
resolve=b._resolve_cc1plus_rung
b._resolve_cc1plus_rung=lambda rung:None
try:
    try:
        b.cpp_compiler(ROOT/'recon/game/common/replay.cpp')
    except SystemExit as error:
        missing_message=str(error)
        assert 'required retail C++ compiler' in missing_message and 'unavailable' in missing_message
    else:
        raise AssertionError('Missing selected compiler silently fell back')
finally:
    b._resolve_cc1plus_rung=resolve
with zipfile.ZipFile(ROOT/'toolchain.zip') as archive:
    ci_hash=hashlib.sha256(archive.read('toolchain/psyq/CC1PLPSX44.EXE')).hexdigest()
assert ci_hash==HASH
run=b.run
calls=[]
def recording_run(command,*args,**kwargs):
    if str(command[0]) in (str(b.CC1PL),str(retail)):
        calls.append(list(map(str,command)))
    return run(command,*args,**kwargs)
b.run=recording_run
rows=[]
try:
    for source,backup in EXPECTED.items():
        calls.clear()
        obj=b.compile_cpp(ROOT/source)
        assert len(calls)==1 and calls[0][0]==str(retail),calls
        old=ROOT/'build/scratchpad/p877_replay'/backup
        before=hashlib.sha256(old.read_bytes()).hexdigest()
        after=hashlib.sha256(obj.read_bytes()).hexdigest()
        assert before==after,(source,before,after)
        rows.append(dict(source=source,compiler_calls=list(calls),
                         old_mixed_sha256=before,whole_tu_sha256=after,identical=True))
finally:
    b.run=run
report=dict(cpp_sources_checked=len(sources),selected=sorted(selected),
            default_compilers_unchanged=len(sources)-len(selected),
            cpp_function_splices=0,retail_compiler_sha256=HASH,ci_kit_sha256=ci_hash,
            missing_compiler_error=missing_message,objects=rows)
(HERE/'compiler_selection_receipts.json').write_text(json.dumps(report,indent=2)+'\n')
print('PASS:',len(sources),'compiler selections; default unchanged for',len(sources)-len(selected))
print('PASS: required-tool failure, matching CI kit, zero C++ function splices.')
print('PASS: Replay and Night each compile once and reproduce the old mixed object exactly.')
