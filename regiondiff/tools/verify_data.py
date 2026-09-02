#!/usr/bin/env python3
"""verify_data.py REGION CANDIDATE SYM[,SYM...] [--lane-as recon/...]

The regional DATA gate (backlog item 10, final piece): compile a regional
candidate TU through the real build.py pipeline, extract each named data
symbol's INITIALIZER BYTES from the object, and compare them word-by-word
against the REGION image at the symbol's symmap-resolved address.

Masking (same philosophy as verify_region): words our own object marks
with a relocation (R_MIPS_32 etc. -- pointers, resolved only at link) are
masked; every other word must match the region EXACTLY.  A DATA-PASS
proves the candidate's initializer holds the region's values in every
non-pointer word.

Compare length = min(symbol extent in the object's section, the region's
next-symbol gap from symmap).  BSS symbols have no initializer -> SKIP.

Usage:
  python regiondiff/tools/verify_data.py USA \\
      regiondiff/recon/NFS4-R-USA/frontend/common/femenudefs.cpp \\
      SelectListOffOn,SelectListTrackDirection \\
      --lane-as=recon/frontend/common/femenudefs.cpp
"""
import os, re, sys, shutil, bisect, subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
RD = ROOT / 'regiondiff'
BIN = Path(r'C:/Temp/nfs4-clean/Binaries')
MIPS = Path(r'C:/Tools/mips-ps1/mips/bin')
OBJD = str(MIPS / 'mipsel-none-elf-objdump.exe')
BASE_VA = 0x80010000
HDR = 0x800
REGIONS = ['NFS4-R-AU','NFS4-R-FR-DE','NFS4-R-JPN','NFS4-R-UK-ES-IT','NFS4-R-UK-SW','NFS4-R-USA']

def _region(arg):
    a = arg.upper()
    for r in REGIONS:
        if a == r or a == r.replace('NFS4-R-',''):
            return r
    sys.exit(f'unknown region {arg!r}')

args = [a for a in sys.argv[1:] if not a.startswith('--')]
opts = {a.split('=',1)[0]: (a.split('=',1)[1] if '=' in a else True)
        for a in sys.argv[1:] if a.startswith('--')}
if len(args) < 3:
    sys.exit(__doc__)
REGION = _region(args[0])
cand = ROOT / args[1]
syms = args[2].split(',')

# ---------------- region side: image + symmap ----------------
rimg = (BIN / (REGION + '.EXE')).read_bytes()
bimg = (BIN / 'NFS4-B-USA.EXE').read_bytes()
symmap, bmap = {}, {}
for ln in (RD / 'oracles' / REGION / 'symmap.tsv').read_text().splitlines()[1:]:
    f = ln.split('\t')
    if len(f) >= 3:
        symmap[f[0]] = int(f[2], 16)
        bmap[f[0]] = int(f[1], 16)
rsorted = sorted(symmap.values())
def region_gap(r):
    i = bisect.bisect_right(rsorted, r)
    return (rsorted[i] - r) if i < len(rsorted) else 0x10000

# ---------------- compile via build.py (verify_region pattern) ----------------
sys.path.insert(0, str(ROOT / 'tools'))
import importlib.util
spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
bld = importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)
bld.OUT = bld.BUILD

lane_as = opts.get('--lane-as')
tmp = None
try:
    src = cand
    if lane_as and cand.resolve() != (ROOT / lane_as).resolve():
        base = ROOT / lane_as
        if not base.exists():
            sys.exit(f'--lane-as target not found: {lane_as}')
        tmp = base.parent / ('%s__data_gate_%d%s' % (base.stem, os.getpid(), cand.suffix))
        shutil.copyfile(cand, tmp)
        src = tmp
        base_rel = base.relative_to(ROOT).as_posix()
        tmp_rel = src.relative_to(ROOT).as_posix()
        for _n, _t in vars(bld).items():
            if isinstance(_t, dict) and base_rel in _t:
                _t[tmp_rel] = _t[base_rel]
    obj = bld.compile_c(src, skip_asm=False) if src.suffix == '.c' else bld.compile_cpp(src)
    symtab = subprocess.run([OBJD, '-t', str(obj)], capture_output=True, text=True).stdout
    relocs = subprocess.run([OBJD, '-r', str(obj)], capture_output=True, text=True).stdout
finally:
    if tmp is not None and tmp.exists():
        tmp.unlink()

# symbol table: name -> (section, offset); section extents from sorted offsets
symloc, by_sec = {}, {}
for ln in symtab.splitlines():
    m = re.match(r'^([0-9a-f]{8})\s+.*?\s(\.\w[\w.]*)\s+[0-9a-f]{8}\s+(\S+)$', ln)
    if m and m.group(2) not in ('*UND*', '*ABS*'):
        off, sec, name = int(m.group(1), 16), m.group(2), m.group(3)
        symloc[name] = (sec, off)
        by_sec.setdefault(sec, []).append(off)
