"""Capture production regional gates and prove all startup relocation fields."""
from pathlib import Path
import json
import os
import re
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
stage = 'final_regional_p879'
env = dict(os.environ, NFS4_SOURCE_ONLY='1')
gates = []
for region, expected in [('AU', 3), ('USA', 1)]:
    path = 'regiondiff/recon/NFS4-R-' + region + '/game/common/nfs3.cpp'
    command = [sys.executable, 'scratchpad/p879_copspeak/consumer_gate.py', stage, path]
    result = subprocess.run(command, cwd=ROOT, env=env, capture_output=True, text=True)
    assert result.returncode == 0, (command, result.stdout, result.stderr)
    row = json.loads(result.stdout)
    assert row['gate'].count('REGION-PASS') == expected, row
    failures = re.findall(r'^\s+(\S+): FAIL (.*)$', row['gate'], re.M)
    assert row['gate_exit'] == 0 and not failures, row
    assert not row.get('missing_object'), row
    gates.append(row)
objects = ROOT / 'scratchpad/p879_copspeak' / stage
command = [sys.executable, str(HERE/'raw_check.py'), '--objects-dir', str(objects)]
result = subprocess.run(command, cwd=ROOT, env=env, capture_output=True, text=True)
assert result.returncode == 0, (result.stdout, result.stderr)
raw = json.loads(result.stdout)
assert len(raw) == 2 and all(r['words_checked'] == 25 for r in raw)
command = [sys.executable, str(HERE/'loadperps_raw_check.py'), '--object',
           str(objects/'regiondiff__recon__NFS4-R-AU__game__common__nfs3.cpp.o')]
result = subprocess.run(command, cwd=ROOT, env=env, capture_output=True, text=True)
assert result.returncode == 0, (result.stdout, result.stderr)
loadperps = json.loads(result.stdout)
assert loadperps['words'] == 172 and loadperps['whole_rodata_bytes_exact'] == 71
report = dict(production_gates=gates, raw_startups=raw,
              au_loadperps=loadperps,
              qualification='AU LoadPerps is now repaired at172/172 with raw-proven regional filename; missing USA LoadingIcon/main oracles are not claimed as PASS.')
old = HERE/'production_receipts.json'
history = HERE/'pre_loadperps_production_receipts.json'
if old.exists() and not history.exists():
    history.write_text(old.read_text())
(HERE/'production_receipts.json').write_text(json.dumps(report, indent=2)+'\n')
print('PASS: AU3/3 + USA1/1; both25-word startups and AU172-word LoadPerps raw/reference checks; all71 AU rodata bytes exact.')
