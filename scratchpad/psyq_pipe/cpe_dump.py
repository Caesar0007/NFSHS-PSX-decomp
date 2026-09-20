"""cpe_dump.py FILE.cpe -- chunk summary of an SN CPE file (1 = load addr/len/data, 3 = set register, 8 = select unit...)."""
import struct
import sys
from collections import Counter

d = open(sys.argv[1], 'rb').read()
assert d[:4] == b'CPE\x01', d[:4]
p = 4
c = Counter()
lo, hi, tot = 1 << 32, 0, 0
regs = []
first = []
while p < len(d):
    t = d[p]; p += 1
    c[t] += 1
    if t == 0:
        break
    if t == 1:
        a, n = struct.unpack_from('<II', d, p); p += 8 + n
        lo, hi, tot = min(lo, a), max(hi, a + n), tot + n
        if len(first) < 3:
            first.append((hex(a), n))
    elif t == 2:
        p += 4
    elif t == 3:
        r, = struct.unpack_from('<H', d, p); v, = struct.unpack_from('<I', d, p + 2); p += 6
        regs.append((r, hex(v)))
    elif t == 4:
        p += 2 + 2
    elif t == 5:
        p += 2 + 1
    elif t == 6:
        p += 4 + 4
    elif t == 7:
        p += 4
    elif t == 8:
        p += 1
    else:
        print('unknown chunk', t, 'at', p - 1); break
print('chunks', dict(c), 'load range %08x..%08x' % (lo, hi), 'bytes', tot, 'regs', regs, 'first loads', first, 'parsed', p, 'of', len(d))
