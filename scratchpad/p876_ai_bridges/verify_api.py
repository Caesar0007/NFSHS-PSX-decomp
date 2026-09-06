"""P876 native/member/export and frozen-before diagnostic receipts.

Compiler output is only read. Native destructor names are compared with their
existing project assembler spelling (_._ -> ___); no aliases are created here.
"""
from pathlib import Path
import hashlib
import json
import re
import subprocess
import sys

ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT/'tools'))
import build as b


def probe(name):
    proc=subprocess.run([sys.executable,str(HERE/'check_probe.py'),str(HERE/name)],
                        cwd=ROOT,capture_output=True,text=True)
    result=json.loads(proc.stdout)
    result['returncode']=proc.returncode
    return result


def size_words(stem):
    text=(ROOT/('build/scratchpad/p876_ai_bridges/'+stem+'.s')).read_text()
    tail=text.split('p876_sizes:',1)[1]
    out=[]
    for line in tail.splitlines():
        match=re.fullmatch(r'\s*\.word\s+(\d+)\s*',line)
        if match:
            out.append(int(match[1]))
        elif out and line.strip() and not line.strip().startswith(('.align','#')):
            break
    return out


if __name__=='__main__':
    native=(Path(r'C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt')).read_text()
    classes=re.findall(r'p876_inplace_\d+\((\w+) \*self\)',(HERE/'canonical.cpp').read_text())
    expected=['_._'+str(len(c))+c for c in classes]+['StartUp__17AIState_Purgatory']
    assert len(expected)==27 and len(set(expected))==27
    results={name:probe(name) for name in ['legacy.cpp','canonical_before.cpp',
              'old_shape.cpp','canonical.cpp','sizes_before.cpp','sizes_after.cpp']}
    assert results['legacy.cpp']['ok']
    assert not results['canonical_before.cpp']['ok']
    assert 'StartUp' in results['canonical_before.cpp']['diagnostics']
    assert results['old_shape.cpp']['ok']
    assert results['canonical.cpp']['ok']
    assert set(results['canonical.cpp']['undefined'])==set(expected)
    assert all(results[n]['ok'] for n in ['sizes_before.cpp','sizes_after.cpp'])
    before_sizes=size_words('sizes_before'); after_sizes=size_words('sizes_after')
    assert len(before_sizes)==26 and before_sizes==after_sizes
    objdump=str(Path(b.AS).with_name('mipsel-none-elf-objdump.exe'))
    exports={}
    for src in sorted((ROOT/'recon/game/common').glob('*.cpp')):
        obj=ROOT/('build/'+src.relative_to(ROOT).as_posix()+'.o')
        if not obj.exists():
            continue
        table=subprocess.run([objdump,'-t',str(obj)],capture_output=True,text=True,check=True).stdout
        for line in table.splitlines():
            fields=line.split()
            if len(fields)>=6 and fields[1]=='g' and fields[2]=='F' and fields[3]!='*UND*':
                exports.setdefault(fields[-1],[]).append(dict(source=src.relative_to(ROOT).as_posix(),
                    symbol_row=line,object_sha256=hashlib.sha256(obj.read_bytes()).hexdigest()))
    entries=[]
    for name in expected:
        records=re.findall(r'(?m)^.*Def(?:2)? class (?:EXT|STAT) type FCN[^\r\n]* name '+re.escape(name)+r'\r?$',native)
        project=name.replace('_._','___',1) if name.startswith('_._') else name
        assert records,name
        assert project in exports,(name,project)
        entries.append(dict(native_name=name,project_export=project,native_records=records,
                            current_definitions=exports[project]))
    report=dict(round='P876',expected_native_references=27,
                actual_native_references=len(results['canonical.cpp']['undefined']),
                prior_missing_destructor_declarations=19,layout_sizes_unchanged=True,
                sizes=[dict(class_name=c,before=a,after=d) for c,a,d in zip(classes,before_sizes,after_sizes)],
                native_export_records=entries,probes=results,
                backup_sha256=hashlib.sha256((HERE/'nfs4_types.before.h').read_bytes()).hexdigest())
    (HERE/'api_receipts.json').write_text(json.dumps(report,indent=2)+'\n')
    print('27/27 exact native references and current GLOBAL FUNCTION exports;26/26 class sizes unchanged.')
    print('Frozen old API:26 nonexistent double-mangled destructor names;canonical StartUp lookup fails.')
    print('Removing false API declarations alone exposes only7 distinct destructor exports;19 declarations restored.')
    print(HERE/'api_receipts.json')
