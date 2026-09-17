"""spine_probe.py LO HI -- every recon object whose gen_ld implied .text base (mode of retail VA -
offset over its type:func symbols) lies in [LO, HI): base, size, end, object, top votes.
Use after a DROPPED (would move the location counter backwards) report line."""
import glob
import re
import subprocess
import sys
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OBJDUMP = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
lo, hi = int(sys.argv[1], 16), int(sys.argv[2], 16)
vas, dup = {}, set()
for ln in open(ROOT / 'configs' / 'symbol_addrs.txt', errors='replace'):
    m = re.match(r'(\S+?)\s*=\s*(0x[0-9A-Fa-f]+);\s*//\s*type:func', ln)
    if m:
        n, v = m.group(1), int(m.group(2), 16)
        if n in vas and vas[n] != v:
            dup.add(n)
        vas.setdefault(n, v)
for n in dup:
    del vas[n]
srcs = [*ROOT.glob('recon/**/*.cpp'), *ROOT.glob('recon/**/*.c')]
rows = []
for s in srcs:
    o = ROOT / 'build' / (s.relative_to(ROOT).as_posix() + '.o')
    if not o.is_file():
        continue
    out = subprocess.run([OBJDUMP, '-t', '-h', str(o)], capture_output=True, text=True).stdout
    c = Counter()
    tsz = 0
    for ln in out.splitlines():
        m = re.match(r'^\s*\d+\s+\.text\s+([0-9a-f]{8})', ln)
        if m:
            tsz = int(m.group(1), 16)
        m = re.match(r'^([0-9a-f]{8})\s(.{7})\s+\.text\s+[0-9a-f]{8}\s(\S+)$', ln)
        if m and m.group(3) in vas:
            c[vas[m.group(3)] - int(m.group(1), 16)] += 1
    if c:
        b = c.most_common(1)[0][0]
        if lo <= b < hi:
            rows.append((b, tsz, o.relative_to(ROOT).as_posix(), c.most_common(3)))
for b, tsz, o, top in sorted(rows):
    print(f'{b:#x} +{tsz:#x} -> {b + tsz:#x}  {o}  {[(hex(k), v) for k, v in top]}')
