#!/usr/bin/env python3
"""padcensus.py -- in the honest (= retail) layout, which objects are preceded by a 4-byte
alignment pad in .text (pad_before = VA - previous object's end)?  Tabulated by source family
and by TU class (file-scope __asm__ block TU vs compiled C/C++), to find the rule behind the
8-byte section alignment some retail objects carry."""
import re
from collections import Counter, defaultdict
from pathlib import Path
ROOT = Path('C:/Temp/nfs4-decomp')
rows = []
for m in re.finditer(r'^ (\.\S+)\s+0x([0-9a-f]+)\s+0x([0-9a-f]+)\s+(\S+\.o)$', ROOT.joinpath('build/gen_ld/recon_multdef-ok.map').read_text(errors='replace'), re.M):
    va, sz, o = int(m.group(2), 16), int(m.group(3), 16), m.group(4)
    if sz and m.group(1) == '.text':
        rows.append((va, sz, o))
rows.sort()
def tuclass(o):
    m = re.match(r'build/(recon/.*)\.o$', o)
    if not m: return 'asm-residual' if o.startswith('build/asm') else 'other'
    p = ROOT / m.group(1)
    if not p.exists(): return '?'
    t = p.read_bytes().decode('utf-8', 'replace')
    has_asm = bool(re.search(r'__asm__\s*\(\s*\n?\s*"', t))
    fam = '/'.join(m.group(1).split('/')[1:3])
    return fam + (' [asm-block]' if has_asm else ' [C]')
stat = defaultdict(Counter); examples = defaultdict(list)
for i in range(1, len(rows)):
    va, sz, o = rows[i]; pva, psz, po = rows[i - 1]
    if not o.startswith('build/recon/'): continue
    pad = va - (pva + psz)
    if pad not in (0, 4): continue
    k = tuclass(o); stat[k][('start%8=' + str(va % 8), 'pad=' + str(pad))] += 1
    if pad == 4 and len(examples[k]) < 6: examples[k].append((o.split('/')[-1], hex(va), 'after', po.split('/')[-1]))
for k in sorted(stat):
    print('%-32s %s' % (k, dict(stat[k])))
    for e in examples[k]: print('      pad4:', e)
