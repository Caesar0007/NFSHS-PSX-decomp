#!/usr/bin/env python3
"""value_audit.py -- reliable initializer-VALUE audit vs retail (NFS4.MAP).

Only audits data symbols whose RETAIL ADDRESS is known exactly -- no fragile
base-anchoring:
  * name encodes it: DAT_<hex8> / D_<hex8> / lbl_<hex8>
  * or the name is a global in NFS4.MAP
For each such symbol, compare our object's initializer bytes (over the
obj-local extent = gap to the next symbol in the section) to retail
(rom/nfs4-f.exe at the known address).  Pointer words (R_MIPS_32) are
RESOLVED (our target's known/MAP address) and compared, not masked -- so a
pointer to the wrong symbol is caught.  Every non-pointer word must match.

Usage: py -3.14 runtime/tools/value_audit.py [pathsubstr ...]  (default eaclib,syslib)
"""
import re, struct, subprocess, sys, bisect
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
MAP = Path(r'C:/Temp/_from_github/NFS4.MAP')
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
IMG = (ROOT / 'rom' / 'nfs4-f.exe').read_bytes()[0x800:]
LOAD = 0x80010000
INIT = {'.data', '.sdata', '.rdata'}
filt = sys.argv[1:] or ['eaclib', 'syslib']

MAPS = {}
for ln in MAP.read_text(errors='replace').splitlines():
    m = re.match(r'^ ([0-9A-F]{8}) (\S+)\s*$', ln)
    if m: MAPS.setdefault(m.group(2), int(m.group(1), 16))

def known_addr(name):
    m = re.match(r'^(?:DAT|D|lbl|func)_([0-9A-Fa-f]{8})$', name)
    if m: return int(m.group(1), 16)
    return MAPS.get(name)

def imgword(va):
    o = va - LOAD
    return struct.unpack_from('<I', IMG, o)[0] if 0 <= o+4 <= len(IMG) else None

def run(*a): return subprocess.run(a, capture_output=True, text=True).stdout

_cache = {}
def secbytes(obj, sec):
    k = (str(obj), sec)
    if k in _cache: return _cache[k]
    buf = bytearray()
    for ln in run(OBJD, '-s', '-j', sec, str(obj)).splitlines():
        m = re.match(r'^ ([0-9a-f]{4,8}) ((?:[0-9a-f]{2,8} ?){1,4}) ', ln)
        if m:
            a = int(m.group(1),16); d = bytes.fromhex(m.group(2).replace(' ',''))
            if len(buf)<a: buf.extend(b'\0'*(a-len(buf)))
            buf[a:a+len(d)] = d
    _cache[k] = bytes(buf); return _cache[k]

def main():
    # Only audit objects whose CURRENT source file exists -- skips stale orphan
    # build artifacts (probe/check/wave/region_gate scratch .o files that linger
    # in build/ but have no live source, e.g. draww_a6chk.cpp.o).
    def has_source(o):
        rel = o.relative_to(ROOT/'build')          # recon/.../name.cpp.o
        src = ROOT / rel.with_suffix('')           # recon/.../name.cpp
        return src.exists()
    objs = [p for p in (ROOT/'build'/'recon').rglob('*.o')
            if '__' not in p.stem and has_source(p)
            and any(f in str(p).replace('\\','/') for f in filt)]
    print(f'auditing {len(objs)} objects: {", ".join(filt)}')
    bugs = []; checked = 0
    for obj in objs:
        st = run(OBJD, '-t', str(obj))
        secsyms = {}   # sec -> [(off, name)]
        for ln in st.splitlines():
            m = re.match(r'^([0-9a-f]{8})\s+\S.*?\s(\.\w[\w.]*)\s+[0-9a-f]{8}\s+(\S+)$', ln)
            if m and m.group(2) in INIT and not m.group(3).startswith('.'):
                secsyms.setdefault(m.group(2), []).append((int(m.group(1),16), m.group(3)))
        if not secsyms: continue
        # data relocs
        datarel = {}; cur=None
        for ln in run(OBJD,'-r',str(obj)).splitlines():
            m=re.match(r'^RELOCATION RECORDS FOR \[(\S+)\]',ln)
            if m: cur=m.group(1); continue
            m=re.match(r'^([0-9a-f]{8})\s+R_MIPS_32\s+(\S+)$',ln)
            if m and cur in INIT: datarel.setdefault(cur,{})[int(m.group(1),16)]=m.group(2)
        for sec, lst in secsyms.items():
            lst.sort()
            offs = [o for o,_ in lst]
            ob = secbytes(obj, sec)
            dr = datarel.get(sec, {})
            # WHOLE-SECTION anchor: base from known-address symbols in this
            # section (reliable -- anchored to a real address, not consensus).
            basecand = {}
            for off, name in lst:
                ra = known_addr(name)
                if ra is not None:
                    basecand.setdefault(ra - off, 0); basecand[ra - off] += 1
            if not basecand:
                continue                      # no reliable anchor -> skip section
            if len(basecand) > 1:
                continue                      # known addrs disagree -> ambiguous
            base = next(iter(basecand))
            # require >=2 known anchors agreeing on the base: that CONFIRMS our
            # section order matches retail's, so whole-section (incl. anonymous
            # locals) is sound.  1 anchor only pins its own point -> a reordered
            # section would produce false positives (verified: AIHigh vtable).
            if basecand[base] < 2:
                continue
            def owner(i):
                k = bisect.bisect_right(offs, i) - 1
                if k < 0: return f'{sec}+{i:#x}'
                nm = lst[k][1]
                d = i - lst[k][0]
                return f'{nm}+{d:#x}' if d else nm
            bad = []
            for i in range(0, len(ob)-3, 4):
                ow = int.from_bytes(ob[i:i+4],'little')
                tw = imgword(base + i)
                if tw is None: continue
                checked += 1
                if i in dr:                       # pointer: resolve target
                    t = known_addr(dr[i])
                    if t is None: continue
                    our = t + ow
                    if our != tw: bad.append((i, owner(i), our, tw, 'ptr->'+dr[i]))
                elif ow != tw:
                    bad.append((i, owner(i), ow, tw, 'val'))
            # group by owning symbol
            from collections import defaultdict as _dd
            g = _dd(list)
            for i,own,ov,tv,k in bad: g[own.split('+')[0]].append((own,ov,tv,k))
            for sym, ws in g.items():
                bugs.append((obj.stem, sym, sec, f'0x{base:08X}',
                             [(0,ov,tv,k) for _,ov,tv,k in ws], [w[0] for w in ws]))
    print(f'checked {checked} data words (whole-section, anchored by known addr)')
    print(f'=== {len(bugs)} symbols with real mismatches ===')
    for item in sorted(bugs, key=lambda b:-len(b[4])):
        tu,name,sec,ra,bad = item[0],item[1],item[2],item[3],item[4]
        owns = item[5] if len(item) > 5 else None
        print(f'  [{tu}] {name} ({sec} base {ra}): {len(bad)} word(s)')
        for j,(o,ov,tv,k) in enumerate(bad[:6]):
            lbl = owns[j] if owns else f'+{o:#05x}'
            print(f'      {lbl} {k}: ours {ov:08x}  retail {tv:08x}')

if __name__=='__main__':
    main()
