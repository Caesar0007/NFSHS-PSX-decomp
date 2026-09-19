"""blob_trace_report.py -- summarise status/runtime/blob_trace.json: for each touched blob address range,
which reconstructed object / retail function loaded or stored it (runtime ownership evidence)."""
import bisect
import json
import re
from collections import Counter, defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
hits = json.load(open(ROOT / 'status/runtime/blob_trace.json'))
fn = []
for ln in open(ROOT / 'configs/symbol_addrs.txt', errors='replace'):
    m = re.match(r'(\S+?)\s*=\s*(0x[0-9A-Fa-f]+);\s*//\s*type:func', ln)
    if m:
        fn.append((int(m.group(2), 16), m.group(1)))
fn.sort()
fk = [v for v, _ in fn]
spine = sorted((int(m.group(1), 16), m.group(2)) for m in re.finditer(
    r'(0x[0-9a-f]+) : SUBALIGN\(4\) \{ build/recon/(\S+?)\(\.text\)', (ROOT / 'linkers/nfs4_recon.ld').read_text(errors='replace')))
sk = [v for v, _ in spine]


def where(pc):
    i = bisect.bisect_right(fk, pc) - 1
    j = bisect.bisect_right(sk, pc) - 1
    return (spine[j][1] if j >= 0 else '?'), (fn[i][1] if i >= 0 else '?')


by = defaultdict(Counter)
for h in hits:
    o, f = where(h['pc'])
    co, cf = where(h['ra'])
    by[h['addr'] & ~0xf][(h['kind'], o, f, cf)] += 1
print(len(hits), 'hits')
for a in sorted(by):
    for (k, o, f, cf), c in by[a].most_common(3):
        print(f'{a:#010x}  {c:4d} {k:5s} {o:42s} {f}   (caller {cf})')
