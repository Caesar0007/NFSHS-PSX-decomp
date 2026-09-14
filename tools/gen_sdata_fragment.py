#!/usr/bin/env python3
"""gen_sdata_fragment.py -- regenerate the ordered .sdata fragment from the SYM.

The hand-tuned nfs4_recon.sdata_8013C54C.ldfrag tiles 0x8013C54C..0x8013DD7B
sequentially with recon-TU .sdata sections + residual blob pieces, sized for the
CURRENT -G mix.  Changing a member TU's -G changes its .sdata size and shifts
everything after (breaking curated owners like TrackSpec_*).  This regenerates
the tiling from GROUND TRUTH:

  * every recon .o's .sdata* section is placed at its EXACT retail base -- from
    the SYM (tools/sdata_addr_oracle.exact_of): each small-data global is named
    at its retail VA, so base = consensus(retail_VA - in-section offset);
  * gaps between owned sections (genuinely un-reconstructed small data) are
    filled by residual blob .s files cut from rom/nfs4-f.exe.

Because every section is anchored to its own retail address, the tiling is
robust to any TU's -G change: growing a TU's .sdata just consumes the adjacent
residual, and the addresses of all other sections are unchanged.

  python tools/gen_sdata_fragment.py            # regenerate + report coverage
  python tools/gen_sdata_fragment.py --check     # reproduce-only: do NOT write,
                                                 # just report vs the current file
"""
import re, subprocess, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
IMG = (ROOT / 'rom' / 'nfs4-f.exe').read_bytes()
FOFF, LOAD = 0x800, 0x80010000
LO, HI = 0x8013C54C, 0x8013DD7C          # .sdata region [LO, HI)
FRAG = ROOT / 'linkers' / 'nfs4_recon.sdata_8013C54C.ldfrag'
BLOBDIR = ROOT / 'asm' / 'data'
BLOBPREFIX = 'sdata_regen_'

# exact address oracle
spec_path = ROOT / 'tools' / 'sdata_addr_oracle.py'
import importlib.util
_s = importlib.util.spec_from_file_location('sdo', spec_path)
oracle = importlib.util.module_from_spec(_s); _s.loader.exec_module(oracle)
EXACT = oracle.load_exact()

def run(*a): return subprocess.run(a, capture_output=True, text=True).stdout

def sections(obj):
    """[(name,size)] of .sdata* sections (objdump -h), size>0."""
    out = []
    for ln in run(OBJD, '-h', str(obj)).splitlines():
        m = re.match(r'^\s*\d+\s+(\.sdata[\w.]*)\s+([0-9a-f]{8})\s', ln)
        if m and int(m.group(2), 16) > 0:
            out.append((m.group(1), int(m.group(2), 16)))
    return out

def sec_base(obj, sec):
    b, agree, total = oracle.obj_section_base(obj, sec, EXACT)
    return (b, agree, total)

def imgbytes(a, b):
    return IMG[a - LOAD + FOFF: b - LOAD + FOFF]

def main():
    srcs = [*Path(ROOT / 'recon').rglob('*.cpp'), *Path(ROOT / 'recon').rglob('*.c')]
    objs = [ROOT / 'build' / (str(s.relative_to(ROOT)) + '.o') for s in srcs]
    objs = [o for o in objs if o.is_file()]
    owned = []          # (base, end, rel, sec)
    unanchored = []
    for o in sorted(objs):
        rel = o.relative_to(ROOT).as_posix()
        for sec, sz in sections(o):
            b, agree, total = sec_base(o, sec)
            if b is None or agree != total or total == 0:
                if sz:
                    unanchored.append((rel, sec, sz, b, agree, total))
                continue
            if LO <= b and b + sz <= HI:
                owned.append((b, b + sz, rel, sec))
    owned.sort()
    # overlap check
    overlaps = [(a, c) for a, c in zip(owned, owned[1:]) if c[0] < a[1]]
    # walk region, build entries + residual gaps
    entries = []        # ('recon', rel, sec) | ('blob', a, b)
    cur = LO
    for base, end, rel, sec in owned:
        if base < cur:
            continue    # (overlap already reported)
        if base > cur:
            entries.append(('blob', cur, base))
        entries.append(('recon', rel, sec))
        cur = end
    if cur < HI:
        entries.append(('blob', cur, HI))
    n_recon = sum(1 for e in entries if e[0] == 'recon')
    n_blob = sum(1 for e in entries if e[0] == 'blob')
    blob_bytes = sum(b - a for k, a, b in ((e[0], e[1], e[2]) for e in entries if e[0] == 'blob'))
    print(f'region {LO:#x}..{HI:#x} ({HI-LO} B): {n_recon} recon sections, '
          f'{n_blob} residual gaps ({blob_bytes} B residual)')
    print(f'overlaps: {len(overlaps)}   unanchored .sdata sections: {len(unanchored)}')
    for rel, sec, sz, b, ag, to in unanchored[:20]:
        print(f'  UNANCHORED {rel} {sec} sz={sz} base={hex(b) if b else None} agree={ag}/{to}')
    for a, c in overlaps[:10]:
        print(f'  OVERLAP {a[2]}{a[3]} {a[0]:#x}..{a[1]:#x} vs {c[2]}{c[3]} {c[0]:#x}..{c[1]:#x}')
    if '--check' in sys.argv:
        print('[check] not writing (reproduce-only).')
        return overlaps, unanchored, entries
    return overlaps, unanchored, entries

if __name__ == '__main__':
    main()
