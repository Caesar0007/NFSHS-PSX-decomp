"""sdkfn.py LIB MEMBER FUNCTION [NEXT] -- disassemble one function of a PsyQ 4.3 object with its relocations annotated
(objtruth.py parses the SN object; objdump disassembles the raw words)."""
import re
import subprocess
import sys
from pathlib import Path

R = Path('C:/Temp/nfs4-decomp')
lib, mem, fn = sys.argv[1:4]
obj = 'C:/Temp/nfs4-clean/psyq43/extracted/%s/obj/%s.obj' % (lib, mem)
cmd = [sys.executable, str(R / 'tools' / 'objtruth.py'), 'dump', obj, fn]
if len(sys.argv) > 4:
    cmd += ['--end', sys.argv[4]]
rows = []
for ln in subprocess.run(cmd, capture_output=True, text=True).stdout.splitlines():
    m = re.match(r'\s+\+([0-9A-F]+) ([0-9A-F]{8})(?:\s+\|\s+(.*))?', ln)
    if m:
        rows.append((int(m.group(1), 16), int(m.group(2), 16), m.group(3) or ''))
tmp = R / 'build' / 'tmp' / 'sdkfn.bin'
tmp.write_bytes(b''.join(w.to_bytes(4, 'little') for _, w, _ in rows))
out = subprocess.run(['C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe', '-D', '-b', 'binary', '-m', 'mips:3000', '-EL',
                      '-M', 'no-aliases', str(tmp)], capture_output=True, text=True).stdout
dis = {}
for ln in out.splitlines():
    m = re.match(r'\s*([0-9a-f]+):\s+[0-9a-f]{8}\s+(.*)', ln)
    if m:
        dis[int(m.group(1), 16)] = m.group(2).replace('\t', ' ')
for off, w, rel in rows:
    print('%04x  %-34s %s' % (off, dis.get(off, '?'), re.sub(r'^t[0-9A-F]+ ', '', rel)))
