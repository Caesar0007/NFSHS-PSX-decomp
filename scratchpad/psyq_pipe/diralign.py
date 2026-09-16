#!/usr/bin/env python3
"""diralign.py -- per source directory: how many recon objects' sections start 8-aligned in
the honest (= retail) layout, per section kind.  Reveals which object families carry 8-byte
section alignment (trailing pads) in the retail link."""
import re
from collections import defaultdict, Counter
from pathlib import Path
ROOT = Path('C:/Temp/nfs4-decomp')
rows = defaultdict(lambda: defaultdict(Counter))
for m in re.finditer(r'^ (\.\S+)\s+0x([0-9a-f]+)\s+0x([0-9a-f]+)\s+(\S+\.o)$', ROOT.joinpath('build/gen_ld/recon_multdef-ok.map').read_text(errors='replace'), re.M):
    va, sz, o = int(m.group(2), 16), int(m.group(3), 16), m.group(4)
    if not sz or not o.startswith('build/recon/'): continue
    sec = m.group(1).split('.')[1] if m.group(1).count('.') else m.group(1)
    if sec not in ('text', 'data', 'rodata', 'rdata', 'sdata', 'bss', 'sbss'): continue
    d = '/'.join(o.split('/')[2:4])
    rows[d][sec][va % 8] += 1
for d in sorted(rows):
    print('%-22s' % d, '  '.join('%s: %s' % (s, dict(c)) for s, c in sorted(rows[d].items())))
