"""Final P877 replay owner: native records, raw oracle words and normal tools."""
from pathlib import Path
import hashlib
import json
import os
import re
import struct
import subprocess
import sys

ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).resolve().parent
source=ROOT/'recon/game/common/replay.cpp'
functions=re.findall(r'/\* ---- (Replay_\S+)\s+\[',source.read_text())
assert len(functions)==16
native=Path(r'C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt').read_text()
rom=(ROOT/'rom/nfs4-f.exe').read_bytes()
load=struct.unpack_from('<I',rom,0x18)[0]
records=[];words=0
for function in functions:
    matches=re.findall(r'(?m)^.*Def(?:2)? class EXT type FCN[^\r\n]* name '+re.escape(function)+r'\r?$',native)
    assert len(matches)==1,(function,matches)
    oracle=ROOT/('asm/nonmatchings/main/'+function+'.s')
    count=0
    for address,raw in re.findall(r'/\*\s+\w+\s+([0-9a-fA-F]{8})\s+([0-9a-fA-F]{8})\s*\*/',oracle.read_text()):
        offset=int(address,16)-load+0x800
        assert offset>=0 and rom[offset:offset+4]==bytes.fromhex(raw),(function,address)
        count+=1
    words+=count
    records.append(dict(function=function,native_record=matches[0],raw_words=count))
env=dict(os.environ,NFS4_SOURCE_ONLY='1')
commands=[['tools/tugate.py','recon/game/common/replay.cpp'],
          ['tools/brdist.py','recon/game/common/replay.cpp'],
          ['tools/diffsrc.py','recon/game/common/replay.cpp','Replay_StoringControllerData__FG15tControllerData'],
          ['tools/diffsrc.py','recon/game/common/replay.cpp','Replay_ResetReplay__Fv']]
checks=[]
for args in commands:
    run=subprocess.run([sys.executable,*args],cwd=ROOT,env=env,capture_output=True,text=True)
    assert run.returncode==0,(args,run.stdout,run.stderr)
    checks.append(dict(command=args,stdout=run.stdout,stderr=run.stderr,returncode=run.returncode))
assert '16/16 PASS' in checks[0]['stdout']
assert '0 with branch-offset/count divergence' in checks[1]['stdout']
assert all('-g twin EXACT' in r['stdout'] for r in checks[2:])
obj=ROOT/'build/recon/game/common/replay.cpp.o'
before=ROOT/'build/scratchpad/p877_replay/replay.mixed.before.o'
assert obj.read_bytes()==before.read_bytes()
report=dict(functions=16,raw_words=words,native_records=records,checks=checks,
            source_sha256=hashlib.sha256(source.read_bytes()).hexdigest(),
            final_object_sha256=hashlib.sha256(obj.read_bytes()).hexdigest(),
            equals_old_normal_mixed_object=True)
(HERE/'final_replay_receipts.json').write_text(json.dumps(report,indent=2)+'\n')
print('16 native EXT identities;',words,'raw oracle words verified;16/16 PASS;branch0.')
print('Storing/Reset debug twins exact;entire object equals old mixed compilation.')