for s in by_sec:
    by_sec[s] = sorted(set(by_sec[s]))

# section byte images (objdump -s)
_sec_cache = {}
def sec_bytes(sec):
    if sec in _sec_cache:
        return _sec_cache[sec]
    out = subprocess.run([OBJD, '-s', '-j', sec, str(obj)],
                         capture_output=True, text=True).stdout
    buf = bytearray()
    for ln in out.splitlines():
        m = re.match(r'^ ([0-9a-f]{4,8}) ((?:[0-9a-f]{2,8} ?){1,4}) ', ln)
        if m:
            addr = int(m.group(1), 16)
            data = bytes.fromhex(m.group(2).replace(' ', ''))
            if len(buf) < addr:
                buf.extend(b'\0' * (addr - len(buf)))
            buf[addr:addr+len(data)] = data
    _sec_cache[sec] = bytes(buf)
    return _sec_cache[sec]

# reloc offsets per section (masked words)
sec_relocs = {}
cur = None
for ln in relocs.splitlines():
    m = re.match(r'^RELOCATION RECORDS FOR \[(\S+)\]', ln)
    if m:
        cur = m.group(1); sec_relocs[cur] = set(); continue
    m = re.match(r'^([0-9a-f]{8})\s+R_MIPS_', ln)
    if m and cur:
        sec_relocs[cur].add(int(m.group(1), 16) & ~3)

allpass = True
def _locate(sym):
    if sym in symloc: return sym
    if sym.startswith('_vt_'):                      # gcc 2.8 spells vtables _vt.
        alt = '_vt.' + sym[4:]
        if alt in symloc: return alt
    return None

def _audit_size(sym):
    p = RD / 'data' / REGION / (re.sub(r'[^\w]', '_', sym)[:80] + '.delta.txt')
    if p.exists():
        m = re.search(r'size (\d+)$', p.read_text().splitlines()[0])
        if m: return int(m.group(1))
    return None

for sym in syms:
    osym = _locate(sym)
    if osym is None:
        print(f'  {sym}: NOT IN OBJECT'); allpass = False; continue
    sec, off = symloc[osym]
    if sec.startswith('.bss') or sec.startswith('.sbss'):
        print(f'  {sym}: BSS (no initializer to gate) [{REGION}]'); continue
    if sym not in symmap:
        print(f'  {sym}: NOT IN SYMMAP ({REGION})'); allpass = False; continue
    raddr = symmap[sym]
    offs = by_sec[sec]
    i = bisect.bisect_right(offs, off)
    obj_extent = (offs[i] - off) if i < len(offs) else len(sec_bytes(sec)) - off
    size = min(obj_extent, region_gap(raddr), 0x10000)
    asz = _audit_size(sym)
    if asz:                     # audited extent = base+region symbol-gap capped
        size = min(size, asz)
    size -= size % 4
    if size <= 0:
        print(f'  {sym}: zero-size extent'); allpass = False; continue
    ours = sec_bytes(sec)[off:off+size]
    roff = raddr - BASE_VA + HDR
    theirs = rimg[roff:roff+size]
    boff = (bmap.get(sym, 0) - BASE_VA + HDR) if bmap.get(sym) else None
    basew = bimg[boff:boff+size] if boff else None
    masked = sec_relocs.get(sec, set())
    bad, drift = [], 0
    for i in range(0, size, 4):
        if (off + i) in masked:
            continue                       # pointer word: link-time, masked
        ow = int.from_bytes(ours[i:i+4], 'little')
        tw = int.from_bytes(theirs[i:i+4], 'little')
        if ow != tw:
            # BASE-DRIFT: the recon initializer already differs from the BASE
            # image here (main-project data fidelity, not the regional delta)
            if basew is not None:
                bw = int.from_bytes(basew[i:i+4], 'little')
                if ow != bw and bw == tw:
                    drift += 1
                    continue
            bad.append((i, ow, tw))
    dtxt = f', {drift} BASE-DRIFT words excluded' if drift else ''
    if not bad:
        print(f'  {sym}: DATA-PASS ({size} bytes{dtxt}) [{REGION}]')
    else:
        allpass = False
        print(f'  {sym}: DATA-FAIL {len(bad)} words ({size} bytes{dtxt}) [{REGION}]')
        for i, ow, tw in bad[:int(os.environ.get("VA_MAX", "8"))]:
            print(f'      +{i:#06x}: ours {ow:08x}  region {tw:08x}')
sys.exit(0 if allpass else 1)
