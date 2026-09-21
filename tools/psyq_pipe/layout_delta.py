"""layout_delta.py [--all] -- WHY the native SN link (Route B) is not byte-identical: where, section by section, our PSYLINK
layout gains or loses bytes against retail.

Uses EVERY retail label (SYM kinds 2 and 6, libraries included -- drift.py only sees symbols with debug records) that has
a uniquely named counterpart in our PSYLINK SYM.  For each section: size ours / retail, then the running difference
(our offset in the section - retail's offset) at the first label, at every point where it CHANGES, and at the section end.
Each change is attributed through the honest GNU link map, which knows what sits at those retail addresses: the recon
objects in the window and the bytes there that NO reconstructed object provides (retail blob / filler)."""
import bisect
import json
import re
import sys
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
RETAIL = __import__('retail_sym').txt()
OURS = ROOT / 'scratchpad' / 'psyq_pipe' / 'nfs4_sym.txt'
OURMAP = ROOT / 'build' / 'psyq' / 'nfs4.map'
RETMAP = ROOT / 'rom' / 'NFS4.MAP'
HONEST = ROOT / 'build' / 'gen_ld' / 'recon_multdef-ok.map'
EQU = set(json.load(open(ROOT / 'scratchpad' / 'psyq_pipe' / 'equ_symbols.json'))) if (ROOT / 'scratchpad/psyq_pipe/equ_symbols.json').exists() else set()


def sections(path):
    out = {}
    for l in open(path, errors='replace'):
        m = re.match(r'^ ([0-9A-F]{8}) ([0-9A-F]{8}) ([0-9A-F]{8}) [0-9A-F]{8} (\w+)\s+(\S+)\s*$', l)
        if m:
            out[m.group(5)] = (int(m.group(1), 16), int(m.group(3), 16))
    return out


def labels(path, kinds):
    d = {}
    for l in open(path, errors='replace'):
        m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) ([%s]) (\S+)$' % kinds, l)
        if m:
            d.setdefault(m.group(3), []).append(int(m.group(1), 16))
    return d


# honest map: what is at a retail address
one = re.compile(r'^ (\.\S+)\s+0x([0-9a-f]{8})\s+0x([0-9a-f]+)\s+(\S+\.o)$')
two = re.compile(r'^\s+0x([0-9a-f]{8})\s+0x([0-9a-f]+)\s+(\S+\.o)$')
spans = []
hl = open(HONEST, errors='replace').read().splitlines()
for i, ln in enumerate(hl):
    m = one.match(ln)
    r = (int(m.group(2), 16), int(m.group(3), 16), m.group(4)) if m else None
    if r is None and re.match(r'^ \.\S+$', ln) and i + 1 < len(hl):
        m = two.match(hl[i + 1])
        r = (int(m.group(1), 16), int(m.group(2), 16), m.group(3)) if m else None
    if r and r[1] and 0x80010000 <= r[0] < 0x80150000:
        spans.append((r[0], r[0] + r[1], r[2].replace(chr(92), '/')))


def window(lo, hi):
    objs, covered = [], []
    for a, b, o in spans:
        if a < hi and lo < b and 'frontend/psx/bigbuf' not in o:
            short = o.split('build/')[-1]
            if 'build/recon/' in o:
                objs.append(re.sub(r'^recon/', '', short).replace('.o', ''))
                covered.append((max(a, lo), min(b, hi)))
    covered.sort()
    hole, cur = 0, lo
    for a, b in covered:
        if a > cur:
            hole += a - cur
        cur = max(cur, b)
    hole += max(0, hi - cur)
    seen, uniq = set(), []
    for o in objs:
        if o not in seen:
            seen.add(o); uniq.append(o.split('/')[-1])
    return uniq, hole


rs, os_ = sections(RETMAP), sections(OURMAP)
rl, ol = labels(RETAIL, '26'), labels(OURS, '126')
print('%-12s %10s %10s %8s' % ('section', 'ours', 'retail', 'diff'))
for s in ('.rdata', '.text', '.data', '.sdata', '.sbss', '.bss', 'front.rdata', 'front.text', 'front.data', 'front.bss'):
    print('%-12s %#10x %#10x %+8d' % (s, os_[s][1], rs[s][1], os_[s][1] - rs[s][1]))
print()
total = Counter()
for s in ('.rdata', '.text', '.data', '.sdata', '.sbss', '.bss', 'front.rdata', 'front.text', 'front.data', 'front.bss'):
    rstart, rsize = rs[s]
    ostart, osize = os_[s]
    rows = []
    for n, ra in rl.items():
        if len(ra) == 1 and n in ol and len(ol[n]) == 1 and n not in EQU and rstart <= ra[0] < rstart + rsize and ostart <= ol[n][0] < ostart + osize:
            rows.append((ra[0], n, (ol[n][0] - ostart) - (ra[0] - rstart)))
    rows.sort()
    print('== %s: %d labels matched; section size diff %+d' % (s, len(rows), osize - rsize))
    if not rows:
        continue
    prev_a, prev_n, prev_d = rstart, '<section start>', 0
    for a, n, d in rows + [(rstart + rsize, '<section end>', osize - rsize)]:
        if d != prev_d:
            objs, hole = window(prev_a, a)
            print('   %+5d  between %-26s @%08x and %-26s @%08x | unprovided bytes there: %d | %s' % (
                d - prev_d, prev_n[:26], prev_a, n[:26], a, hole, ' '.join(objs)[:120]))
            total[s] += d - prev_d
        prev_a, prev_n, prev_d = a, n, d
