#!/usr/bin/env python3
"""gen_symmap.py -- derive a PER-REGION data-symbol address map from the
linked regional images, using the base oracle's own relocation markers.

For every base fn with an equal-size regional twin (IDENTICAL/RELOC/LO16
classes), the base oracle .s says which instruction fields are %hi(SYM) /
%lo(SYM) / %gp_rel(SYM).  Reading the REGION's linked words at those same
indices solves SYM's address in that region's layout:

    addr = (hi_imm << 16) + sign16(lo_imm)          (hi/lo pair, same SYM)
    addr = region_gp + sign16(imm)                  (%gp_rel site)

Consensus across all sites (majority vote) gives regiondiff/oracles/
<REGION>/symmap.tsv: symbol, base_addr, region_addr, sites, votes.
This is the missing piece for byte-authority (brdist-R) on regional rows
and for a future regional DATA audit.

Usage: python regiondiff/tools/gen_symmap.py [REGION ...]   (default: all)
"""
import re, sys, collections
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
RD = ROOT / 'regiondiff'
BIN = Path(r'C:/Temp/nfs4-clean/Binaries')
DIFFDIR = BIN / 'NFS4-B-USA' / 'regiondiff'
BASE_EXE = BIN / 'NFS4-B-USA.EXE'
BASE_VA = 0x80010000
HDR = 0x800
REGIONS = ['NFS4-R-AU','NFS4-R-FR-DE','NFS4-R-JPN','NFS4-R-UK-ES-IT','NFS4-R-UK-SW','NFS4-R-USA']

INS = re.compile(r'^\s*/\* [0-9A-Fa-f]+ ([0-9A-Fa-f]{8}) ([0-9A-Fa-f]{8}) \*/\s+(\S+)\s*(.*)$')
SYM = re.compile(r'%(hi|lo|gp_rel)\(([A-Za-z_][\w]*)')

def sign16(v):
    return v - 0x10000 if v >= 0x8000 else v

_oracle_cache = {}
def oracle_sites(name):
    """[(idx, kind, sym)] per instruction row of the base oracle, or None."""
    if name in _oracle_cache:
        return _oracle_cache[name]
    fname = re.sub(r'[^\w]', '_', name)[:80] + '.s'
    p = None
    for seg in ('main', 'front'):
        c = ROOT / 'asm' / 'nonmatchings' / seg / fname
        if c.exists() and c.name in {e.name for e in c.parent.iterdir()}:
            p = c; break
    if p is None:
        _oracle_cache[name] = None
        return None
    rows = []
    idx = 0
    for ln in p.read_text(errors='replace').splitlines():
        if ln.strip().startswith('endlabel'):
            break
        m = INS.match(ln)
        if not m:
            continue
        sm = SYM.search(m.group(4))
        if sm:
            rows.append((idx, sm.group(1), sm.group(2)))
        idx += 1
    _oracle_cache[name] = (rows, idx)
    return _oracle_cache[name]

def words_of(img, va, n):
    off = va - BASE_VA + HDR
    return [int.from_bytes(img[off+4*i:off+4*i+4], 'little') for i in range(n)]

def find_gp(img):
    """entry-code `lui gp,hi; addiu gp,gp,lo` — scan the first 0x4000 words."""
    ws = words_of(img, BASE_VA, 0x40000)
    hi = None
    for w in ws:
        if (w >> 16) == 0x3C1C:          # lui $gp
            hi = (w & 0xFFFF) << 16
        elif hi is not None and (w >> 16) == 0x279C:   # addiu $gp,$gp
            return hi + sign16(w & 0xFFFF)
    return None

def main():
    want = sys.argv[1:] or REGIONS
    want = ['NFS4-R-' + w.upper() if not w.upper().startswith('NFS4') else w.upper() for w in want]
    for region in want:
        rimg = (BIN / (region + '.EXE')).read_bytes()
        gp = find_gp(rimg)
        base_img = BASE_EXE.read_bytes()
        base_gp = find_gp(base_img)
        votes = collections.defaultdict(collections.Counter)   # sym -> Counter(addr)
        basev = collections.defaultdict(collections.Counter)
        rows = 0
        for ln in (DIFFDIR / (region + '.tsv')).read_text().splitlines()[1:]:
            f = ln.split('\t')
            if len(f) < 6 or f[0] not in ('IDENTICAL', 'RELOC', 'LO16') or not f[3]:
                continue
            bva, rva, name, wb, wr = int(f[1],16), int(f[2],16), f[3], int(f[4]), int(f[5])
            if wb != wr:
                continue
            o = oracle_sites(name)
            if o is None or o[1] != wb:
                continue
            sites, _n = o
            rw = words_of(rimg, rva, wb)
            bw = words_of(base_img, bva, wb)
            rows += 1
            # pair %hi/%lo by symbol name within the fn (nearest lo after hi)
            his = {}
            for idx, kind, sym in sites:
                if kind == 'gp_rel':
                    if gp:      votes[sym][gp + sign16(rw[idx] & 0xFFFF)] += 1
                    if base_gp: basev[sym][base_gp + sign16(bw[idx] & 0xFFFF)] += 1
                elif kind == 'hi':
                    his.setdefault(sym, []).append(idx)
                elif kind == 'lo' and sym in his and his[sym]:
                    hidx = his[sym][-1]
                    votes[sym][((rw[hidx] & 0xFFFF) << 16) + sign16(rw[idx] & 0xFFFF)] += 1
                    basev[sym][((bw[hidx] & 0xFFFF) << 16) + sign16(bw[idx] & 0xFFFF)] += 1
        out = RD / 'oracles' / region / 'symmap.tsv'
        with open(out, 'w', newline='\n') as fh:
            fh.write('symbol\tbase_addr\tregion_addr\tvotes\ttotal_sites\n')
            n = 0
            for sym in sorted(votes):
                (addr, cnt), = [votes[sym].most_common(1)[0]]
                baddr = basev[sym].most_common(1)[0][0] if basev[sym] else 0
                fh.write(f'{sym}\t{baddr:08X}\t{addr:08X}\t{cnt}\t{sum(votes[sym].values())}\n')
                n += 1
        amb = sum(1 for s in votes if len(votes[s]) > 1)
        gtxt = f'{gp:#x}' if gp else 'NONE'
        print(f'{region}: gp={gtxt} rows={rows} symbols={n} ambiguous={amb} -> {out}')

if __name__ == '__main__':
    main()
