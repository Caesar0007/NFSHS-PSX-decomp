"""Explicit, fail-closed P898-P903 publication staging. No broad git add."""
from pathlib import Path
import hashlib,json,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
BASE='df4e6e0a58934686ea3b424bcde666af5a306f92'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def git(*args):return subprocess.check_output(['git',*args],cwd=ROOT,text=True).strip()
def blob(path):return git('hash-object','--path='+path,path)
def read(path):return json.loads((ROOT/path).read_text())
mode=sys.argv[1];assert mode in ('prepare','stage','check')
assert git('branch','--show-current')=='main'
assert git('rev-parse','HEAD')==git('rev-parse','origin/main')==BASE
integration=read('scratchpad/p903_upstream_eac/normal_integration.json')
assert integration['passed'] and integration['combined_protected_instances']==1341
assert integration['linked_ELF_literal_unchanged'] and integration['linked_map_literal_unchanged']
assert sha(ROOT/'build/gen_ld/recon_multdef-ok.elf')==integration['linked_ELF_sha256']
host=read('scratchpad/p903_upstream_eac/host/host_receipt.json')
assert len(host['tests'])==4 and all(t['result']['status']=='PASS' and t['result']['checks']==1066499 for t in host['tests'])
for p,h in read('scratchpad/p903_upstream_eac/final_source_include_hashes.json').items():assert sha(Path(p))==h,p
for r in read('scratchpad/p903_checkpoint/source_receipts.json'):assert sha(ROOT/r['source'])==r['source_sha256']
assert sha(ROOT/'scratchpad/w85/o2.txt')=='d433425b806fc8abd1fa60c9f72a09f4c022bfd64a7fecf4df496931169e9546'
manifest_path='scratchpad/p903_checkpoint/publication_manifest.json'
if mode=='prepare':
    assert not git('diff','--cached','--name-only'),'Preserve an existing index; do not stage over it'
    paths={f'recon/game/common/{n}.cpp' for n in ('aiphysic','audiotrk','audiomus','audiocmn')}
    paths|={f'recon/eaclib/psx/eacpsxz/{n}.c' for n in ('primate','callback','blkfill','sinfunc','fixddiv','fixdinv','fixdmult','crossprd')}
    paths.add('scratchpad/root_sym_audit/ORIGINAL_SOURCE_NAME_BACKLOG_20260903.md')
    for n in range(898,904):
        for name in ('README.md','final_receipts.json','regression_receipt.json'):
            p=f'scratchpad/p{n}_checkpoint/{name}';assert (ROOT/p).is_file(),p;paths.add(p)
    roots=('p898_aiphysic_scope_resume_20260912','p898_audio_soundtrack','p898_audio_preload',
      'p899_aiphysic_sld','p899_audio_reset','p899_soundtrack_scope','p899_soundtrack_expressions','p899_audio_landed_20260912',
      'p900_audio_addcustom','p900_audio_lifecycle','p900_soundtrack_sld','p900_audio_landed_20260912',
      'p901_audiomus_threshold','p901_audio_inline_identity','p901_soundtrack_sld','p901_audio_landed_20260912',
      'p902_audiomus_server','p902_audioeng_cleanup','p902_audiocmn_async','p902_audiocmn_landed_20260912',
      'p903_audiomus_playsong','p903_audiomus_landed_20260912','p903_audiocmn_traffic','p903_audiocmn_soundcar','p903_audiocmn_landed_20260912')
    names=('README.md','final_receipt.json','final_comment_receipt.json','landed_verified.json','landed_verification.json',
           'combined_verification.json','peer_receipt.json','peer_review.json','candidate_verified.json')
    for directory in roots:
        assert (ROOT/'scratchpad'/directory).is_dir(),directory
        for name in names:
            p=ROOT/'scratchpad'/directory/name
            if p.is_file():paths.add(p.relative_to(ROOT).as_posix())
    paths|={f'scratchpad/p903_upstream_eac/{n}' for n in ('FINAL.md','audit.md','final_comparison.json',
      'normal_integration.json','semantic_bindings.json','final_source_include_hashes.json',
      'host/disposition.md','host/host_receipt.json','host/check_host.c','host/run_host.py','host/finalize_host.py')}
    paths|={'scratchpad/p903_audiocmn_soundcar/compiler_dead_product.md','scratchpad/p903_audiocmn_soundcar/peer_static_table.md',
      'scratchpad/p902_audiomus_server/compiler_angle.md','scratchpad/p903_checkpoint/PUBLICATION_READY.md',
      'scratchpad/p903_checkpoint/publish_checkpoint.py'}
    assert all((ROOT/p).is_file() for p in paths)
    assert not any(p.startswith(('build/','expected/')) or '/inputs/' in p or '/backups/' in p or p.endswith(('.o','.i','.s','.exe','.dll','.binpb','.map')) for p in paths)
    rows=[dict(path=p,bytes=(ROOT/p).stat().st_size,sha256=sha(ROOT/p),git_blob=blob(p)) for p in sorted(paths)]
    data=dict(base=BASE,explicit_user_approval=True,scope='Verified P898-P903 plus audited upstream integration repairs',
      excluded_user_file='scratchpad/w85/o2.txt',generated_build_outputs_excluded=True,files=rows)
    (ROOT/manifest_path).write_text(json.dumps(data,indent=2)+'\n')
    print(json.dumps(dict(files=len(rows)+1,bytes=sum(r['bytes'] for r in rows),paths=[r['path'] for r in rows]),indent=2))
    raise SystemExit
manifest=read(manifest_path);assert manifest['base']==BASE and manifest['explicit_user_approval']
for r in manifest['files']:
    assert sha(ROOT/r['path'])==r['sha256'] and blob(r['path'])==r['git_blob'],r['path']
paths=[r['path'] for r in manifest['files']]+[manifest_path]
if mode=='stage':
    assert not git('diff','--cached','--name-only'),'Index changed; stop rather than overwrite staging'
    subprocess.run(['git','-c','core.safecrlf=false','add','--',*paths],cwd=ROOT,check=True)
staged=subprocess.check_output(['git','diff','--cached','--name-only','-z'],cwd=ROOT).decode().rstrip('\0').split('\0')
assert set(staged)==set(paths),(set(staged)-set(paths),set(paths)-set(staged))
for r in manifest['files']:assert git('rev-parse',':'+r['path'])==r['git_blob'],r['path']
assert git('rev-parse',':'+manifest_path)==blob(manifest_path)
subprocess.run(['git','-c','core.safecrlf=false','diff','--cached','--check'],cwd=ROOT,check=True)
assert 'scratchpad/w85/o2.txt' not in staged
print(json.dumps(dict(staging_verified=True,files=len(staged),base=BASE,unrelated_user_edits_excluded=True),indent=2))
