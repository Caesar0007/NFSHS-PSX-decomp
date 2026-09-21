#!/usr/bin/env python3
"""drift.py -- per-section drift change points between our PSYLINK SYM (dumpsym text)
and the retail SYM: a change of (ours - retail) between two consecutive retail symbols
means the object in between has a different size (or is missing) in our link."""
import re, sys
from collections import defaultdict
from pathlib import Path
OURS = (Path(__file__).resolve().parents[2] / 'scratchpad/psyq_pipe/nfs4_sym.txt').as_posix()
RETAIL = __import__('retail_sym').txt()
RET = [('front.rdata', 0x80010000, 0x800128F0), ('front.text', 0x800128F0, 0x80051260),
       ('front.data', 0x80051260, 0x80052B38), ('front.bss', 0x80052B38, 0x80054548),
       ('.rdata', 0x80054548, 0x8005797C), ('.text', 0x8005797C, 0x8010CCD4), ('.data', 0x8010CCD4, 0x8013C54C),
       ('.sdata', 0x8013C54C, 0x8013DD7C), ('.sbss', 0x8013DD7C, 0x8013DEE0), ('.bss', 0x8013DEE0, 0x80148B04)]
LIMIT = int(sys.argv[1]) if len(sys.argv) > 1 else 14


def sec(a):
    for n, lo, hi in RET:
        if lo <= a < hi:
            return n
    return '?'


objs = []; cur = []; pend = None
for l in open(RETAIL, errors='replace'):
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
ours = {}
for l in open(OURS):
    m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) [126] (\S+)$', l)
    if m:
        ours.setdefault(m.group(2), int(m.group(1), 16))
from collections import Counter
import json, os
# a function is recorded twice per object (its Def class EXT/STAT record and its 8c block):
# dedupe within the object before counting cross-object duplicates
objs = [(on, sorted(set(syms))) for on, syms in objs]
dup = Counter(n for _, syms in objs for _, n in syms)   # header-inline copies live in several objects
# symbols the lane `equ`s to their retail address are not evidence of layout -- skip them
EQU = set(json.load(open(os.path.join(os.path.dirname(OURS), 'equ_symbols.json')))) if os.path.exists(os.path.join(os.path.dirname(OURS), 'equ_symbols.json')) else set()
per = defaultdict(set)
for on, syms in objs:
    syms = [(a, n) for a, n in syms if dup[n] == 1 and n not in EQU]
    short = re.sub(r'.*[\\/]', '', on)
    for a, n in syms:
        if n in ours:
            per[sec(a)].add((a, n, ours[n] - a, short))
for s in ['.text', '.data', '.sdata', '.sbss', '.bss', 'front.text', 'front.data', 'front.bss', '.rdata', 'front.rdata']:
    L = sorted(per[s])
    if not L:
        continue
    print('== %s: %d matched symbols; base delta %+#x' % (s, len(L), L[0][2]))
    prev = None; shown = 0; prevname = None
    for a, n, d, o in L:
        if prev is not None and d != prev:
            print('   drift %+#x -> %+#x (%+#x) between %s and %s @%#x [%s]' % (prev, d, d - prev, prevname, n, a, o))
            shown += 1
            if shown >= LIMIT:
                print('   ...'); break
        prev = d; prevname = n
