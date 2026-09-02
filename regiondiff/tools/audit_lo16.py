#!/usr/bin/env python3
"""audit_lo16.py -- find REAL code deltas hiding in the LO16/RELOC classes.

regiondiff.py's LOOSE fingerprint masks ALL imm16 fields, so a regional
delta that changes ONLY displacements/constants (e.g. a struct-field shift
-- W84-R14's AudioMus_RefreshStatus) classifies as LO16 "relocation-only"
and never reaches the work plan.

This audit re-checks every LO16 and RELOC row with a PRECISE mask derived
from the BASE ORACLE's own relocation markers (asm/nonmatchings .s):
  %hi( / %lo( / %gp_rel(  -> mask imm16 of that instruction
  jal / j                 -> mask target26
  .word data rows         -> mask fully (may hold addresses)
  everything else         -> compared EXACTLY (opcodes, regs, branch
                             offsets, and every genuine constant)
Any surviving word difference = a real code delta -> the row is
HIDDEN-CHANGED and belongs in the reconstruction plan.

Usage: python regiondiff/tools/audit_lo16.py [REGION ...]   (default: all)
"""
import re, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
BIN = Path(r'C:/Temp/nfs4-clean/Binaries')
DIFFDIR = BIN / 'NFS4-B-USA' / 'regiondiff'
BASE_EXE = BIN / 'NFS4-B-USA.EXE'
BASE_VA = 0x80010000
HDR = 0x800
REGIONS = ['NFS4-R-AU','NFS4-R-FR-DE','NFS4-R-JPN','NFS4-R-UK-ES-IT','NFS4-R-UK-SW','NFS4-R-USA']

INS = re.compile(r'^\s*/\* [0-9A-Fa-f]+ ([0-9A-Fa-f]{8}) ([0-9A-Fa-f]{8}) \*/\s+(\S+)\s*(.*)$')

def words_of(img, va, n):
    off = va - BASE_VA + HDR
    return [int.from_bytes(img[off+4*i:off+4*i+4], 'little') for i in range(n)]

_oracle_cache = {}
def oracle_masks(name):
    """[mask per instruction] from the base oracle .s, or None."""
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
    masks = []
    for ln in p.read_text(errors='replace').splitlines():
        s = ln.strip()
        if s.startswith('endlabel'):
            break
        m = INS.match(ln)
        if not m:
            continue
        mnem, ops = m.group(3), m.group(4)
        if mnem == '.word':
            masks.append(0xFFFFFFFF)
        elif mnem in ('jal', 'j'):
            masks.append(0x03FFFFFF)
        elif '%hi(' in ops or '%lo(' in ops or '%gp_rel(' in ops:
            masks.append(0x0000FFFF)
        else:
            masks.append(0)
    _oracle_cache[name] = masks
    return masks

def main():
    want = sys.argv[1:] or REGIONS
    want = ['NFS4-R-' + w.upper() if not w.upper().startswith('NFS4') else w.upper() for w in want]
    base_img = BASE_EXE.read_bytes()
    grand = {}
    for region in want:
        exe = BIN / (region + '.EXE')
        rimg = exe.read_bytes()
        hidden, skipped, checked = [], 0, 0
        for ln in (DIFFDIR / (region + '.tsv')).read_text().splitlines()[1:]:
            f = ln.split('\t')
            if len(f) < 6 or f[0] not in ('LO16', 'RELOC') or not f[3]:
                continue
            cls, bva, rva, name, wb, wr = f[0], int(f[1],16), int(f[2],16), f[3], int(f[4]), int(f[5])
            if wb != wr:
                skipped += 1; continue
            masks = oracle_masks(name)
            if masks is None or len(masks) != wb:
                skipped += 1; continue
            bw = words_of(base_img, bva, wb)
            rw = words_of(rimg, rva, wb)
            bad = [(i, bw[i], rw[i]) for i in range(wb)
                   if (bw[i] ^ rw[i]) & ~masks[i] & 0xFFFFFFFF]
            checked += 1
            if bad:
                hidden.append((name, cls, bva, rva, bad))
        print(f'== {region}: {checked} rows checked, {skipped} skipped '
              f'(size-mismatch/no-oracle), HIDDEN-CHANGED: {len(hidden)}')
        for name, cls, bva, rva, bad in hidden:
            print(f'  {name}  ({cls}, base {bva:08X} -> {rva:08X}, {len(bad)} words)')
            for i, b, r in bad[:4]:
                print(f'      insn {i}: base {b:08x}  region {r:08x}')
            grand.setdefault(name, []).append(region.replace('NFS4-R-',''))
    print('\n== UNION of hidden-changed functions:', len(grand))
    for name, regs in sorted(grand.items()):
        print(f'  {name}  [{"+".join(regs)}]')

if __name__ == '__main__':
    main()
