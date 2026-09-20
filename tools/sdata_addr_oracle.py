#!/usr/bin/env python3
"""sdata_addr_oracle.py -- EXACT per-object data-section retail addresses.

The `.sdata`-address unlock: the MND SYM (dumpsym of retail, nfs4-f-v3.txt) names
every .data/.sdata/.bss/.sbss global at its exact retail VA -- symbols that
NFS4.MAP lacks (Texture_CarColor, SceneLoaded, BWorld_gChunkCount, ...).  For
each recon TU this reads its data-section symbols (objdump -t), looks each up in
the SYM, and reports the section BASE by consensus (retail_VA - in-section
offset).  This is the CONTENT-INDEPENDENT, EXACT anchor that replaces
gen_rodata_extra's weak (mostly-zero) .sdata byte-validation which mis-placed
windows onto neighbours (e.g. texture .sdata onto SceneLoaded's 0x8013c758 --
its real base is 0x8013dad8).

It is the foundation for:
  (a) exact .sdata/.data/.bss placement of any -G8 TU, and
  (b) regenerating the ordered .sdata fragment (nfs4_recon.sdata_8013C54C.ldfrag)
      to the -G8 layout -- the remaining step to widen the retail -G8 flag past
      the TUs whose .sdata currently lives in that hand-curated fragment
      (changing their -G shifts the fragment and breaks curated owners like
      TrackSpec_*).

usage:
    python tools/sdata_addr_oracle.py [--json out.json] [--sec .sdata]
    python tools/sdata_addr_oracle.py --obj build/recon/game/psx/texture.cpp.o
"""
import json, re, subprocess, sys
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
SYM = Path(r'C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt')
MAP = ROOT / 'rom' / 'NFS4.MAP'   # retail link map off the disc; not committed
DATA_SECS = ('.data', '.sdata', '.bss', '.sbss', '.rodata')

def load_exact():
    """name -> exact retail VA, from the SYM (primary) then NFS4.MAP."""
    va = {}
    if SYM.exists():
        rx = re.compile(r'\$([0-9a-f]{8}) \d+ (\S+)')
        for ln in SYM.read_text(errors='replace').splitlines():
            m = rx.search(ln)
            if m:
                va.setdefault(m.group(2), int(m.group(1), 16))
    for ln in MAP.read_text(errors='replace').splitlines():
        m = re.match(r'^ ([0-9A-F]{8}) (\S+)\s*$', ln)
        if m:
            va.setdefault(m.group(2), int(m.group(1), 16))
    return va

NAMEVA = re.compile(r'^(?:D|DAT|lbl)_([0-9A-Fa-f]{8})$')

def obj_section_base(obj, sec, exact):
    """(base, agree, total) for `sec` in `obj` -- consensus of retail_VA - off
    over that section's symbols with an EXACT VA.  agree==total => unanimous."""
    votes = Counter(); total = 0
    st = subprocess.run([OBJD, '-t', str(obj)], capture_output=True, text=True).stdout
    for ln in st.splitlines():
        m = re.match(r'^([0-9a-f]{8})\s+.*?\s' + re.escape(sec) +
                     r'\s+[0-9a-f]{8}\s+(\S+)$', ln)
        if not m:
            continue
        nm = m.group(2); off = int(m.group(1), 16)
        a = exact.get(nm)
        if a is None:
            mm = NAMEVA.match(nm)
            a = int(mm.group(1), 16) if mm else None
        if a is not None:
            votes[a - off] += 1; total += 1
    if not votes:
        return None, 0, 0
    b, n = votes.most_common(1)[0]
    return b, n, total

def main():
    exact = load_exact()
    want_sec = None
    if '--sec' in sys.argv:
        want_sec = sys.argv[sys.argv.index('--sec') + 1]
    if '--obj' in sys.argv:
        objs = [Path(sys.argv[sys.argv.index('--obj') + 1])]
    else:
        srcs = [*Path(ROOT / 'recon').rglob('*.cpp'), *Path(ROOT / 'recon').rglob('*.c')]
        objs = [ROOT / 'build' / (str(s.relative_to(ROOT)) + '.o') for s in srcs]
        objs = [o for o in objs if o.is_file()]
    out = {}
    secs = (want_sec,) if want_sec else DATA_SECS
    for o in sorted(objs):
        rel = o.relative_to(ROOT).as_posix() if o.is_absolute() else str(o)
        for sec in secs:
            b, agree, total = obj_section_base(o, sec, exact)
            if b is None:
                continue
            out.setdefault(rel, {})[sec] = {
                'base': b, 'agree': agree, 'total': total,
                'unanimous': agree == total}
    if '--json' in sys.argv:
        p = sys.argv[sys.argv.index('--json') + 1]
        Path(p).write_text(json.dumps(out, indent=1) + '\n')
        print(f'{len(out)} objects -> {p}')
    else:
        for rel, d in sorted(out.items()):
            for sec, r in d.items():
                flag = 'exact' if r['unanimous'] else f"{r['agree']}/{r['total']}"
                print(f"  {r['base']:#010x}  {sec:7s} [{flag:>7s}]  {rel.split('build/recon/')[-1]}")
        print(f'{len(out)} objects with SYM-anchored data-section bases '
              f'({len(exact)} exact symbols loaded)')

if __name__ == '__main__':
    main()
