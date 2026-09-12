"""Additional read-only include/source disposition; frozen runtime proof stays intact."""
from pathlib import Path
import datetime, hashlib, json, re, subprocess
ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
receipt=json.loads((HERE/'host_receipt.json').read_text(encoding='utf-8'))
sha=lambda b:hashlib.sha256(b).hexdigest()
closure={};command_rows=[]
sources=[ROOT/'recon/eaclib/psx/eacpsxz'/(row['name']+'.c') for row in receipt['source_proofs']]
sources.append(HERE/'check_host.c')
for source in sources:
    command=[receipt['compiler'],'-std=gnu99','-iquote',str(ROOT/'recon'),'-H','-E',str(source)]
    process=subprocess.run(command,cwd=ROOT,capture_output=True,encoding='utf-8',errors='replace')
    assert process.returncode==0,(source,process.stderr)
    paths=[source]+[Path(line.split(' ',1)[1].strip()) for line in process.stderr.splitlines() if re.match(r'^\.+ ',line)]
    rows=[]
    for path in paths:
        if not path.is_absolute():path=ROOT/path
        path=path.resolve();assert path.is_file(),path
        closure[str(path)]=sha(path.read_bytes());rows.append(str(path))
    command_rows.append(dict(source=str(source),command=command,include_paths=rows))
for row in receipt['source_proofs']:
    assert sha((ROOT/'recon/eaclib/psx/eacpsxz'/(row['name']+'.c')).read_bytes())==row['actual_sha256']
base='b36aebd025c217956a40ed448d173111ff7f9e7c'
cross=ROOT/'recon/eaclib/psx/eacpsxz/crossprd.c'
old=subprocess.check_output(['git','show',base+':recon/eaclib/psx/eacpsxz/crossprd.c'],cwd=ROOT).decode('utf-8')
new=cross.read_text(encoding='utf-8')
def cross_body(text):
    at=text.index('int *crossproduct(');start=text.index('{',at)
    return text[start:text.rindex('}')+1]
def tokens(text):
    clean=re.sub(r'/\*.*?\*/|//[^\n]*','',text,flags=re.S)
    return re.findall(r'\w+|\S',clean)
assert tokens(cross_body(old))==tokens(cross_body(new))
assert not re.search(r'\btmp[012]\b',cross_body(new))
result=dict(timestamp_utc=datetime.datetime.now(datetime.timezone.utc).isoformat(),read_only=True,
    host_receipt_sha256=sha((HERE/'host_receipt.json').read_bytes()),actual_source_and_include_hashes=closure,
    include_commands=command_rows,crossproduct_actual_sha256=sha(cross.read_bytes()),
    crossproduct_body_tokens_equal_b36=True,no_new_tmp0_tmp1_tmp2=True,
    frozen_initial_include_harness_failure='before_O0/compile_stderr.txt: -I recon selected PSX stddef instead of Win64 header; corrected only the harness to -iquote',
    pre_existing_qualification=receipt['qualification'])
(HERE/'host_disposition.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print(json.dumps(dict(closure_files=len(closure),crossproduct_body_restored=True,all_source_hashes_stable=True)))
