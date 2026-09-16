#!/usr/bin/env python3
"""cutres.py STEM VA_LO VA_HI TAG [--apply] -- cut the retail-byte residual window [VA_LO, VA_HI)
out of asm/data/<STEM>.s (splat dlabel/enddlabel blocks) because a recon TU now owns those
bytes natively.  If blocks follow the window inside the same output subsection, a new
`.section <base>.<stem-tail>_post_<TAG>` marker is inserted so the honest ld fragment can list
[subsection-before] [owner object] [new subsection].  Prints the ldfrag lines to use.
Reassembles the residual (build.assemble_s) on --apply."""
import re, sys
from pathlib import Path
ROOT = Path('C:/Temp/nfs4-decomp'); sys.path.insert(0, str(ROOT / 'tools'))
stem, lo, hi, tag = sys.argv[1], int(sys.argv[2], 16), int(sys.argv[3], 16), sys.argv[4]
apply = '--apply' in sys.argv
p = ROOT / 'asm' / 'data' / (stem + '.s')
lines = p.read_text(errors='replace').split('\n')
VA = re.compile(r'/\* [0-9A-F]+ ([0-9A-F]{8}) ')
# block = [start line, end line) with first VA; also track current .section
blocks = []; cur = None; section = None; secs = []
for i, l in enumerate(lines):
    m = re.match(r'^\s*\.section\s+(\S+)', l)
    if m: section = m.group(1); secs.append((i, section))
    if re.match(r'^(dlabel|alabel|glabel|jlabel)\s', l) or re.match(r'^nonmatching\s', l):
        if cur is None: cur = [i, None, None, section]
    mv = VA.search(l)
    if cur is not None and mv and cur[2] is None: cur[2] = int(mv.group(1), 16)
    if re.match(r'^end[d]?label\s', l):
        cur[1] = i + 1; blocks.append(tuple(cur)); cur = None
inwin = [b for b in blocks if b[2] is not None and lo <= b[2] < hi]
if not inwin:
    sys.exit('no blocks in window')
first, last = inwin[0], inwin[-1]
# contiguity: next block after last must start at hi (or none)
after = [b for b in blocks if b[2] is not None and b[2] >= hi]
nxt = after[0] if after else None
print('window blocks: %d (%s .. %s), section %s; next block after window: %s' % (
    len(inwin), hex(first[2]), hex(last[2]), first[3], hex(nxt[2]) if nxt else None))
if nxt and nxt[2] != hi:
    print('WARNING: next block starts at %s, not %s (window covers a partial block?)' % (hex(nxt[2]), hex(hi)))
base = '.sdata' if 'sdata' in stem else '.data'
tail = stem.split('_')[-1].split('.')[0]      # r16
newsec = '%s.%s_post_%s' % (base, tail, tag)
out = lines[:first[0]]
# drop blank lines directly before the window to keep things tidy
while out and not out[-1].strip(): out.pop()
rest = lines[last[1]:]
need_marker = nxt is not None and nxt[3] == first[3]
if need_marker:
    out += ['', '.section %s' % newsec, '']
out += rest
objfile = 'build/asm/data/%s.s.o' % stem
print('ldfrag: keep   %s(%s);' % (objfile, first[3] or base))
print('ldfrag: insert <owner object>(%s);   /* %s..%s */' % (base, hex(lo), hex(hi)))
if need_marker:
    print('ldfrag: insert %s(%s);' % (objfile, newsec))
if apply:
    p.write_text('\n'.join(out))
    import build
    build.assemble_s(p)
    print('applied + reassembled', p.name)
