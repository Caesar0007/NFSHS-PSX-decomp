"""linkorder_slot.py LO_IDX HI_IDX -- per data section, the owned labels whose owner's link index is in [LO,HI], plus the
unowned / non-module labels that sit between them (address order)."""
import glob, os, re, subprocess, sys
R = 'C:/Temp/nfs4-decomp/'
SYM = __import__('retail_sym').txt()
NM = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-nm.exe'
SECS = {'.rdata': (0x80010000, 0x800128F0), '.data': (0x8010CCD4, 0x8013C54C), '.sdata': (0x8013C54C, 0x8013DD7C), '.sbss': (0x8013DD7C, 0x8013DEE0),
        '.bss': (0x8013DEE0, 0x80148B04)}
L, H = int(sys.argv[1]), int(sys.argv[2])
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
definer = {}
files = [f.replace(chr(92), '/') for f in sorted(glob.glob(R + 'build/recon/**/*.o', recursive=True))]
files = [f for f in files if os.path.exists(f.replace('build/recon/', 'recon/')[:-2])]
for i in range(0, len(files), 60):
    for ln in subprocess.run([NM, '-A'] + [f.replace(R, '') for f in files[i:i + 60]], capture_output=True, text=True, cwd=R).stdout.splitlines():
        p = ln.split()
        if len(p) == 3 and p[1] in 'DdBbGgSsCcRr':
            definer.setdefault(p[2], []).append(p[0].split(':')[0].replace('build/recon/', ''))
def oidx(o):
    parts = o.lower().split('/')
    base = re.sub(r'(_data)?\.(c|cpp)\.o$', '', parts[-1])
    return idx.get(parts[-2] + '/' + base, idx.get(base))
for sec, (lo, hi) in SECS.items():
    rows = []
    for a, n in sorted(set(labels)):
        if lo <= a < hi and not re.search(r'\.\d+$', n):
            ds = definer.get(n, [])
            ii = [oidx(d) for d in ds if oidx(d) is not None]
            rows.append((a, n, ds, ii))
    hit = [j for j, r in enumerate(rows) if any(L <= i <= H for i in r[3])]
    if not hit:
        print('== %s: nothing owned by link index %d..%d' % (sec, L, H)); continue
    print('== %s' % sec)
    for a, n, ds, ii in rows[max(0, hit[0] - 2):hit[-1] + 3]:
        print('   %08x %-26s %s' % (a, n[:26], ' | '.join('%s [%s]' % (d, oidx(d)) for d in ds) or '-- unowned --'))
