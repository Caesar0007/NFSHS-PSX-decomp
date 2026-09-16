#!/usr/bin/env python3
"""ldcheck.py [data|sdata] -- walk the honest .data / .sdata ld fragment in order, accumulate the
real input-section sizes (objdump -h) from the retail section start and print the running
address next to every line, flagging lines whose window comment disagrees.  Finds the object
whose size no longer matches its retail window after a data-owner change."""
import re, sys, subprocess
from pathlib import Path
ROOT = Path('C:/Temp/nfs4-decomp'); sys.path.insert(0, str(ROOT / 'tools')); import build
OBJDUMP = str(build.MIPS / 'mipsel-none-elf-objdump.exe')
which = sys.argv[1] if len(sys.argv) > 1 else 'sdata'
frag = ROOT / 'linkers' / ('nfs4_recon.sdata_8013C54C.ldfrag' if which == 'sdata' else 'nfs4_recon.data_8010CCD4.ldfrag')
start = 0x8013C54C if which == 'sdata' else 0x8010CD5C
cache = {}
def secsize(obj, sec):
    if obj not in cache:
        r = subprocess.run([OBJDUMP, '-h', str(ROOT / obj)], capture_output=True, text=True)
        d = {}
        for l in r.stdout.splitlines():
            m = re.match(r'\s*\d+\s+(\S+)\s+([0-9a-f]{8})', l)
            if m: d[m.group(1)] = int(m.group(2), 16)
        cache[obj] = d
    return cache[obj].get(sec)
addr = start; bad = 0
for l in frag.read_text().splitlines():
    m = re.match(r'\s*(\S+\.o)\((\S+?)\);(.*)$', l)
    if not m: continue
    obj, sec, rest = m.groups()
    sz = secsize(obj, sec)
    if sz is None:
        print('%#x  MISSING section %s in %s' % (addr, sec, obj)); bad += 1; continue
    w = re.search(r'(0x[0-9a-f]{8})\.\.(0x[0-9a-f]{8})', rest)
    w2 = re.search(r'now from (0x[0-9a-f]{8})', rest)
    flag = ''
    if w:
        lo, hi = int(w.group(1), 16), int(w.group(2), 16)
        if lo != addr or hi != addr + sz:
            flag = '  <-- comment says %s..%s (size %#x), actual %#x..%#x' % (w.group(1), w.group(2), hi - lo, addr, addr + sz); bad += 1
    elif w2 and int(w2.group(1), 16) != addr:
        flag = '  <-- comment says from %s' % w2.group(1); bad += 1
    print('%#x +%-6s %s(%s)%s' % (addr, hex(sz), obj.split('/')[-1], sec, flag))
    addr += sz
    if sz % 4:                  # ld's SUBALIGN(4) between input sections
        addr += 4 - sz % 4
print('end %#x  (retail %s)  flagged %d' % (addr, '0x8013DD7C' if which == 'sdata' else '0x8013C54C', bad))
