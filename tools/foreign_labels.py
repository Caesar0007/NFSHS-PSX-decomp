"""tools/foreign_labels.py -- the `sndcents[512]` class: a reconstructed data object whose extent runs over a RETAIL LABEL it does
not define (a byte-identical COPY of a neighbour's data is invisible to every byte gate).

For every reconstructed input section the honest link placed (link map), every retail SYM label (kinds 2 and 6) strictly
inside its span must be a symbol THIS object defines at that very address.  A label that is not is reported with the
symbol of ours whose extent covers it (extent = up to the object's next symbol in that section, or the section end).
Function-statics (`name.NN`) are compared by base name (the numbering differs between compilers runs)."""
import bisect
import re
import subprocess
from collections import defaultdict

R = 'C:/Temp/nfs4-decomp/'
SYM = __import__('retail_sym').txt()
OD = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
DATA = [(0x80010000, 0x800128F0), (0x80051260, 0x80054548), (0x80054548, 0x8005797C), (0x8010CCD4, 0x80148B04)]


def isdata(a):
    return any(lo <= a < hi for lo, hi in DATA)


def base(n):
    return re.sub(r'\.\d+$', '', n)


labels = defaultdict(set)
for l in open(SYM, errors='replace'):
    m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) ([26]) (\S+)$', l)
    if m and isdata(int(m.group(1), 16)):
        labels[int(m.group(1), 16)].add(m.group(3))
addrs = sorted(labels)

# placed reconstructed input sections
lines = open(R + 'build/gen_ld/recon_multdef-ok.map', errors='replace').read().splitlines()
one = re.compile(r'^ (\.\S+)\s+0x([0-9a-f]{8})\s+0x([0-9a-f]+)\s+(\S+\.o)$')
two = re.compile(r'^\s+0x([0-9a-f]{8})\s+0x([0-9a-f]+)\s+(\S+\.o)$')
placed = []
for i, ln in enumerate(lines):
    m = one.match(ln)
    if m:
        placed.append((m.group(1), int(m.group(2), 16), int(m.group(3), 16), m.group(4)))
    elif re.match(r'^ \.\S+$', ln) and i + 1 < len(lines):
        m = two.match(lines[i + 1])
        if m:
            placed.append((ln.strip(), int(m.group(1), 16), int(m.group(2), 16), m.group(3)))
placed = [(s, a, z, o.replace(chr(92), '/')) for s, a, z, o in placed]
placed = [(s, a, z, o[o.index('build/recon/'):]) for s, a, z, o in placed if 'build/recon/' in o and z and isdata(a)
          and not s.startswith(('.text', '.reginfo', '.mdebug', '.pdr', '.comment'))]

symcache = {}


def syms(o):
    if o not in symcache:
        d = defaultdict(list)
        out = subprocess.run([OD, '-t', R + o], capture_output=True, text=True).stdout
        for ln in out.splitlines():
            m = re.match(r'^([0-9a-f]{8}) (.{7}) (\S+)\s+([0-9a-f]{8}) (\S+)$', ln)
            if m and m.group(3) not in ('*UND*', '*ABS*', '*COM*') and 'd' not in m.group(2)[5:] and 'f' not in m.group(2)[5:]:
                d[m.group(3)].append((int(m.group(1), 16), m.group(5)))
        symcache[o] = d
    return symcache[o]


# bigbuf.obj is the reservation the whole front overlay is linked OVER (retail: group `front over(text)`), so every overlay
# label lies inside it by design; it is checked for its own label only.
OVERLAID = ('frontend/psx/bigbuf.c.o',)
ALLOW = set()
# labels the overlaid reservation itself defines (bigBuf @0x80010000): the overlay object that starts there shares the address
overlaid_defs = set()
for sec, a, z, o in placed:
    if o.endswith(OVERLAID):
        for f, n in syms(o).get(sec, []):
            overlaid_defs.add((a + f, base(n)))
hits = []
for sec, a, z, o in sorted(placed, key=lambda r: r[1]):
    i = bisect.bisect_right(addrs, a)          # strictly inside: a label AT the section start is the object's own business
    inside = []
    while i < len(addrs) and addrs[i] < a + z:
        inside.append(addrs[i]); i += 1
    # the label at the very start also counts when the object defines nothing there
    if a in labels:
        inside.insert(0, a)
    if not inside:
        continue
    if o.endswith(OVERLAID):
        inside = [L for L in inside if L == a]
    mine = sorted(syms(o).get(sec, []))
    offs = [m[0] for m in mine]
    for L in inside:
        off = L - a
        here = {base(n) for f, n in mine if f == off}
        want = {base(n) for n in labels[L]}
        if here & want:
            continue
        if want <= ALLOW or all((L, w) in overlaid_defs for w in want):
            continue
        if here and all(re.match(r'(D|DAT|lbl)_[0-9A-Fa-f]{8}$', n) or n.startswith(('.L', '$')) for n in here) and False:
            continue
        j = bisect.bisect_right(offs, off) - 1
        cover = mine[j] if j >= 0 else (0, '<section head>')
        hits.append((L, sorted(labels[L]), o, sec, cover, off, sorted(here)))

stray = []
outsec = None
for i, ln in enumerate(lines):
    m = re.match(r'^(\.\S+)', ln)
    if m:
        outsec = m.group(1)
    m = one.match(ln)
    if m and outsec in ('.rodata_rest', '.data_rest', '.sbss', '.bss') and int(m.group(3), 16) and 'build/recon/' in m.group(4).replace(chr(92), '/'):
        stray.append((outsec, m.group(1), int(m.group(3), 16), m.group(4).replace(chr(92), '/').split('build/recon/')[1]))
print('%d reconstructed sections sit in a catch-all (no retail address)' % len(stray))
for outsec, sec, z, o in stray:
    print('  %s <- %s(%s) 0x%x' % (outsec, o, sec, z))
print('%d retail labels lie inside a reconstructed section that does not define them' % len(hits))
for L, names, o, sec, cover, off, here in hits:
    print('  %08x %-28s in %s(%s)  covered by %s+0x%x%s' % (L, ','.join(names)[:28], o.replace('build/recon/', ''), sec, cover[1], off - cover[0],
                                                        ('  [ours here: %s]' % ','.join(here)) if here else ''))
raise SystemExit(1 if hits or stray else 0)
