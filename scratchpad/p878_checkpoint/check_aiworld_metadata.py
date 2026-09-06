"""Adjudicate the source-path-case-only hash variation in the final sweep."""
from pathlib import Path
import hashlib
import json
import os
import struct
import subprocess
import sys

ROOT=Path(__file__).resolve().parents[2]
obj=ROOT/'build/recon/game/common/AIWORLD.cpp.o'
lower_run=subprocess.run([sys.executable,'tools/tugate.py','recon/game/common/aiworld.cpp'],
                         cwd=ROOT,env=dict(os.environ,NFS4_SOURCE_ONLY='1'),capture_output=True,text=True)
assert lower_run.returncode==0 and '22/22 PASS' in lower_run.stdout
lower=obj.read_bytes()
run=subprocess.run([sys.executable,'tools/tugate.py','recon/game/common/AIWORLD.cpp'],
                    cwd=ROOT,env=dict(os.environ,NFS4_SOURCE_ONLY='1'),capture_output=True,text=True)
assert run.returncode==0 and '22/22 PASS' in run.stdout
upper=obj.read_bytes()
assert len(lower)==len(upper)
assert upper[:6]==b'\x7fELF\x01\x01'
shoff=struct.unpack_from('<I',upper,32)[0]
entsize,num,names_index=struct.unpack_from('<HHH',upper,46)
sections=[struct.unpack_from('<10I',upper,shoff+i*entsize) for i in range(num)]
name_header=sections[names_index]
names=upper[name_header[4]:name_header[4]+name_header[5]]
strtab=next(s for s in sections if names[s[0]:].split(b'\0',1)[0]==b'.strtab')
diffs=[i for i,(a,b) in enumerate(zip(lower,upper)) if a!=b]
assert len(diffs)==7,diffs
assert all(strtab[4]<=i<strtab[4]+strtab[5] for i in diffs)
assert all(chr(lower[i]).upper()==chr(upper[i]) for i in diffs)
report=json.loads((ROOT/'scratchpad/root_sym_audit/p878_final_common_psx_validation_20260906.json').read_text())
row=next(r for r in report['rows'] if r['source'].lower().endswith('/aiworld.cpp'))
upper_hash=hashlib.sha256(upper).hexdigest()
assert upper_hash==row['accepted_object_sha256']
result=dict(functions='22/22 PASS',differences=7,only_section='.strtab',
            program_and_relocation_bytes_identical=True,
            lowercase_sha256=hashlib.sha256(lower).hexdigest(),uppercase_sha256=upper_hash,
            exact_accepted_hash_restored_by_same_input=True,gate=run.stdout)
Path(__file__).with_name('aiworld_metadata_receipt.json').write_text(json.dumps(result,indent=2)+'\n')
print('PASS: only7 source-filename case bytes differ, allin.strtab; identical program/relocation bytes.')
print('PASS: same uppercase source input reproduces the exact accepted full object.')
