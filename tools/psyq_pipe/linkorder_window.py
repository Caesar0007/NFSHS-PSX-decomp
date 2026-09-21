"""linkorder_window.py LO HI -- every retail label in [LO,HI) with its recon definer and that object's link index
(stale build objects -- no recon source next to them -- are ignored)."""
import glob, os, re, subprocess, sys
from pathlib import Path
R = Path(__file__).resolve().parents[2].as_posix() + '/'
SYM = __import__('retail_sym').txt()
NM = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-nm.exe'
lo, hi = int(sys.argv[1], 16), int(sys.argv[2], 16)
order, labels = [], []
for l in open(SYM, errors='replace'):
    m = re.search(r'Def class FILE type NULL size 0 name (\S+)', l)
    if m:
        if m.group(1) not in order:
            order.append(m.group(1))
        continue
    m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) ([26]) (\S+)$', l)
    if m:
        labels.append((int(m.group(1), 16), int(m.group(2)), m.group(3)))
def key(n):
    m = re.search(r'\(([^)]+)\)', n)
    lib = re.search(r'([a-z0-9]+)\.lib\(', n.lower())
    return ((lib.group(1) + '/') if lib else '') + (m.group(1) if m else n.split(chr(92))[-1]).lower().replace('.obj', '')
idx = {}
for i, n in enumerate(order):
    idx.setdefault(key(n), i)
    idx.setdefault(key(n).split('/')[-1], i)
definer = {}
files = [f.replace(chr(92), '/') for f in sorted(glob.glob(R + 'build/recon/**/*.o', recursive=True))]
files = [f for f in files if os.path.exists(f.replace('build/recon/', 'recon/')[:-2])]
for i in range(0, len(files), 60):
    batch = [f.replace(R, '') for f in files[i:i + 60]]
    for ln in subprocess.run([NM, '-A'] + batch, capture_output=True, text=True, cwd=R).stdout.splitlines():
        p = ln.split()
        if len(p) == 3 and p[1] in 'DdBbGgSsCc':
            definer.setdefault(p[2], []).append(p[0].split(':')[0].replace('build/recon/', ''))
def oidx(o):
    parts = o.lower().split('/')
    base = re.sub(r'(_data)?\.(c|cpp)\.o$', '', parts[-1])
    return idx.get(parts[-2] + '/' + base, idx.get(base))
for a, k, n in sorted(set(labels)):
    if lo <= a < hi:
        d = definer.get(n, [])
        print('%08x %d %-28s %s' % (a, k, n[:28], ' | '.join('%s [%s]' % (o, oidx(o)) for o in d) or '-- no recon definer --'))
