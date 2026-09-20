"""bss_holes.py -- the retail .sbss/.bss address ranges NO reconstructed section is placed on (from the honest link map),
each with the retail labels inside it and the link-order bracket of its placed neighbours."""
import re

R = 'C:/Temp/nfs4-decomp/'
SYM = __import__('retail_sym').txt()
LO, HI = 0x8013DD7C, 0x80148B04
order, labels = [], []
for l in open(SYM, errors='replace'):
    m = re.search(r'Def class FILE type NULL size 0 name (\S+)', l)
    if m:
        if m.group(1) not in order:
            order.append(m.group(1))
        continue
    m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) ([26]) (\S+)$', l)
    if m and LO <= int(m.group(1), 16) < HI:
        labels.append((int(m.group(1), 16), m.group(3)))
labels = sorted(set(labels))


def key(n):
    m = re.search(r'\(([^)]+)\)', n)
    lib = re.search(r'([a-z0-9]+)\.lib\(', n.lower())
    return ((lib.group(1) + '/') if lib else '') + (m.group(1) if m else n.split(chr(92))[-1]).lower().replace('.obj', '')


idx = {}
for i, n in enumerate(order):
    idx.setdefault(key(n), i)
    idx.setdefault(key(n).split('/')[-1], i)


def oidx(o):
    parts = o.lower().split('/')
    b = re.sub(r'(_data)?\.(c|cpp)\.o$', '', parts[-1])
    return idx.get(parts[-2] + '/' + b, idx.get(b))


lines = open(R + 'build/gen_ld/recon_multdef-ok.map', errors='replace').read().splitlines()
one = re.compile(r'^ (\.\S+)\s+0x([0-9a-f]{8})\s+0x([0-9a-f]+)\s+(\S+\.o)$')
two = re.compile(r'^\s+0x([0-9a-f]{8})\s+0x([0-9a-f]+)\s+(\S+\.o)$')
spans = []
out = None
for i, ln in enumerate(lines):
    m = re.match(r'^(\.\S+)', ln)
    if m:
        out = m.group(1)
    m = one.match(ln)
    r = None
    if m:
        r = (int(m.group(2), 16), int(m.group(3), 16), m.group(4))
    elif re.match(r'^ \.\S+$', ln) and i + 1 < len(lines):
        m = two.match(lines[i + 1])
        if m:
            r = (int(m.group(1), 16), int(m.group(2), 16), m.group(3))
    if r and r[1] and 'build/recon/' in r[2].replace(chr(92), '/') and LO <= r[0] < HI and out not in ('.sbss', '.bss', '.data_rest', '.rodata_rest'):
        spans.append((r[0], r[0] + r[1], r[2].replace(chr(92), '/').split('build/recon/')[1]))
spans.sort()
cur = LO
tot = 0
for k, (a, b, o) in enumerate(spans + [(HI, HI, '')]):
    if a > cur:
        prev = [s for s in spans if s[1] <= cur][-1:] or [(0, 0, '-')]
        inside = [n for x, n in labels if cur <= x < a]
        print('%08x..%08x %6d  after %s [%s]  before %s [%s]  labels: %s' % (cur, a, a - cur, prev[0][2].split('/')[-1], oidx(prev[0][2]) if prev[0][2] != '-' else '',
                                                                     o.split('/')[-1], oidx(o) if o else '', ' '.join(inside)[:70]))
        tot += a - cur
    cur = max(cur, b)
print('unplaced bytes', tot)
