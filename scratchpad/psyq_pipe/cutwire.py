#!/usr/bin/env python3
"""cutwire.py STEM VA_LO VA_HI OWNER SEC [--apply]
Give a retail-byte window that a recon TU now emits natively back to that TU in the honest
GNU link: cut the splat blocks [VA_LO, VA_HI) out of asm/data/<STEM>.s and rewrite the
section's ldfrag so the owner object's section is listed where the bytes were.
  STEM   data_8010CCD4_r15 | sdata_8013C54C_r20 ...
  OWNER  build/recon/game/psx/night.cpp.o
  SEC    .data | .sdata
Rules (checked, refused otherwise):
  * the window must be a whole run of blocks inside ONE residual subsection;
  * if the owner already has a line for SEC in the ldfrag it must be the line right after
    the residual subsection (window at the subsection's end) or right before it (window at
    the subsection's start) -- an object's section is one contiguous blob;
  * otherwise the subsection is split with a `<sub>_post_<tag>` marker and the owner line
    goes between the two halves."""
import re, sys
from pathlib import Path
ROOT = Path('C:/Temp/nfs4-decomp'); sys.path.insert(0, str(ROOT / 'tools'))
stem, lo, hi, owner, sec = sys.argv[1], int(sys.argv[2], 16), int(sys.argv[3], 16), sys.argv[4], sys.argv[5]
apply = '--apply' in sys.argv
tag = Path(owner).stem.split('.')[0].lower()
stem = stem + ('.sdata' if sec == '.sdata' else '.data')      # asm/data/<stem>.data.s / .sdata.s
sfile = ROOT / 'asm' / 'data' / (stem + '.s')
ldfrag = ROOT / 'linkers' / ('nfs4_recon.sdata_8013C54C.ldfrag' if sec == '.sdata' else 'nfs4_recon.data_8010CCD4.ldfrag')
lines = sfile.read_text(errors='replace').split('\n')
VA = re.compile(r'/\* [0-9A-F]+ ([0-9A-F]{8}) ')
blocks = []; cur = None; section = sec
for i, l in enumerate(lines):
    m = re.match(r'^\s*\.section\s+([^\s,]+)', l)
    if m: section = m.group(1)
    if cur is None and (re.match(r'^(dlabel|alabel|glabel|jlabel)\s', l) or re.match(r'^nonmatching\s', l)):
        cur = [i, None, None, None, section]
    mv = VA.search(l)
    if cur is not None and mv:
        va = int(mv.group(1), 16)
        if cur[2] is None: cur[2] = va
        cur[3] = va + 4          # crude end: last data word + 4 (words); refined below
    if re.match(r'^end[d]?label\s', l) and cur is not None:
        cur[1] = i + 1; blocks.append(tuple(cur)); cur = None
# refine block ends from the next block's start
blocks.sort(key=lambda b: b[2] if b[2] is not None else 0)
for k in range(len(blocks) - 1):
    b = list(blocks[k]); b[3] = blocks[k + 1][2]; blocks[k] = tuple(b)
inwin = [b for b in blocks if b[2] is not None and lo <= b[2] < hi]
if not inwin: sys.exit('no blocks in window')
subs = {b[4] for b in inwin}
if len(subs) != 1: sys.exit('window spans subsections %s' % subs)
sub = inwin[0][4]
subblocks = [b for b in blocks if b[4] == sub]
sub_lo, sub_hi = subblocks[0][2], subblocks[-1][3]
at_start = inwin[0][2] == sub_lo; at_end = inwin[-1][3] == sub_hi or inwin[-1] is subblocks[-1]
print('window %s..%s: %d blocks in subsection %s (%s..%s) start=%s end=%s' % (hex(lo), hex(hi), len(inwin), sub, hex(sub_lo), hex(sub_hi), at_start, at_end))
if inwin[0][2] != lo: print('WARNING first block at', hex(inwin[0][2]), 'not', hex(lo))
# --- ldfrag ---
L = ldfrag.read_text().split('\n')
objfile = 'build/asm/data/%s.s.o' % stem
def find(pat):
    return [i for i, l in enumerate(L) if pat in l]
subline = find('%s(%s)' % (objfile, sub))
if len(subline) != 1: sys.exit('ldfrag: subsection line not found/unique: %s(%s) -> %s' % (objfile, sub, subline))
si = subline[0]
ownline = find('%s(%s)' % (owner, sec))
def significant(i):
    """ldfrag line index i skipping comment-only / blank lines"""
    return not re.match(r'^\s*(/\*.*\*/)?\s*$', L[i])
def next_sig(i):
    j = i + 1
    while j < len(L) and not significant(j): j += 1
    return j
def prev_sig(i):
    j = i - 1
    while j >= 0 and not significant(j): j -= 1
    return j
newL = list(L)
ownref = '    %s(%s);   /* %s..%s native owner (was %s) */' % (owner, sec, hex(lo), hex(hi), stem)
newsec = '%s_post_%s' % (sub, tag)
if ownline:
    oi = ownline[0]
    if at_end and oi == next_sig(si):
        print('ldfrag: owner already right after the subsection -> window joins the owner (no ldfrag change)')
        newL[oi] = re.sub(r'/\*.*\*/', '', newL[oi]).rstrip() + '   /* now from %s (was %s) */' % (hex(lo), stem)
    elif at_start and oi == prev_sig(si):
        print('ldfrag: owner already right before the subsection -> window joins the owner')
        newL[oi] = re.sub(r'/\*.*\*/', '', newL[oi]).rstrip() + '   /* now to %s (was %s) */' % (hex(hi), stem)
    else:
        sys.exit('REFUSED: owner %s already placed at ldfrag line %d, not adjacent to residual line %d (window start=%s end=%s)' % (owner, oi, si, at_start, at_end))
else:
    if at_start and at_end:
        newL[si] = ownref
    elif at_start:
        newL[si:si + 1] = [ownref, L[si]]
    elif at_end:
        newL[si:si + 1] = [L[si], ownref]
    else:
        newL[si:si + 1] = [L[si], ownref, '    %s(%s);' % (objfile, newsec)]
# --- residual .s ---
first, last = inwin[0], inwin[-1]
out = lines[:first[0]]
while out and not out[-1].strip(): out.pop()
rest = lines[last[1]:]
if not at_start and not at_end:      # middle: the remainder needs its own subsection name
    out += ['', '.section %s' % newsec, '']
out += rest
for l in newL:
    if l not in L: print('ldfrag +', l.strip())
if apply:
    sfile.write_text('\n'.join(out)); ldfrag.write_text('\n'.join(newL))
    import build; build.assemble_s(sfile)
    print('applied')
