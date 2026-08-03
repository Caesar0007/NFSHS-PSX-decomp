#!/usr/bin/env python
"""w47-a9 -- list the gateable function symbols of a TU.

Source of truth = the `src/**/<mod>.c` INCLUDE_ASM scaffolding (one line per
retail function of that object), i.e. exactly the set that has an oracle .s.
Prints the comma-joined list verify_asm expects.

usage: python scratch/w47_a9_fnlist.py <src-rel-path | objdiff-unit-name>
       e.g.  game/psx/force        ->  src/game/psx/force.c
"""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def main():
    a = sys.argv[1]
    p = Path(a)
    if not p.exists():
        p = ROOT / 'src' / (a + '.c')
    if not p.exists():
        sys.exit('no src scaffolding: %s' % p)
    txt = p.read_text(encoding='utf-8', errors='replace', newline='')
    names = re.findall(r'INCLUDE_ASM\([^,]+,\s*([A-Za-z_$][\w$.]*)\s*\)', txt)
    seen, out = set(), []
    for n in names:
        if n not in seen:
            seen.add(n)
            out.append(n)
    print(','.join(out))


if __name__ == '__main__':
    main()
