"""label_users.py -- which reconstructed sources still name an address that only a retail passthrough blob provides?
For every blob-only byte run (same logic as blob_runs.py) list the D_/DAT_/jtbl-style identifiers of recon sources whose
address falls inside it, with the files using them.  These are the cheapest ownership wins: the owner names itself."""
import re
import sys
from collections import defaultdict
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
LOAD = 0x80010000
rom = (ROOT / 'rom/nfs4-f.exe').read_bytes()
n = len(rom) - 0x800
lines = (ROOT / 'build/gen_ld/recon_multdef-ok.map').read_text(errors='replace').splitlines()
recon, blob = bytearray(n), bytearray(n)
one = re.compile(r'^ (\.\S+)\s+0x([0-9a-f]{8})\s+0x([0-9a-f]+)\s+(\S+\.o)$')
two = re.compile(r'^\s+0x([0-9a-f]{8})\s+0x([0-9a-f]+)\s+(\S+\.o)$')


def mark(a, sz, src):
    src = src.replace('\\', '/')
    t = recon if 'build/recon/' in src else blob if 'build/asm/' in src else None
    if t is None or not sz or not (LOAD <= a < LOAD + n):
        return
    for i in range(a - LOAD, min(a - LOAD + sz, n)):
        t[i] = 1


for i, ln in enumerate(lines):
    m = one.match(ln)
    if m:
        mark(int(m.group(2), 16), int(m.group(3), 16), m.group(4))
    elif re.match(r'^ \.\S+$', ln) and i + 1 < len(lines):
        m = two.match(lines[i + 1])
        if m:
            mark(int(m.group(1), 16), int(m.group(2), 16), m.group(3))

users = defaultdict(set)
ident = re.compile(r'\b(?:D|DAT|PTR|s|jtbl)_([0-9A-Fa-f]{8})\b')
for f in list((ROOT / 'recon').rglob('*.c')) + list((ROOT / 'recon').rglob('*.cpp')) + list((ROOT / 'recon').rglob('*.h')):
    txt = f.read_text(errors='replace')
    txt = re.sub(r'/\*.*?\*/', '', txt, flags=re.S)
    txt = re.sub(r'//[^\n]*', '', txt)
    for m in ident.finditer(txt):
        a = int(m.group(1), 16)
        if LOAD <= a < LOAD + n and blob[a - LOAD] and not recon[a - LOAD]:
            users[a].add(str(f.relative_to(ROOT / 'recon')).replace('\\', '/'))
for a in sorted(users):
    o = a - LOAD + 0x800
    raw = rom[o:o + 16]
    txt = ''.join(chr(c) if 32 <= c < 127 else '.' for c in raw)
    print('%#010x  %-16s %s' % (a, txt, ', '.join(sorted(users[a]))))
print(len(users), 'labels')
