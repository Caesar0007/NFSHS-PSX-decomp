"""module_slot.py MODULE... -- what sits in a retail module's LINK-ORDER slot.  For each named module (SYM FILE record) prints the
retail function labels (address order) owned by recon objects whose module index is within +-2 of it, plus any function whose
recon owner has NO retail module name at all (the usual sign of a recon file named differently from its retail member)."""
import glob
import re
import subprocess
import sys

R = 'C:/Temp/nfs4-decomp/'
SYM = 'C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt'
NM = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-nm.exe'
order, labels = [], []
for l in open(SYM, errors='replace'):
    m = re.search(r'Def class FILE type NULL size 0 name (\S+)', l)
    if m:
        if m.group(1) not in order:
            order.append(m.group(1))
        continue
    m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) ([26]) (\S+)$', l)
    if m and 0x8005797C <= int(m.group(1), 16) < 0x8010CCD4:
        labels.append((int(m.group(1), 16), m.group(3)))


def key(n):
    m = re.search(r'\(([^)]+)\)', n)
    return (m.group(1) if m else n.split(chr(92))[-1]).lower().replace('.obj', '')


idx = {}
for i, n in enumerate(order):
    idx.setdefault(key(n), i)
definer = {}
files = sorted(glob.glob(R + 'build/recon/**/*.o', recursive=True))
for i in range(0, len(files), 60):
    batch = [f.replace(chr(92), '/').replace(R, '') for f in files[i:i + 60]]
    out = subprocess.run([NM, '-A'] + batch, capture_output=True, text=True, cwd=R).stdout
    for ln in out.splitlines():
        p = ln.split()
        if len(p) == 3 and p[1] in 'Tt':
            definer.setdefault(p[2].replace('___', '_._'), p[0].split(':')[0])
rows = []
for a, n in sorted(set(labels)):
    o = definer.get(n) or definer.get(n.replace('_._', '___'))
    k = re.sub(r'\.(c|cpp)\.o$', '', o.split('/')[-1]).lower() if o else None
    rows.append((a, n, o, idx.get(k) if k else None))
for mod in sys.argv[1:]:
    k = idx[mod.lower()]
    below = [r for r in rows if r[3] is not None and r[3] < k]
    above = [r for r in rows if r[3] is not None and r[3] > k]
    pk = max(r[3] for r in below) if below else None
    nk = min(r[3] for r in above) if above else None
    lo = max(r[0] for r in below if r[3] == pk) if below else 0
    hi = min(r[0] for r in above if r[3] == nk) if above else 0xFFFFFFFF
    print('== %s  link index %d   slot between %s (idx %s, last fn %08x) and %s (idx %s, first fn %08x)' % (
        mod, k, key(order[pk]) if pk is not None else '-', pk, lo, key(order[nk]) if nk is not None else '-', nk, hi & 0xFFFFFFFF))
    inside = [r for r in rows if lo < r[0] < hi]
    if not inside:
        print('   (no function label in the slot: the module contributes no text)')
    for a, n, o, i2 in inside:
        print('   %08x %-34s %-52s idx %s' % (a, n[:34], (o or '?').replace('build/recon/', '')[:52], i2))
