"""One actual P879 consumer build/gate; only compiler output/snapshots written."""
import contextlib
import csv
import hashlib
import importlib.util
import io
import json
import os
import shutil
import subprocess
import sys
from pathlib import Path
from elf_snapshot import snap

ROOT=Path(__file__).resolve().parents[2]
WORK=Path(__file__).resolve().parent
stage, source=sys.argv[1:3]
relative=Path(source)
os.environ['NFS4_SOURCE_ONLY']='1'
result={'source':source,'stage':stage,'source_sha256':hashlib.sha256((ROOT/source).read_bytes()).hexdigest()}
if source.startswith('recon/'):
    for key, tool in [('gate','tugate.py'),('branches','brdist.py')]:
        run=subprocess.run([sys.executable,str(ROOT/'tools'/tool),source],cwd=ROOT,capture_output=True,text=True)
        result[key]=run.stdout+run.stderr
        result[key+'_exit']=run.returncode
    obj=ROOT/'build'/(source+'.o')
else:
    region=relative.parts[2]
    short=region.removeprefix('NFS4-R-')
    unit='/'.join(relative.parts[3:]).removesuffix('.cpp')
    if relative.parts[3]=='regiononly':
        functions=[relative.stem]
        lane=None
    else:
        manifest=list(csv.DictReader((ROOT/'regiondiff/MANIFEST.tsv').open(),delimiter='\t'))
        functions=list(dict.fromkeys(r['function'] for r in manifest
                                     if r['unit']==unit and short in r['group'].split('+')))
        lane='recon/'+unit+'.cpp'
    assert functions, 'No regional oracle target selected: '+source
    result['regional_targets']=functions
    script=ROOT/'regiondiff/tools/verify_region.py'
    sys.argv=[str(script),region,source,','.join(functions)]
    if lane: sys.argv.append('--lane-as='+lane)
    spec=importlib.util.spec_from_file_location('p879_region_gate',script)
    module=importlib.util.module_from_spec(spec)
    output=io.StringIO()
    with contextlib.redirect_stdout(output), contextlib.redirect_stderr(output):
        try:
            spec.loader.exec_module(module)
            code=0
        except SystemExit as error:
            code=error.code
    result['gate']=output.getvalue()
    result['gate_exit']=code
    obj=getattr(module,'obj',None)
    result['lane_as']=lane
if obj is not None and obj.exists():
    copy=WORK/stage/(source.replace('/','__')+'.o')
    copy.parent.mkdir(parents=True,exist_ok=True)
    shutil.copyfile(obj,copy)
    result['object_snapshot']=snap(copy)
else:
    result['missing_object']=True
print(json.dumps(result))
