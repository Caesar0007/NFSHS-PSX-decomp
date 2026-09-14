#!/usr/bin/env python3
"""honest_measure.py -- the HONEST real-build byte match.

Compares the REAL linked image (build/gen_ld/recon_multdef-ok.elf, produced by
`gen_ld.py --link` -- a genuine ld link, NO per-function hybrid image surgery)
to rom/nfs4-f.exe, and splits every covered word by its SOURCE (from the linker
map):

  RECON  = build/recon/*.o        -- bytes OUR reconstructed C/C++ produced
  BLOB   = build/asm/data/*.s.o   -- raw retail data we have NOT reconstructed
                                     (trivially matches; NOT a real proof)
  OTHER  = anything else (headers, etc.)

The number that matters for "our code generates the retail binary" is the RECON
match rate.  BLOB matches are retail passthrough and are reported separately so
they never inflate the honest figure.
"""
import re, subprocess, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MIPS = Path(r'C:/Tools/mips-ps1/mips/bin')
OBJDUMP = str(MIPS / 'mipsel-none-elf-objdump.exe')
ELF = ROOT / 'build' / 'gen_ld' / 'recon_multdef-ok.elf'
MAP = ROOT / 'build' / 'gen_ld' / 'recon_multdef-ok.map'
LOAD = 0x80010000
FOFF = 0x800

def classify(src):
    if src.startswith('build/recon/'):
        return 'RECON'
    if src.startswith('build/asm/'):
        return 'BLOB'
    return 'OTHER'

def main():
    rom = (ROOT / 'rom' / 'nfs4-f.exe').read_bytes()[FOFF:]
    romend = LOAD + len(rom)
    # ---- source-owner intervals from the map ----
    owner = []      # (start_va, end_va, kind, src)
    for ln in MAP.read_text(errors='replace').splitlines():
        m = re.match(r'^ \.\S+\s+0x([0-9a-f]{8})\s+0x([0-9a-f]+)\s+(\S+\.o)$', ln)
        if m:
            a = int(m.group(1), 16); sz = int(m.group(2), 16)
            src = m.group(3).replace('\\', '/')
            i = src.find('build/')
            if i >= 0:
                src = src[i:]
            if sz:
                owner.append((a, a + sz, classify(src), src))
    owner.sort()
    import bisect
    starts = [o[0] for o in owner]
    def kind_of(va):
        i = bisect.bisect_right(starts, va) - 1
        if i >= 0 and owner[i][0] <= va < owner[i][1]:
            return owner[i][2]
        return None
    # ---- placed image by VA ----
    img = bytearray(len(rom)); cov = bytearray(len(rom))
    for ln in subprocess.run([OBJDUMP, '-s', str(ELF)], capture_output=True, text=True).stdout.splitlines():
        m = re.match(r'^ ([0-9a-f]{8}) ((?:[0-9a-f]{2,8} ?){1,4})', ln)
        if not m:
            continue
        va = int(m.group(1), 16); d = bytes.fromhex(m.group(2).replace(' ', ''))
        if va < LOAD or va + len(d) > romend:
            continue
        off = va - LOAD
        img[off:off+len(d)] = d
        for i in range(len(d)):
            cov[off+i] = 1
    # ---- tally per kind ----
    from collections import Counter
    tot = Counter(); ident = Counter()
    uncov = 0
    for off in range(0, len(rom) - 3, 4):
        va = LOAD + off
        if not (cov[off] and cov[off+1] and cov[off+2] and cov[off+3]):
            uncov += 1
            continue
        k = kind_of(va) or 'OTHER'
        tot[k] += 1
        if img[off:off+4] == rom[off:off+4]:
            ident[k] += 1
    grand = sum(tot.values())
    print(f'REAL linked image vs rom/nfs4-f.exe (no hybrid, no image surgery)')
    print(f'  total image words   : {len(rom)//4}')
    print(f'  covered words       : {grand}')
    print(f'  uncovered words     : {uncov}')
    print()
    for k in ('RECON', 'BLOB', 'OTHER'):
        t = tot[k]; i = ident[k]
        if t:
            print(f'  {k:6s}: {i:7d}/{t:7d} identical ({100.0*i/t:.3f}%)  diff {t-i}')
    rt, ri = tot['RECON'], ident['RECON']
    print()
    print(f'>>> HONEST reconstruction match (RECON only): '
          f'{ri}/{rt} = {100.0*ri/rt:.3f}%  ({rt-ri} diff words)')
    print(f'    (BLOB {ident["BLOB"]}/{tot["BLOB"]} = retail passthrough, excluded)')

if __name__ == '__main__':
    main()
