"""linkorder_outliers.py [section...] -- PSYLINK lays a section out per object in LINK ORDER, so along the addresses of a
section the owners' link indices never decrease.  For every retail data label: the recon object that defines it and that
object's retail link index; the labels NOT on the longest non-decreasing run are owned by the wrong recon file (or belong
to a module whose recon file is named differently).  Function-statics (`name.NN`) are skipped."""
import bisect
import glob
import os
import re
import subprocess
import sys
from pathlib import Path

R = Path(__file__).resolve().parents[2].as_posix() + '/'
SYM = __import__('retail_sym').txt()
NM = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-nm.exe'
SECS = {'.data': (0x8010CCD4, 0x8013C54C), '.sdata': (0x8013C54C, 0x8013DD7C), '.sbss': (0x8013DD7C, 0x8013DEE0),
        '.bss': (0x8013DEE0, 0x80148B04), 'front.data': (0x80051260, 0x80052B38), 'front.bss': (0x80052B38, 0x80054548)}
order, labels = [], []
for l in open(SYM, errors='replace'):
    m = re.search(r'Def class FILE type NULL size 0 name (\S+)', l)
    if m:
        if m.group(1) not in order:
            order.append(m.group(1))
        continue
    m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) ([26]) (\S+)$', l)
    if m:
        labels.append((int(m.group(1), 16), m.group(3)))


def key(n):
    m = re.search(r'\(([^)]+)\)', n)
    lib = re.search(r'([a-z0-9]+)\.lib\(', n.lower())
    return ((lib.group(1) + '/') if lib else '') + (m.group(1) if m else n.split(chr(92))[-1]).lower().replace('.obj', '')


idx = {}
for i, n in enumerate(order):
    idx.setdefault(key(n), i)
    idx.setdefault(key(n).split('/')[-1], i)
definer, alld = {}, {}
files = sorted(glob.glob(R + 'build/recon/**/*.o', recursive=True))
# a build object whose recon source is gone is STALE (e.g. the old lumped libpad PAD.c.o) -- it must not shadow the real owner
files = [f for f in files if os.path.exists(f.replace(chr(92), '/').replace('build/recon/', 'recon/')[:-2])]
for i in range(0, len(files), 60):
    batch = [f.replace(chr(92), '/').replace(R, '') for f in files[i:i + 60]]
    for ln in subprocess.run([NM, '-A'] + batch, capture_output=True, text=True, cwd=R).stdout.splitlines():
        p = ln.split()
        if len(p) == 3 and p[1] in 'DdBbGgSsCc':
            definer.setdefault(p[2], p[0].split(':')[0].replace('build/recon/', ''))
            alld.setdefault(p[2], []).append(p[0].split(':')[0].replace('build/recon/', ''))


def oidx(o):
    parts = o.lower().split('/')
    base = re.sub(r'(_data)?\.(c|cpp)\.o$', '', parts[-1])
    return idx.get(parts[-2] + '/' + base, idx.get(base))


for sec in (sys.argv[1:] or list(SECS)):
    lo, hi = SECS[sec]
    rows = []
    for a, n in sorted(set(labels)):
        if lo <= a < hi and not re.search(r'\.\d+$', n) and n in definer and oidx(definer[n]) is not None:
            rows.append((a, n, definer[n], oidx(definer[n])))
    # longest non-decreasing subsequence over the link index
    tails, tail_i, prev = [], [], [None] * len(rows)
    for j, r in enumerate(rows):
        p = bisect.bisect_right(tails, r[3])
        if p == len(tails):
            tails.append(r[3]); tail_i.append(j)
        else:
            tails[p] = r[3]; tail_i[p] = j
        prev[j] = tail_i[p - 1] if p else None
    keep, j = set(), tail_i[-1] if tail_i else None
    while j is not None:
        keep.add(j); j = prev[j]
    out = [r for j, r in enumerate(rows) if j not in keep]
    dup = [r for r in out if len(alld[r[1]]) > 1]
    print('== %s: %d owned labels, %d off the link-order run (+%d same-named statics, not decidable by name)' % (sec, len(rows), len(out) - len(dup), len(dup)))
    for a, n in sorted(set(labels)):
        if lo <= a < hi and not re.search(r'\.\d+$', n) and n in definer and oidx(definer[n]) is None:
            print('   %08x %-26s owner %-40s NOT A RETAIL MODULE NAME' % (a, n[:26], definer[n][:40]))
    for a, n, o, i in out:
        if len(alld[n]) > 1:
            continue   # same-named C statics in several objects: the name cannot tell which one this address is
        before = max((r[3] for r in rows if r[0] < a and rows.index(r) in keep), default=None)
        after = min((r[3] for r in rows if r[0] > a and rows.index(r) in keep), default=None)
        cands = ' '.join(key(order[t]).split('/')[-1] for t in range(before or 0, (after if after is not None else before or 0) + 1))[:90]
        print('   %08x %-26s owner %-40s idx %3d  slot %s..%s: %s' % (a, n[:26], o[:40], i, before, after, cands))
