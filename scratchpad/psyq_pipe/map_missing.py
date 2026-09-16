#!/usr/bin/env python3
"""map_missing.py -- (a) recon TUs the retail-order LNK does not include -> which retail FILE
block their GNU-lane .text VA falls in; (b) retail objects with no recon TU -> the address
window between their neighbours' symbols (from the retail SYM)."""
import re, sys, json
from pathlib import Path
ROOT = Path('C:/Temp/nfs4-decomp')
RETAIL = Path('C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt')
objs = []; cur = []; pend = None
for l in RETAIL.read_text(errors='replace').splitlines():
    m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) 8c Function start', l)
    if m:
        pend = int(m.group(1), 16); continue
    m = re.match(r'\s+name = (\S+)$', l)
    if m and pend is not None:
        cur.append((pend, m.group(1))); pend = None; continue
    m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) 9[46] Def2? class (EXT|STAT) .* name (\S+)$', l)
    if m:
        cur.append((int(m.group(1), 16), m.group(3))); continue
    m = re.match(r'^[0-9a-f]+: \$[0-9a-f]{8} 94 Def class FILE type NULL size 0 name (\S+)', l)
    if m:
        objs.append((m.group(1), cur)); cur = []
# (a)
mp = (ROOT / 'build' / 'nfs4_recon.map').read_text(errors='replace')
tus = ['snddata.c', 'spchevnt.c', 'COUNTER_data.c', 'PAD_data.c', 'cdcont.c', 'cddebug.c', 'cdtables.c', 'drv.c', 'stcdint.c', 'operators.c']
for tu in tus:
    hits = re.findall(r'^ \.(text|data|sdata|bss|sbss|rdata|rodata)\S*\s+0x([0-9a-f]{16})\s+0x([0-9a-f]+)\s+\S*' + re.escape(tu) + r'\.o$', mp, re.M)
    hits = [(s, int(a, 16), int(n, 16)) for s, a, n in hits if int(n, 16)]
    print('==', tu, ' '.join('%s@%#x+%#x' % h for h in hits[:6]))
    for s, a, n in hits[:3]:
        # retail FILE block whose symbols bracket a
        for i, (on, syms) in enumerate(objs):
            addrs = [x for x, _ in syms if 0x80010000 <= x < 0x80150000]
            if addrs and min(addrs) <= a <= max(addrs):
                print('     %s -> %s (syms %#x..%#x)' % (s, on, min(addrs), max(addrs)))
# (b)
missing = ['libcd.lib(SYS.obj)', 'C_011.obj', 'sdasync.obj', 'unitvect.obj', 'window.obj', 'textsubs.obj', 'P26.obj', 'P20.obj',
           'libcd.lib(BIOS.obj)', 'hypot3d.obj', 'pageflip.obj', 'hypot.obj', 'vsync.obj', 'CHCLRPAD.obj', 'libapi.lib(PATCH.obj)',
           'A21.obj', 'A18.obj', 'A19.obj', 'A20.obj', 'libmcrd.lib(BIOS.obj)']
for i, (on, syms) in enumerate(objs):
    if any(w in on for w in missing):
        pv = objs[i - 1] if i else ('', []); nx = objs[i + 1] if i + 1 < len(objs) else ('', [])
        def rng(s):
            a = [x for x, _ in s if 0x80010000 <= x < 0x80150000]
            return ('%#x..%#x' % (min(a), max(a))) if a else '-'
        print('MISSING %-45s own=%d syms %s | prev %s %s | next %s %s' % (on.split('\\')[-1], len(syms), rng(syms), pv[0].split('\\')[-1], rng(pv[1]), nx[0].split('\\')[-1], rng(nx[1])))
        for a, n in syms[:6]:
            print('      %#x %s' % (a, n))
