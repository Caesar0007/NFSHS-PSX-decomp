#!/usr/bin/env python3
"""map_audit.py -- definitive data audit vs NFS4.MAP (retail ground truth).

The dev disc's NFS4.MAP == our oracle build's linker map.  For every data
symbol our recon objects define, this checks, using EXACT sections
(objdump -t) and actual bytes:

  * INIT-CLASS mismatch: ours zero-filled (.bss/.sbss) but retail keeps it in
    an initialized section (.data/.sdata) with NONZERO bytes -> our build
    starts it at 0, retail at a real value = runtime bug (the shapeext class).
  * the reverse (ours initialized nonzero, retail zero) -> also a bug.

Reads retail bytes from rom/nfs4-f.exe at the MAP address (symbol extent =
gap to the next MAP symbol, capped).  Zero-vs-zero and reloc-pointer words
are not bugs; pointer words (our object marks them) are skipped.

Usage: py -3.14 runtime/tools/map_audit.py
"""
import re, struct, subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
MAP = Path(r'C:/Temp/_from_github/NFS4.MAP')
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
IMG = (ROOT / 'rom' / 'nfs4-f.exe').read_bytes()[0x800:]
LOAD = 0x80010000
INIT_SECS = {'.data', '.sdata', 'front.data', '.rdata', 'front.rdata'}
ZERO_SECS = {'.bss', '.sbss', 'front.bss'}

def imgw(va):
    o = va - LOAD
    return struct.unpack_from('<I', IMG, o)[0] if 0 <= o + 4 <= len(IMG) else None

def parse_map():
    secs, sym2addr = [], {}
    for ln in MAP.read_text(errors='replace').splitlines():
        m = re.match(r'^ ([0-9A-F]{8}) ([0-9A-F]{8}) [0-9A-F]{8} [0-9A-F]{8} '
                     r'\S+\s+(\S+)\s*$', ln)
        if m:
            secs.append((int(m.group(1), 16), int(m.group(2), 16), m.group(3)))
            continue
        m = re.match(r'^ ([0-9A-F]{8}) (\S+)\s*$', ln)
        if m:
            sym2addr[m.group(2)] = int(m.group(1), 16)
    return secs, sym2addr

def sec_of(secs, a):
    for s, e, n in secs:
        if s <= a <= e:
            return n
    return None

def main():
    secs, sym2addr = parse_map()
    sorted_addrs = sorted(set(sym2addr.values()))
    import bisect
    def extent(a, cap=256):
        i = bisect.bisect_right(sorted_addrs, a)
        gap = (sorted_addrs[i] - a) if i < len(sorted_addrs) else cap
        return max(4, min(gap, cap))

    objs = [p for p in (ROOT / 'build' / 'recon').rglob('*.o') if '__' not in p.stem]
    our_sec = {}       # name -> (section, tu)
    for o in objs:
        st = subprocess.run([OBJD, '-t', str(o)], capture_output=True, text=True).stdout
        for ln in st.splitlines():
            m = re.match(r'^[0-9a-f]{8}\s+.*?\s(\.\w[\w.]*)\s+([0-9a-f]{8})\s+(\S+)$', ln)
            if m and m.group(1) in (INIT_SECS | ZERO_SECS):
                our_sec.setdefault(m.group(3), (m.group(1), int(m.group(2), 16), o.stem))

    bugs = []
    checked = 0
    for name, (osec, osize, tu) in sorted(our_sec.items()):
        if name not in sym2addr:
            continue
        ra = sym2addr[name]
        rsec = sec_of(secs, ra)
        if rsec is None:
            continue
        oc = 'init' if osec in INIT_SECS else 'zero'
        rc = 'init' if rsec in INIT_SECS else 'zero'
        checked += 1
        if oc == rc:
            continue
        # class differs -- is retail NONZERO over the symbol's OWN extent?
        # use our object's symbol size (matches retail), capped by MAP gap.
        n = min(osize or 4, extent(ra))
        rb = IMG[ra - LOAD: ra - LOAD + n]
        nonzero = any(rb) if rb else False
        if oc == 'zero' and rc == 'init':
            verdict = 'BUG: ours .bss/.sbss=0, retail INITIALIZED nonzero' if nonzero \
                      else 'benign: retail init but =0 (section/byte-exact gap only)'
        else:  # oc init, rc zero
            verdict = 'check: ours initialized, retail .bss=0'
        bugs.append((name, osec, rsec, f'0x{ra:08X}',
                     f'0x{imgw(ra):08X}' if imgw(ra) is not None else '(bss)',
                     verdict, tu))
    print(f'checked {checked} data symbols (exact sections vs NFS4.MAP)')
    real = [b for b in bugs if b[5].startswith('BUG') or b[5].startswith('check')]
    print(f'=== {len(bugs)} init-class differences; '
          f'{sum(1 for b in bugs if b[5].startswith("BUG"))} are NONZERO-retail BUGS ===')
    for name, osec, rsec, ra, rv, verdict, tu in bugs:
        flag = 'BUG ' if verdict.startswith('BUG') else ('CHK ' if verdict.startswith('check') else '  ')
        print(f'{flag} {name:32} ours {osec:11} retail {rsec:11} @{ra} val {rv}  [{tu}] {verdict}')

if __name__ == '__main__':
    main()
