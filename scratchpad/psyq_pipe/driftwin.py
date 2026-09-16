#!/usr/bin/env python3
"""driftwin.py -- for every drift change point in drift_full.txt: negative delta -> the retail
bytes we lack right before symbol B (with residual/SYM labels); positive delta -> the symbols
our SYM has between A and B that retail does not (or the size excess)."""
import re, sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from images import ROOT, W, rom, our_symbols, retail_data, retail_functions
R = rom(); LOAD = 0x80010000
ours = our_symbols(); rd = retail_data()
labels = {}
for p in ROOT.joinpath('asm/data').glob('*.s'):
    for m in re.finditer(r'^(?:[dag]label|glabel|jlabel)\s+(\S+)|^(\S+):', p.read_text(errors='replace'), re.M):
        n = m.group(1) or m.group(2)
        mm = re.search(r'_([0-9A-Fa-f]{8})$', n)
        if mm: labels.setdefault(int(mm.group(1), 16), []).append(n + '[' + p.name.split('_')[-1].split('.')[0] + ']')
bysym = {}
for n, a in rd.items(): bysym.setdefault(a, []).append(n)
inv = {}
for n, a in ours.items(): inv.setdefault(a, []).append(n)
sec = None
for l in (W / 'drift_full.txt').read_text().splitlines():
    if l.startswith('=='): sec = l.split()[1]; continue
    m = re.match(r'\s+drift ([+-]0x[0-9a-f]+) -> ([+-]0x[0-9a-f]+) \(([+-]0x[0-9a-f]+)\) between (\S+) and (\S+) @(0x[0-9a-f]+) \[(\S+)\]', l)
    if not m: continue
    d = int(m.group(3), 16); A, B, addr, obj = m.group(4), m.group(5), int(m.group(6), 16), m.group(7)
    print('== %s %s %+#x  %s -> %s @%#x' % (sec, obj, d, A, B, addr))
    if d < 0:
        lo = addr + d
        tags = []
        for k in range(0, -d, 4):
            for src in (labels, bysym):
                if lo + k in src: tags.append('%+#x:%s' % (k, ','.join(src[lo + k])))
        print('   lack %#x..%#x labels: %s' % (lo, addr, ' '.join(tags)[:400]))
        rows = list(range(0, -d, 16))
        for off in rows[:3] + (rows[-1:] if len(rows) > 3 else []):
            chunk = R[lo - LOAD + off: lo - LOAD + min(off + 16, -d)]
            words = ' '.join(chunk[i:i + 4][::-1].hex() for i in range(0, len(chunk), 4))
            print('   %s%#x  %s' % ('...' if off == rows[-1] and len(rows) > 3 else '   ', lo + off, words))
    else:
        oa, ob = ours.get(A), ours.get(B)
        if oa is not None and ob is not None:
            between = [(a, n) for a, ns in inv.items() for n in ns if oa < a < ob]
            print('   extra %+#x; our symbols between: %s' % (d, ', '.join('%s@%#x' % (n, a) for a, n in sorted(between)) or '(none: size excess of %s or a slotted object)' % A))
