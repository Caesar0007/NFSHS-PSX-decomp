#!/usr/bin/env python3
"""vtref.py -- derive every *_vtable's RETAIL address from code references: for each placed recon
object, pair R_MIPS_HI16/LO16 relocs against *_vtable symbols with the ROM words at the same VA."""
import sys, re, struct, subprocess, collections
sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/psyq_pipe')
from images import rom, LOAD, ROOT, OBJDUMP
R = rom()
mp = (ROOT / 'build/gen_ld/recon_multdef-ok.map').read_text(errors='replace')
placed = {m.group(3): int(m.group(1), 16) for m in re.finditer(r'^ \.text\s+(0x[0-9a-f]+)\s+(0x[0-9a-f]+) (build/recon/\S+\.o)$', mp, re.M)}
nm = {}
for l in subprocess.run(['C:/tools/mips-ps1/mips/bin/mipsel-none-elf-nm', str(ROOT / 'build/gen_ld/recon_multdef-ok.elf')], capture_output=True, text=True).stdout.splitlines():
    p = l.split()
    if len(p) == 3 and p[2].endswith('_vtable'): nm.setdefault(p[2], int(p[0], 16))
found = collections.defaultdict(set); users = collections.defaultdict(set)
for obj, base in placed.items():
    out = subprocess.run([OBJDUMP, '-dr', str(ROOT / obj)], capture_output=True, text=True).stdout
    hi = {}
    for m in re.finditer(r'^\s+([0-9a-f]+): R_MIPS_(HI16|LO16)\s+(\S+_vtable)(?:\+0x([0-9a-f]+))?$', out, re.M):
        off, kind, sym, add = int(m.group(1), 16), m.group(2), m.group(3), int(m.group(4) or '0', 16)
        w = struct.unpack_from('<I', R, base + off - LOAD)[0]
        if kind == 'HI16': hi[sym] = (w & 0xffff) << 16
        else:
            if sym not in hi: continue
            lo = w & 0xffff; lo = lo - 0x10000 if lo & 0x8000 else lo
            found[sym].add(hi[sym] + lo - add); users[sym].add(obj.split('/')[-1])
bad = 0
for sym in sorted(found, key=lambda s: min(found[s])):
    r = sorted(found[sym]); o = nm.get(sym)
    flag = '' if (o in r) else ' <-- ours %s' % (f'{o:08x}' if o else 'undef')
    if flag: bad += 1
    print(f'{sym:42s} retail {",".join(f"{x:08x}" for x in r):20s}{flag}   [{",".join(sorted(users[sym]))[:60]}]')
print('vtables referenced', len(found), 'misplaced', bad)
