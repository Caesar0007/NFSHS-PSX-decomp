"""Compile-only root header probes. Never linked into the game.

Before/candidate copies use frozen original-header snapshots, never live fixed
headers. Candidate/current probes preserve
other header declarations and check actual compiler-generated relocation names.
Generated diagnostic files stay under build/scratch; this script does not edit
reconstructed source. It does not infer return types from mangled names.
"""
from pathlib import Path
import argparse
import json
import re
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tools'))
import build as b


def compile_probe(header, text, names, stem, mode, signatures=None):
    work = ROOT / 'build/scratch/p875_root' / mode / stem
    work.mkdir(parents=True, exist_ok=True)
    def include(m):
        path = (header.parent / m[1]).resolve()
        return '#include "' + path.as_posix() + '"'
    text = re.sub(r'^\s*#\s*include\s*"([^"]+)"', include, text, flags=re.M)
    (work / 'header.h').write_text(text, encoding='utf-8')
    probe = '#include "header.h"\n'
    # Typed initializers independently check the reviewed source contract;
    # the later void-address table is only for easy relocation extraction.
    if signatures:
        for index, (name, signature) in enumerate(signatures.items()):
            probe += (signature['return'] + ' (*p875_typed_' + str(index) + ')('
                      + signature['parameters'] + ') = &' + name + ';\n')
    probe += 'void *p875_root_references[] = {\n'
    probe += ''.join('    (void *)&' + name + ',\n' for name in names)
    probe += '};\n'
    src = work / 'probe.cpp'; pre = work / 'probe.i'; asm = work / 'probe.s'
    src.write_text(probe, encoding='utf-8')
    for cmd in [[b.CPP,'-x','c','-D__cplusplus=1','-nostdinc','-undef','-Dmips','-D__mips__','-D__psx__','-I'+str(b.RECON),src,'-o',pre],
                [b.CC1PL,'-quiet','-O2','-G4',pre,'-o',asm]]:
        proc = subprocess.run(list(map(str,cmd)), cwd=ROOT, capture_output=True, text=True)
        if proc.returncode:
            return {'compile': False, 'error': (proc.stdout+proc.stderr)[-6000:]}
    body = asm.read_text(encoding='utf-8')
    # Read only this test array; unrelated retained declarations may emit data.
    start = body.find('p875_root_references:')
    if start < 0:
        return {'compile': False, 'error': 'Missing probe array'}
    tail = body[start:].splitlines()[1:]
    refs = []
    for line in tail:
        m = re.match(r'\s*\.word\s+(\S+)\s*$',line)
        if m:
            refs.append(m[1])
        elif refs and not line.strip().startswith(('.align','#')) and line.strip():
            break
    return {'compile': True, 'references': refs}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('mode', choices=['before','candidate','current'])
    args = parser.parse_args()
    plan = json.loads(Path(__file__).with_name('p875_root_header_plan.json').read_text())
    snapshots = {r['header']: r['before'] for r in json.loads(
        Path(__file__).with_name('p875_root_header_snapshots.json').read_text())}
    results = []
    for name in sorted({x['header'] for x in plan}):
        header = ROOT / name; rows = [x for x in plan if x['header']==name]
        # P875 review: rerunning historical modes must not silently use repaired
        # production headers or erase evidence of the original compile failures.
        text = (header.read_text(encoding='utf-8') if args.mode == 'current'
                else snapshots[name])
        refs = []; expected = []
        if args.mode == 'before':
            refs = [r['symbol'] for r in rows]
        else:
            for row in rows:
                assert len(row['native'])==len(row['definitions'])==1,row['symbol']
                if row['native'][0]['storage']=='STAT':
                    if args.mode=='candidate': text=text.replace(row['old']+'\n','',1)
                    continue
                if args.mode=='candidate':
                    updated=row['definitions'][0]['signature']+';'
                    suffix=row['old'].split(';',1)[1]
                    assert text.count(row['old'])==1,row['symbol']
                    text=text.replace(row['old'],updated+suffix,1)
                refs.append(row['name']); expected.append(row['symbol'])
        signatures = ({r['name']:r['definitions'][0] for r in rows
                       if r['native'][0]['storage']=='EXT'}
                      if args.mode != 'before' else None)
        result=compile_probe(header,text,refs,header.stem,args.mode,signatures)
        result.update(header=name, mode=args.mode, count=len(refs), expected=expected)
        if expected and result['compile']:
            result['exact']=result['references']==expected
        results.append(result)
        print(name, 'COMPILE-FAIL' if not result['compile'] else ('EXACT' if result.get('exact') else 'COMPILED'),len(refs),flush=True)
        if not result['compile']: print(result['error'],flush=True)
        elif expected and not result['exact']:
            for x,y in zip(result['references'],expected):
                if x!=y: print(' emitted',x,'expected',y,flush=True)
    output=Path(__file__).with_name('p875_root_header_'+args.mode+'.json')
    output.write_text(json.dumps(results,indent=2)+'\n')
    print(output)


if __name__=='__main__': main()
