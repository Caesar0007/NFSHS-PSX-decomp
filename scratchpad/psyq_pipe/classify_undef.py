#!/usr/bin/env python3
"""classify_undef.py -- bucket PSYLINK's undefined symbols by where the GNU lane defines them."""
import re, subprocess, sys
from pathlib import Path
from collections import defaultdict, Counter
ROOT = Path('C:/Temp/nfs4-decomp'); sys.path.insert(0, str(ROOT / 'tools'))
import build
NM = str(build.MIPS / 'mipsel-none-elf-nm.exe')
W = ROOT / 'scratchpad' / 'psyq_pipe'
undef = sorted(set(re.findall(r"Symbol '([^']+)' not defined", (W / 'psylink.log').read_text())))
print(len(undef), 'distinct undefined symbols')
# where does the GNU lane define them?
objs = [*(ROOT / 'build' / 'recon').rglob('*.o'), *(ROOT / 'build' / 'asm').rglob('*.o')]
defs = defaultdict(list)
for i in range(0, len(objs), 200):
    chunk = objs[i:i + 200]
    r = subprocess.run([NM, '--defined-only', *map(str, chunk)], capture_output=True, text=True)
    cur = None
    for l in r.stdout.splitlines():
        if l.endswith(':'):
            cur = l[:-1]; continue
        m = re.match(r'^([0-9a-f]+) ([A-Za-z]) (\S+)$', l)
        if m and m.group(2) in 'TDBRCSAtdbrs':
            defs[m.group(3)].append((Path(cur).relative_to(ROOT / 'build').as_posix(), m.group(2)))
ld = (ROOT / 'linkers' / 'nfs4_recon.ld').read_text(errors='replace')
ldsyms = set(re.findall(r'^\s*(\w+)\s*=\s*0x[0-9A-Fa-f]+\s*;', ld, re.M)) | set(re.findall(r'PROVIDE\s*\(\s*(\w+)', ld))
cat = Counter(); ex = defaultdict(list)
for s in undef:
    alt = '_._' + s[3:] if s.startswith('___') else None
    d = defs.get(s) or (defs.get(alt) if alt else None)
    if d:
        src = d[0][0]
        if 'vtables_' in src:
            k = 'vtables_*.cpp'
        elif src.startswith('asm/data'):
            k = 'asm/data residual'
        elif src.startswith('asm/'):
            k = 'asm/ header (' + src.split('/')[1].split('.')[0] + ')'
        elif src.startswith('recon/'):
            k = 'recon TU (name mismatch?)'
        else:
            k = src
    elif s in ldsyms:
        k = 'linker-script absolute/PROVIDE'
    else:
        k = 'UNKNOWN'
    cat[k] += 1; ex[k].append(s + (' <- ' + d[0][0] if d else ''))
for k, n in cat.most_common():
    print('%5d  %s' % (n, k))
    for e in ex[k][:6]:
        print('         ', e)
