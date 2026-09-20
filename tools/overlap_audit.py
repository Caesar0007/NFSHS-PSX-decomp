#!/usr/bin/env python3
"""overlap_audit.py -- integrity check for the honest link: output sections of build/gen_ld/recon_multdef-ok.elf that
OVERLAP in VA.  honest_measure.py flattens the ELF section by section, so at an overlapped address only the last-dumped
section is compared with retail -- a wrong byte in the other section is invisible.  For every overlap this prints both
owners and how many bytes of EACH side differ from retail there.  Exit status 1 when any overlapped byte of a RECON
section differs from retail (= a masked mismatch)."""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
ELF = ROOT / 'build' / 'gen_ld' / 'recon_multdef-ok.elf'
MAP = ROOT / 'build' / 'gen_ld' / 'recon_multdef-ok.map'
OBJDUMP = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
LOAD, FOFF = 0x80010000, 0x800
rom = (ROOT / 'rom' / 'nfs4-f.exe').read_bytes()[FOFF:]
secs = []      # (name, va, bytes)
cur = None
for ln in subprocess.run([OBJDUMP, '-s', str(ELF)], capture_output=True, text=True).stdout.splitlines():
    m = re.match(r'^Contents of section (\S+):', ln)
    if m:
        cur = [m.group(1), None, bytearray()]
        secs.append(cur)
        continue
    m = re.match(r'^ ([0-9a-f]{8}) ((?:[0-9a-f]{2,8} ?){1,4})', ln)
    if m and cur is not None:
        if cur[1] is None:
            cur[1] = int(m.group(1), 16)
        cur[2] += bytes.fromhex(m.group(2).replace(' ', ''))
secs = [(n, a, bytes(b)) for n, a, b in secs if a is not None and LOAD <= a < LOAD + len(rom)]
owner = {}
for m in re.finditer(r'^(\.\S+)\s+0x([0-9a-f]{8})\s+0x([0-9a-f]+)\n(?:.*\n)*? \.\S+\s+0x[0-9a-f]{8}\s+0x[0-9a-f]+\s+(\S+\.o)$', MAP.read_text(errors='replace'), re.M):
    owner.setdefault(m.group(1), m.group(4).replace('\\', '/').split('build/')[-1])
ev = sorted(secs, key=lambda s: s[1])
bad = tot = 0
for i, (n1, a1, b1) in enumerate(ev):
    for n2, a2, b2 in ev[i + 1:]:
        if a2 >= a1 + len(b1):
            break
        lo, hi = a2, min(a1 + len(b1), a2 + len(b2))
        r = rom[lo - LOAD:hi - LOAD]
        d1 = sum(1 for k in range(hi - lo) if b1[lo - a1 + k] != r[k])
        d2 = sum(1 for k in range(hi - lo) if b2[lo - a2 + k] != r[k])
        tot += hi - lo
        flag = ''
        for nm, d in ((n1, d1), (n2, d2)):
            if d and 'recon/' in owner.get(nm, ''):
                flag = '   <== MASKED RECON MISMATCH'
                bad += d
        if d1 or d2:
            print('%08x..%08x  %-10s %-46s differs %4d | %-10s %-46s differs %4d%s' % (
                lo, hi, n1, owner.get(n1, '?')[-46:], d1, n2, owner.get(n2, '?')[-46:], d2, flag))
print('overlapped bytes: %d; masked RECON mismatch bytes: %d' % (tot, bad))
sys.exit(1 if bad else 0)
