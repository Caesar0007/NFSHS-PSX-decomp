"""fndrift.py OBJ [BASE] -- per-function drift of a built recon object against retail symbol addresses.
OBJ = path under build/recon (e.g. frontend/common/femenudefs.cpp.o).  BASE defaults to the object's spine base in
linkers/nfs4_recon.ld (pass it explicitly when gen_ld dropped the object).  Prints each point where the delta
(built address - retail address) CHANGES, i.e. the first function after a size difference, plus unknown symbols."""
import re
import subprocess
import sys

ROOT = 'C:/Temp/nfs4-decomp/'
NM = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-nm.exe'
obj = 'build/recon/' + sys.argv[1]
if len(sys.argv) > 2:
    base = int(sys.argv[2], 16)
else:
    ld = open(ROOT + 'linkers/nfs4_recon.ld').read()
    base = int(re.search(r'(0x[0-9a-f]+) : SUBALIGN\(4\) \{ ' + re.escape(obj) + r'\(\.text\)', ld).group(1), 16)
sym = {}
for ln in open(ROOT + 'configs/symbol_addrs.txt', errors='replace'):
    m = re.match(r'(\S+?)\s*=\s*(0x[0-9A-Fa-f]+);', ln)
    if m:
        sym.setdefault(m.group(1), int(m.group(2), 16))
out = subprocess.run([NM, '-n', ROOT + obj], capture_output=True, text=True).stdout
prev = 'x'
last = ''
for ln in out.splitlines():
    p = ln.split()
    if len(p) != 3 or p[1] not in 'Tt' or p[2].startswith(('gcc2_', '__gnu_compiled')):
        continue
    off, name = int(p[0], 16), p[2]
    r = sym.get(name) or sym.get(name.replace('_._', '___')) or sym.get(name.replace('___', '_._'))
    d = (off + base - r) if r else None
    if d != prev:
        print('%#7x  %-60s retail %s  delta %s   <- after %s' % (off, name[:60], hex(r) if r else '?', d, last[:60]))
    prev = d
    last = name
