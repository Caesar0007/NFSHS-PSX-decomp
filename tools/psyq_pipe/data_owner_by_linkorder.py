"""data_owner_by_linkorder.py [section] -- PSYLINK lays each data section out per object in LINK ORDER (SYM FILE records).
For every retail data label of the section (address order): the recon object that defines it and that object's index in the
retail link order.  A label nobody defines is bracketed by its neighbours' indices, which names the candidate owner modules
(printed with a `*` when no recon TU carries the module's name -- the data-only module suspects)."""
import glob
import re
import subprocess
import sys

R = 'C:/Temp/nfs4-decomp/'
SYM = __import__('retail_sym').txt()
NM = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-nm.exe'
SECS = {'.data': (0x8010CCD4, 0x8013C54C), '.sdata': (0x8013C54C, 0x8013DD7C), '.sbss': (0x8013DD7C, 0x8013DEE0),
        '.bss': (0x8013DEE0, 0x80148B04), 'front.data': (0x80051260, 0x80052B38)}
sec = sys.argv[1] if len(sys.argv) > 1 else '.sdata'
lo, hi = SECS[sec]
order, labels = [], []
for l in open(SYM, errors='replace'):
    m = re.search(r'Def class FILE type NULL size 0 name (\S+)', l)
    if m:
        n = m.group(1)
        if not order or order[-1] != n:
            if n not in order:
                order.append(n)
        continue
    m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) ([26]) (\S+)$', l)
    if m and lo <= int(m.group(1), 16) < hi:
        labels.append((int(m.group(1), 16), m.group(3)))


def key(n):
    m = re.search(r'\(([^)]+)\)', n)
    return (m.group(1) if m else n.split(chr(92))[-1]).lower().replace('.obj', '')


idx = {}
for i, n in enumerate(order):
    idx.setdefault(key(n), i)
definer = {}
files = sorted(glob.glob(R + 'build/recon/**/*.o', recursive=True))
names = set()
for i in range(0, len(files), 60):
    batch = [f.replace(chr(92), '/').replace(R, '') for f in files[i:i + 60]]
    out = subprocess.run([NM, '-A'] + batch, capture_output=True, text=True, cwd=R).stdout
    for ln in out.splitlines():
        p = ln.split()
        if len(p) == 3 and p[1] in 'DdBbGgSsCc':
            definer.setdefault(p[2], p[0].split(':')[0])
for f in files:
    names.add(re.sub(r'(_data)?\.(c|cpp)\.o$', '', f.replace(chr(92), '/').split('/')[-1]).lower())
rows = []
for a, n in sorted(set(labels)):
    o = definer.get(n)
    k = re.sub(r'(_data)?\.(c|cpp)\.o$', '', o.split('/')[-1]).lower() if o else None
    rows.append((a, n, o, idx.get(k) if k else None))
last = None
for j, (a, n, o, i) in enumerate(rows):
    if o is not None:
        last = i
        continue
    nxt = next((r[3] for r in rows[j + 1:] if r[2] is not None and r[3] is not None), None)
    cands = [order[t] for t in range((last or 0), (nxt if nxt is not None else len(order) - 1) + 1)] if last is not None else []
    cands = [('*' if key(c) not in names else '') + key(c) for c in cands]
    star = [c for c in cands if c.startswith('*')]
    print('%08x %-28s UNOWNED  between link idx %s..%s  no-TU candidates: %s' % (a, n, last, nxt, ' '.join(star)[:120] or '(none) all: ' + ' '.join(cands)[:100]))
print('labels %d, unowned %d' % (len(rows), sum(1 for r in rows if r[2] is None)))
