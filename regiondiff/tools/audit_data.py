#!/usr/bin/env python3
"""audit_data.py -- the regional DATA audit (backlog item 10), built on the
per-region symbol maps (gen_symmap.py).

For every mapped data symbol that lives IN-FILE in both images, compare the
base bytes at base_addr against the region bytes at region_addr, word by
word.  A word is judged:

  OK          equal bytes
  OK-RELOC    both sides are KSEG0 pointers and the region pointer equals
              the TRANSLATION of the base pointer (through the text map =
              regiondiff TSV base_va->region_va for every classified fn,
              plus the data symmap with intra-symbol offsets)
  PTR-UNRES   both sides look like pointers but the base target is not
              coverable by either map (reported, not counted as a delta)
  DELTA       anything else -- a REAL regional data change

Per-symbol sizes come from the sorted union of all known base symbol
addresses (configs/symbol_addrs.txt + the symmap), capped at 0x10000.

Output: regiondiff/AUDIT_DATA.txt (summary + per-symbol rows) and
regiondiff/data/<REGION>/<sym>.delta.txt dumps for changed symbols.

Usage: python regiondiff/tools/audit_data.py [REGION ...]   (default: all)
"""
import re, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
RD = ROOT / 'regiondiff'
BIN = Path(r'C:/Temp/nfs4-clean/Binaries')
DIFFDIR = BIN / 'NFS4-B-USA' / 'regiondiff'
BASE_EXE = BIN / 'NFS4-B-USA.EXE'
BASE_VA = 0x80010000
HDR = 0x800
CAP = 0x10000
REGIONS = ['NFS4-R-AU','NFS4-R-FR-DE','NFS4-R-JPN','NFS4-R-UK-ES-IT','NFS4-R-UK-SW','NFS4-R-USA']

def in_file(img, addr, n=1):
    off = addr - BASE_VA + HDR
    return 0 <= off and off + n <= len(img)

def rd(img, addr, n):
    off = addr - BASE_VA + HDR
    return img[off:off+n]

def load_symmap(region):
    m = {}
    p = RD / 'oracles' / region / 'symmap.tsv'
    for ln in p.read_text().splitlines()[1:]:
        f = ln.split('\t')
        if len(f) >= 3 and int(f[1], 16):
            m[f[0]] = (int(f[1], 16), int(f[2], 16))
    return m

def load_textmap(region):
    t = {}
    for ln in (DIFFDIR / (region + '.tsv')).read_text().splitlines()[1:]:
        f = ln.split('\t')
        if len(f) >= 3 and f[0] in ('IDENTICAL','RELOC','LO16','CHANGED') and f[1] and f[2]:
            t[int(f[1],16)] = int(f[2],16)
    return t

def base_sizes(symmap):
    addrs = set(b for b, r in symmap.values())
    p = ROOT / 'configs' / 'symbol_addrs.txt'
    for ln in p.read_text().splitlines():
        m = re.match(r'^\w+\s*=\s*0x([0-9A-Fa-f]+)\s*;', ln.strip())
        if m:
            addrs.add(int(m.group(1), 16))
    srt = sorted(addrs)
    nxt = {a: srt[i+1] if i+1 < len(srt) else a + CAP for i, a in enumerate(srt)}
    return nxt

def main():
    want = sys.argv[1:] or REGIONS
    want = ['NFS4-R-' + w.upper() if not w.upper().startswith('NFS4') else w.upper() for w in want]
    base_img = BASE_EXE.read_bytes()
    report = []
    for region in want:
        rimg = (BIN / (region + '.EXE')).read_bytes()
        symmap = load_symmap(region)
        textmap = load_textmap(region)
        nxt = base_sizes(symmap)
        # data-map for intra-symbol pointer translation
        dsorted = sorted((b, r, min(nxt.get(b, b+CAP)-b, CAP)) for b, r in symmap.values())
        import bisect
        dkeys = [b for b, r, sz in dsorted]
        def xlat(p):
            if p in textmap:
                return textmap[p]
            i = bisect.bisect_right(dkeys, p) - 1
            if i >= 0:
                b, r, sz = dsorted[i]
                if p - b < sz:
                    return r + (p - b)
            return None
        (RD / 'data' / region).mkdir(parents=True, exist_ok=True)
        # exclude TEXT symbols: address-taken functions reach the symmap via
        # %hi/%lo fn-pointer sites; their bodies are code, not data.
        funcvas = set(textmap.keys())
        for ln in (ROOT / 'configs' / 'symbol_addrs.txt').read_text().splitlines():
            m = re.match(r'^\w+\s*=\s*0x([0-9A-Fa-f]+)\s*;.*type:func', ln.strip())
            if m:
                funcvas.add(int(m.group(1), 16))
        changed = []
        skipped = 0
        rsorted = sorted(r for b, r in symmap.values())
        def region_gap(r):
            i = bisect.bisect_right(rsorted, r)
            return (rsorted[i] - r) if i < len(rsorted) else CAP
        for sym, (baddr, raddr) in sorted(symmap.items()):
            if baddr in funcvas:
                skipped += 1
                continue
            # cap by BOTH sides' next-symbol gaps -- a base-only gap over-runs
            # into differently-laid-out region neighbors (ASCII noise class)
            size = min(nxt.get(baddr, baddr + CAP) - baddr, region_gap(raddr), CAP)
            size -= size % 4
            if size <= 0 or not in_file(base_img, baddr, size) or not in_file(rimg, raddr, size):
                skipped += 1
                continue
            bb, rb = rd(base_img, baddr, size), rd(rimg, raddr, size)
            if bb == rb:
                continue
            deltas, unres = [], 0
            for i in range(0, size, 4):
                bw = int.from_bytes(bb[i:i+4], 'little')
                rw = int.from_bytes(rb[i:i+4], 'little')
                if bw == rw:
                    continue
                bp = 0x80010000 <= bw < 0x80200000
                rp = 0x80010000 <= rw < 0x80200000
                if bp and rp:
                    t = xlat(bw)
                    if t == rw:
                        continue                    # OK-RELOC
                    if t is None:
                        unres += 1; continue        # PTR-UNRES
                deltas.append((i, bw, rw))
            if deltas:
                changed.append((sym, baddr, raddr, size, deltas, unres))
        report.append(f'== {region}: {len(symmap)} mapped symbols, {skipped} skipped '
                      f'(BSS/out-of-file), CHANGED-DATA: {len(changed)}')
        for sym, baddr, raddr, size, deltas, unres in changed:
            report.append(f'  {sym}  (base {baddr:08X} -> {raddr:08X}, {size}B, '
                          f'{len(deltas)} delta words{", %d unres-ptr" % unres if unres else ""})')
            dump = [f'{sym}  base {baddr:08X} -> {region} {raddr:08X}  size {size}']
            for i, bw, rw in deltas:
                dump.append(f'  +{i:#06x}: base {bw:08x}  region {rw:08x}')
            (RD / 'data' / region / (re.sub(r"[^\w]", "_", sym)[:80] + '.delta.txt')
             ).write_text('\n'.join(dump) + '\n', newline='\n')
    out = RD / 'AUDIT_DATA.txt'
    out.write_text('\n'.join(report) + '\n', newline='\n')
    for ln in report:
        if ln.startswith('== '):
            print(ln)
    print('->', out)

if __name__ == '__main__':
    main()
