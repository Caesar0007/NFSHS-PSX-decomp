"""P876 before/after gates for compiler-proven shared-header consumers.

Read-only source; ordinary source-only compiler runs. Object hashes are compared
without normalization, and data-only owners are not claimed as function PASSes.
"""
from pathlib import Path
import hashlib
import json
import os
import re
import subprocess
import sys

ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).resolve().parent
mode=sys.argv[1]
assert mode in ('before','after')
inventory=json.loads((HERE/'consumers_before.json').read_text())
sources=[r['source'] for r in inventory['rows'] if r['consumer']]
assert inventory['failures']==0 and len(sources)==36
baseline=({r['source']:r for r in json.loads((HERE/'regression_before.json').read_text())}
          if mode=='after' else {})
rows=[]
for source in sources:
    proc=subprocess.run([sys.executable,'tools/tugate.py',source],cwd=ROOT,
                        env=dict(os.environ,NFS4_SOURCE_ONLY='1'),
                        capture_output=True,text=True)
    obj=ROOT/('build/'+source+'.o')
    match=re.search(r': (\d+)/(\d+) PASS',proc.stdout)
    row=dict(source=source,returncode=proc.returncode,stdout=proc.stdout,stderr=proc.stderr,
             sha256=hashlib.sha256(obj.read_bytes()).hexdigest() if obj.exists() else None,
             passed=int(match[1]) if match else None,total=int(match[2]) if match else None)
    if mode=='after':
        row['identical']=row['sha256'] is not None and row['sha256']==baseline[source]['sha256']
        row['same_gate']=row['stdout']==baseline[source]['stdout']
    rows.append(row)
    print(source, f"{row['passed']}/{row['total']}",row.get('identical','BASELINE'),flush=True)
(HERE/('regression_'+mode+'.json')).write_text(json.dumps(rows,indent=2)+'\n')
print('Function gates:',sum(r['passed'] or 0 for r in rows),'/',sum(r['total'] or 0 for r in rows))
if mode=='after':
    print('Entire objects identical:',sum(r['identical'] for r in rows),'/',len(rows))
raise SystemExit(0 if all(r['returncode']==0 and r['sha256'] and
                          r.get('identical',True) and r.get('same_gate',True) for r in rows) else 1)
