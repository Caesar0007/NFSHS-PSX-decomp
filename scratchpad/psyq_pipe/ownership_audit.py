"""ownership_audit.py -- recount the honest image by TRUE owner with explicit priority:
a word is RECON if any build/recon section covers it, else BLOB if any build/asm piece covers it, else OTHER.
honest_measure.py attributes a word to the latest-STARTING map interval only, so words that lie inside a big
blob piece but behind the end of a recon section placed inside that blob fall to OTHER."""
import re
import subprocess
from collections import Counter
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
OBJDUMP = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
LOAD, FOFF = 0x80010000, 0x800
rom = (ROOT / 'rom/nfs4-f.exe').read_bytes()[FOFF:]
n = len(rom)
recon = bytearray(n)
blob = bytearray(n)
for ln in (ROOT / 'build/gen_ld/recon_multdef-ok.map').read_text(errors='replace').splitlines():
    m = re.match(r'^ \.\S+\s+0x([0-9a-f]{8})\s+0x([0-9a-f]+)\s+(\S+\.o)$', ln)
    if not m:
        continue
    a, sz, src = int(m.group(1), 16), int(m.group(2), 16), m.group(3).replace('\\', '/')
    if not sz or a < LOAD or a >= LOAD + n:
        continue
    tgt = recon if 'build/recon/' in src else blob if 'build/asm/' in src else None
    if tgt is not None:
        for i in range(a - LOAD, min(a - LOAD + sz, n)):
            tgt[i] = 1
img = bytearray(n)
cov = bytearray(n)
for ln in subprocess.run([OBJDUMP, '-s', str(ROOT / 'build/gen_ld/recon_multdef-ok.elf')], capture_output=True, text=True).stdout.splitlines():
    m = re.match(r'^ ([0-9a-f]{8}) ((?:[0-9a-f]{2,8} ?){1,4})', ln)
    if not m:
        continue
    va = int(m.group(1), 16)
    d = bytes.fromhex(m.group(2).replace(' ', ''))
    if va < LOAD or va + len(d) > LOAD + n:
        continue
    img[va - LOAD:va - LOAD + len(d)] = d
    for i in range(len(d)):
        cov[va - LOAD + i] = 1
tot, same = Counter(), Counter()
for off in range(0, n - 3, 4):
    if not all(cov[off:off + 4]):
        tot['UNCOVERED'] += 1
        continue
    k = 'RECON' if all(recon[off:off + 4]) else 'BLOB' if any(blob[off:off + 4]) or any(recon[off:off + 4]) and not all(recon[off:off + 4]) else 'OTHER'
    tot[k] += 1
    same[k] += img[off:off + 4] == rom[off:off + 4]
for k in ('RECON', 'BLOB', 'OTHER', 'UNCOVERED'):
    print(f'{k:10s} {tot[k]:7d} words' + (f'   identical {same[k]}' if k != 'UNCOVERED' else ''))
print('total', sum(tot.values()))
