"""P882 frontend source-only gates; do not declare full source fidelity."""
from pathlib import Path
import hashlib
import json
import os
import subprocess
import sys

ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).resolve().parent
env=dict(os.environ,NFS4_SOURCE_ONLY='1')
units=[('fedialog',32,'c6c396dcd266d5d211506f03e71c8ee09ae2cc0f01282b4ef0bcbf9897156983'),
       ('fescreen',27,'7228f949f9999f27c5fd1395036b6cf88d71fd1307c21e8fffd279728e59f0c0'),
       ('femenuoptions',92,'1eb642e6b40eb40eeb8c6e198d711f468fc51731a1997c822c5ed1ecd3a2cbf6')]
rows=[]
for stem,count,expected in units:
    source=f'recon/frontend/common/{stem}.cpp'
    checks=[]
    for tool in ('tugate.py','brdist.py'):
        p=subprocess.run([sys.executable,'tools/'+tool,source],cwd=ROOT,env=env,capture_output=True,text=True)
        assert p.returncode==0,(source,tool,p.stdout,p.stderr)
        checks.append(dict(tool=tool,stdout=p.stdout,stderr=p.stderr))
    assert f'{count}/{count} PASS' in checks[0]['stdout']
    assert ', 0 with branch-offset/count divergence' in checks[1]['stdout']
    obj=ROOT/'build'/(source+'.o')
    digest=hashlib.sha256(obj.read_bytes()).hexdigest()
    assert digest==expected,(source,digest,expected)
    rows.append(dict(source=source,source_sha256=hashlib.sha256((ROOT/source).read_bytes()).hexdigest(),
                     object_sha256=digest,normal_pass=count,checks=checks))
(HERE/'receipts.json').write_text(json.dumps(rows,indent=2)+'\n')
print('PASS:151/151 frontend functions,3 whole objects unchanged,all branch checks clean.')
