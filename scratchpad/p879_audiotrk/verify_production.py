"""Rebuild and independently raw-link the landed P879 AudioTrk source.

GNU ld applies ordinary source relocations at native addresses. This does not
rewrite, patch, retarget or replace any compiler-generated instruction.
"""
from pathlib import Path
import hashlib
import json
import os
import re
import struct
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
SOURCE = 'recon/game/common/audiotrk.cpp'
FN = 'AudioTrk_AddCustomObject__FP9AudioElemiP8coorddefiP8Car_tObji'
env = dict(os.environ, NFS4_SOURCE_ONLY='1')
checks = []
for command in [['tools/tugate.py', SOURCE], ['tools/brdist.py', SOURCE],
                ['tools/diffsrc.py', SOURCE, FN]]:
    run = subprocess.run([sys.executable, *command], cwd=ROOT, env=env,
                         capture_output=True, text=True)
    assert run.returncode == 0, (command, run.stdout, run.stderr)
    checks.append(dict(command=command, stdout=run.stdout, stderr=run.stderr))
assert '6/6 PASS' in checks[0]['stdout']
assert '0 with branch-offset/count divergence' in checks[1]['stdout']
assert '-g twin EXACT' in checks[2]['stdout']

def sections(path):
    data = path.read_bytes()
    assert data[:6] == b'\x7fELF\x01\x01'
    offset = struct.unpack_from('<I', data, 32)[0]
    width, count, strings = struct.unpack_from('<HHH', data, 46)
    headers = [struct.unpack_from('<10I', data, offset + i*width)
               for i in range(count)]
    names_header = headers[strings]
    names = data[names_header[4]:names_header[4]+names_header[5]]
    result = {}
    for header in headers:
        name = names[header[0]:names.find(b'\0', header[0])].decode()
        result[name] = (header[3], data[header[4]:header[4]+header[5]])
    return result

# Independently check every external address in the diagnostic linker script
# against the existing project symbol-address index, not a search result.
index = (ROOT / 'configs/symbol_addrs.txt').read_text()
addresses = {}
for name, value in re.findall(r'^([^\s#]+)\s*=\s*(0x[0-9a-fA-F]+);', index, re.M):
    addresses.setdefault(name, set()).add(int(value, 16))
bindings = re.findall(r'^(\w+)\s*=\s*(0x[0-9a-fA-F]+);',
                      (HERE / 'retail.ld').read_text(), re.M)
for name, value in bindings:
    if name != '_gp':
        assert int(value, 16) in addresses.get(name, set()), (name, value)

obj = ROOT / 'build' / (SOURCE + '.o')
out = ROOT / 'build/p879_audiotrk_production.elf'
command = ['C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-ld.exe',
           '-T', str(HERE / 'retail.ld'), '-o', str(out), str(obj)]
run = subprocess.run(command, cwd=ROOT, capture_output=True, text=True)
assert run.returncode == 0, (run.stdout, run.stderr)
rom = (ROOT / 'rom/nfs4-f.exe').read_bytes()
load = struct.unpack_from('<I', rom, 0x18)[0]
linked = sections(out)
raw = []
for name, count in [('.text', 4016), ('.rodata', 13), ('.sdata', 4)]:
    va, payload = linked[name]
    assert len(payload) >= count, (name, len(payload), count)
    offset = va - load + 0x800
    differences = [i for i, (a,b) in enumerate(zip(payload[:count], rom[offset:offset+count])) if a != b]
    assert not differences, (name, differences)
    raw.append(dict(section=name, va=hex(va), bytes=count, differences=0))
assert struct.unpack_from('<I', linked['.text'][1], 0x5a8)[0] == 0x0801f2fc
report = dict(production_source=SOURCE,
              source_sha256=hashlib.sha256((ROOT/SOURCE).read_bytes()).hexdigest(),
              object_sha256=hashlib.sha256(obj.read_bytes()).hexdigest(),
              checks=checks, linker_command=command, raw=raw,
              linked_instruction_words=1004, external_bindings_checked=len(bindings)-1,
              instruction_rewrites=False)
(HERE/'production_receipts.json').write_text(json.dumps(report, indent=2)+'\n')
print('PASS: production AudioTrk 6/6, branch0, exact-g; all1004 linked words and17 data bytes equal retail.')
