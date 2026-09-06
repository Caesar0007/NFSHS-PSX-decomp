"""Re-gate all twelve production source TUs changed in P879-P883.

Detailed source-only gates and branch checks are authoritative. Whole-object
receipts supplement, rather than replace, the local-static/AudioTrk raw proofs.
"""
from pathlib import Path
import hashlib
import json
import os
import subprocess
import sys

ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).resolve().parent
units=[
 ('frontend/common/feapp.cpp',16,'aed59b1d17dd6befe6112862e1d2233441c9a484a071c86f50132db2e17ca65a'),
 ('frontend/common/fecheats.cpp',10,'247787507f828f0aff103d87ccf932e9458066ddf39f2f2b1dbfe69c67e6bc41'),
 ('frontend/common/fecredits.cpp',7,None),
 ('frontend/common/fedialog.cpp',32,'c6c396dcd266d5d211506f03e71c8ee09ae2cc0f01282b4ef0bcbf9897156983'),
 ('frontend/common/femenudefs.cpp',66,'e5f8a1f116f2e9aeecfbf0d2d96c5e4e6a6164caea5ef588aec3690449580fd0'),
 ('frontend/common/femenuoptions.cpp',92,'1eb642e6b40eb40eeb8c6e198d711f468fc51731a1997c822c5ed1ecd3a2cbf6'),
 ('frontend/common/fescreen.cpp',27,'7228f949f9999f27c5fd1395036b6cf88d71fd1307c21e8fffd279728e59f0c0'),
 ('frontend/common/fetextrender.cpp',17,'fc573287922a2dc9949dd2cc97b5d714612ba489c1ea87a6a07c9e3fb0a62260'),
 ('frontend/common/front.cpp',43,'aa730506c2578190bce89be3559cef70c4494582b1af0d37a37497f5a4c8c5fb'),
 ('frontend/common/screenmemcard.cpp',15,'fa86b7250da7ac05498145ad09161ae01fb10664eb1c91838aec57401b666c25'),
 ('game/common/audiotrk.cpp',6,None),
 ('game/common/copspeak.cpp',27,'70fc97ebe71e9feeb970a4af6af67f16969a2171d4a82bfc1a35834376f9807e'),
]
env=dict(os.environ,NFS4_SOURCE_ONLY='1')
rows=[]
for part,count,expected in units:
    source='recon/'+part
    checks=[]
    print('RUN',source,flush=True)
    for tool in ('tugate.py','brdist.py'):
        p=subprocess.run([sys.executable,'tools/'+tool,source],cwd=ROOT,env=env,capture_output=True,text=True)
        assert p.returncode==0,(source,tool,p.stdout,p.stderr)
        checks.append(dict(tool=tool,stdout=p.stdout,stderr=p.stderr))
    assert f'{count}/{count} PASS' in checks[0]['stdout'],checks[0]
    assert ', 0 with branch-offset/count divergence' in checks[1]['stdout'],checks[1]
    obj=ROOT/'build'/(source+'.o')
    actual=hashlib.sha256(obj.read_bytes()).hexdigest()
    if expected is not None:
        assert actual==expected,(source,actual,expected)
    rows.append(dict(source=source,pass_count=count,branch_divergences=0,
                     source_sha256=hashlib.sha256((ROOT/source).read_bytes()).hexdigest(),
                     object_sha256=actual,prior_verified_object_equal=expected is not None,checks=checks))
    (HERE/'checkpoint_source_receipts.json').write_text(json.dumps(rows,indent=2)+'\n')
    print(f'PASS {count}/{count}, branches0',flush=True)
assert sum(r['pass_count'] for r in rows)==358
print('PASS:358/358 functions across all12 changed base source TUs; branches0.',flush=True)
