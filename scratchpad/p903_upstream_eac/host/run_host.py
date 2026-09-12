"""Bounded actual-host revalidation; no normal PSX/source/tool outputs."""
from pathlib import Path
import datetime, hashlib, json, re, shutil, struct, subprocess
ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
SOURCE=ROOT/'recon/eaclib/psx/eacpsxz'
BASE='b36aebd025c217956a40ed448d173111ff7f9e7c'
names=['blkfill','sinfunc','fixddiv','fixdinv','fixdmult','sintbl']
sha=lambda data:hashlib.sha256(data).hexdigest()
gcc=shutil.which('gcc');assert gcc
def run(command,**kw):
    return subprocess.run([str(x) for x in command],cwd=ROOT,capture_output=True,text=True,encoding='utf-8',errors='replace',**kw)
version=run([gcc,'--version']);assert not version.returncode
machine=run([gcc,'-dumpmachine']);assert machine.stdout.strip()=='x86_64-w64-mingw32',machine.stdout
macros=run([gcc,'-dM','-E','-x','c','-'],input='');assert not macros.returncode
assert '__mips__' not in macros.stdout
token_re=re.compile(r'/\*.*?\*/|//[^\n]*|"(?:\\.|[^"\\])*"|\x27(?:\\.|[^\x27\\])*\x27|[A-Za-z_]\w*|0[xX][0-9A-Fa-f]+|\d+|\S',re.S)
def tokens(source):return [m[0] for m in token_re.finditer(source) if not m[0].startswith(('/*','//')) and m[0]!='extern']
source_proofs=[]
for name in names:
    baseline=subprocess.check_output(['git','show',BASE+':recon/eaclib/psx/eacpsxz/'+name+'.c'],cwd=ROOT)
    staged=(HERE/'before'/(name+'.c')).read_bytes()
    actual=(SOURCE/(name+'.c')).read_bytes()
    baseline_text=baseline.decode('utf-8').replace('\r\n','\n')
    assert baseline_text.rstrip('\n')==staged.decode('utf-8').replace('\r\n','\n').rstrip('\n')
    actual_text=actual.decode('utf-8').replace('\r\n','\n')
    row=dict(name=name,baseline_git_sha256=sha(baseline),staged_sha256=sha(staged),actual_sha256=sha(actual))
    if name!='sintbl':
        def arms(text):
            m=re.search(r'^#if defined\(__mips__\)\s*\n(.*?)^#else[^\n]*\n(.*?)^#endif',text,re.S|re.M)
            assert m,name
            return m.group(1),m.group(2)
        before_mips,before_host=arms(baseline_text);actual_mips,actual_host=arms(actual_text)
        assert tokens(before_mips)==tokens(actual_mips),(name,'MIPS tokens changed')
        assert tokens(before_host)==tokens(actual_host),(name,'host tokens changed')
        row.update(mips_arm_tokens_identical=True,host_arm_tokens_identical_ignoring_comments_and_extern=True)
    else:
        def values(text):return [int(x,0) for x in re.findall(r'\b(?:0x[0-9a-fA-F]+|\d+)\b',re.sub(r'/\*.*?\*/','',text.split('=',1)[1],flags=re.S))]
        b,a=values(baseline_text),values(actual_text);assert len(a)==257 and a==b
        raw=(ROOT/'rom/nfs4-f.exe').read_bytes();load=struct.unpack_from('<I',raw,0x18)[0]
        table=struct.pack('<257i',*a);offset=0x800+0x80137464-load
        assert raw[offset:offset+len(table)]==table
        row.update(table_words=257,table_raw_address='80137464',table_payload_sha256=sha(table),table_matches_raw=True)
    source_proofs.append(row)
result=dict(timestamp_utc=datetime.datetime.now(datetime.timezone.utc).isoformat(),compiler=gcc,compiler_sha256=sha(Path(gcc).read_bytes()),
    compiler_version=version.stdout,target_machine=machine.stdout.strip(),host_macro_sha256=sha(macros.stdout.encode()),
    source_proofs=source_proofs,tests=[],qualification=[
    'Host runtime/native Win64 only; no PSX recompilation or compiler-output rewriting.',
    'INT_MIN is tested for fixedmult and safe-angle sine/cosine; pre-existing signed abs/negation overflow cases excluded for division/inverse.',
    'fixedinverse(0) is outside the retained fallback domain (division by zero); no false zero-input PASS claim.',
    'All checks compare restored old behavior; full original-source identity or cross-target portability is not claimed.'])
for stage in ('before','actual'):
    for optimization in ('-O0','-O2'):
        out=HERE/(stage+optimization.replace('-','_')+'_iquote');out.mkdir(exist_ok=False)
        sources=[(HERE/'before' if stage=='before' else SOURCE)/(name+'.c') for name in names]
        # Frozen before_O0 is the failed harness include-path attempt: -I recon
        # shadowed Win64 stddef.h with the PSX 32-bit shim. Quote-only lookup
        # exposes actual owner headers without replacing native system headers.
        command=[gcc,'-std=gnu99',optimization,'-Wall','-Wextra','-Werror=return-type','-iquote',ROOT/'recon',HERE/'check_host.c',*sources,'-o',out/'check_host.exe']
        compile_result=run(command)
        (out/'compile_stdout.txt').write_text(compile_result.stdout,encoding='utf-8')
        (out/'compile_stderr.txt').write_text(compile_result.stderr,encoding='utf-8')
        assert compile_result.returncode==0,(stage,optimization,compile_result.stdout,compile_result.stderr)
        runtime=run([out/'check_host.exe']);assert runtime.returncode==0,(stage,optimization,runtime.stdout,runtime.stderr)
        report=json.loads(runtime.stdout);assert report['status']=='PASS'
        entry=dict(stage=stage,optimization=optimization,command=[str(x) for x in command],result=report,
            executable_sha256=sha((out/'check_host.exe').read_bytes()),compile_stderr=compile_result.stderr)
        result['tests'].append(entry)
        (out/'runtime.json').write_text(json.dumps(entry,indent=2)+'\n',encoding='utf-8')
        print(json.dumps(dict(stage=stage,optimization=optimization,result=report)),flush=True)
assert all(t['result']==result['tests'][0]['result'] for t in result['tests'])
result['all_actual_input_hashes_still_equal']=all(sha((SOURCE/(r['name']+'.c')).read_bytes())==r['actual_sha256'] for r in source_proofs)
assert result['all_actual_input_hashes_still_equal']
(HERE/'host_receipt.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
