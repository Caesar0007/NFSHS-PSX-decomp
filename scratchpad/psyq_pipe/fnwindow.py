#!/usr/bin/env python3
"""fnwindow.py [--vs-honest] NAME [NAME...] -- for a retail function, find where our PSYLINK
copy first diverges in SHAPE (relocation fields masked, conditional-branch offsets tolerated),
say whether it is an inserted / missing word, and print both sides disassembled around it."""
import sys, subprocess, tempfile
from images import *
VSH = '--vs-honest' in sys.argv
names = [a for a in sys.argv[1:] if not a.startswith('--')]
R = rom(); n = len(R)
img, cov = cpe_image(n)
if VSH:
    ref, rcov = honest_image(n); rsym = honest_symbols()
else:
    ref, rcov = R, None; rsym = None
ours = our_symbols(); fns = retail_functions(); byname = dict((nm, a) for a, nm in fns)


def dis(data, base):
    with tempfile.NamedTemporaryFile(delete=False, suffix='.bin') as f:
        f.write(data); p = f.name
    r = subprocess.run([OBJDUMP, '-D', '-b', 'binary', '-m', 'mips:3000', '-EL', '--adjust-vma=%#x' % base, p], capture_output=True, text=True)
    Path(p).unlink()
    return [l for l in r.stdout.splitlines() if re.match(r'^\s*[0-9a-f]+:', l)]


for name in names:
    ra0 = byname[name]; oa = ours[name]
    ra = rsym[name] if VSH else ra0
    k = [a for a, _ in fns].index(ra0)
    size = min((fns[k + 1][0] - ra0) if k + 1 < len(fns) else 0x400, 0x4000)
    r = ref[ra - LOAD: ra - LOAD + size]; o = img[oa - LOAD: oa - LOAD + size]
    j = next((j for j in range(0, size - 3, 4) if norm(r[j:j + 4]) != norm(o[j:j + 4]) and not is_branch_pair(r[j:j + 4], o[j:j + 4])), None)
    print('== %s ref %#x ours %#x size %#x first shape diff at +%s' % (name, ra, oa, size, hex(j) if j is not None else None))
    if j is None: continue
    ins = all(norm(o[j + 4 + q:j + 8 + q]) == norm(r[j + q:j + 4 + q]) for q in range(0, 32, 4))
    dele = all(norm(o[j + q:j + 4 + q]) == norm(r[j + 4 + q:j + 8 + q]) for q in range(0, 32, 4))
    print('   ours has an EXTRA word here' if ins else '   ours is MISSING a word here' if dele else '   substitution / other')
    lo = max(0, j - 24); hi = min(size, j + 28)
    for a, b in zip(dis(r[lo:hi], ra + lo), dis(o[lo:hi], oa + lo)):
        print('   %-52s | %s' % (a[:52], b))
