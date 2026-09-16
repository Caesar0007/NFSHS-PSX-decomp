#!/usr/bin/env python3
"""padpairs.py -- every consecutive (.text) object pair in the honest layout where the
previous object's size is not a multiple of 8: was a 4-byte pad inserted before the next
object?  Grouped by (prev family/class -> next family/class)."""
import re
from collections import Counter, defaultdict
from pathlib import Path
ROOT = Path('C:/Temp/nfs4-decomp')
rows = []
for m in re.finditer(r'^ (\.\S+)\s+0x([0-9a-f]+)\s+0x([0-9a-f]+)\s+(\S+\.o)$', ROOT.joinpath('build/gen_ld/recon_multdef-ok.map').read_text(errors='replace'), re.M):
    va, sz, o = int(m.group(2), 16), int(m.group(3), 16), m.group(4)
    if sz and m.group(1) == '.text' and 0x8005797C <= va < 0x8010CCD4:
        rows.append((va, sz, o))
rows.sort()
cache = {}
def cls(o):
    if o in cache: return cache[o]
    m = re.match(r'build/(recon/.*)\.o$', o)
    if not m: r = 'asm-residual' if o.startswith('build/asm') else 'other'
    else:
        p = ROOT / m.group(1); t = p.read_bytes().decode('utf-8', 'replace') if p.exists() else ''
        fam = m.group(1).split('/')[1] + ('/' + m.group(1).split('/')[3] if m.group(1).startswith('recon/syslib') else '')
        kind = 'thunk' if ('BIOS_THUNK(' in t and t.count('__asm__') <= 2 and len(t) < 6000) else ('asm' if re.search(r'__asm__\s*\(\s*\n?\s*"', t) else 'C')
        r = fam + ':' + kind
    cache[o] = r; return r
stat = defaultdict(Counter); ex = defaultdict(list)
for i in range(1, len(rows)):
    pva, psz, po = rows[i - 1]; va, sz, o = rows[i]
    if psz % 8 == 0: continue
    pad = va - (pva + psz)
    if pad not in (0, 4): continue
    k = (cls(po), cls(o)); stat[k]['pad' if pad else 'nopad'] += 1
    if len(ex[k]) < 3: ex[k].append((po.split('/')[-1], hex(pva + psz), o.split('/')[-1], 'pad' if pad else 'nopad'))
for k in sorted(stat):
    print('%-28s -> %-28s %s  %s' % (k[0], k[1], dict(stat[k]), ex[k][:2]))
