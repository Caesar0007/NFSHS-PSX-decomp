#!/usr/bin/env python
"""w47-a9 -- run the -G ladder (MODE B, oracle-direction) over many TUs.

For every module named on stdin / argv it gates the WHOLE TU at -G0/-G4/-G8
(the tree's own value is whatever build.py says; the ladder overrides it) and
prints one row:

    module                    G0        G4        G8     verdict

verdict = the -G value with the lowest total diff count, or '=' when the
ladder is flat (the module has no symbol in the 5..8 byte band, so -G is
UNDECIDABLE from codegen for it).

usage:  python scratch/w47_a9_gladder.py <mod> [<mod> ...]
        mod = objdiff unit name, e.g. eaclib/psx/eacpsxz/nfile
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SW = ROOT / 'scratch' / 'w47_a9_sweep.py'
FL = ROOT / 'scratch' / 'w47_a9_fnlist.py'


def tu_path(mod):
    for ext in ('.c', '.cpp'):
        p = ROOT / 'recon' / (mod + ext)
        if p.exists():
            return 'recon/' + mod + ext
    return None


def main():
    mods = sys.argv[1:]
    print('%-40s %8s %8s %8s   %s' % ('module', 'G0', 'G4', 'G8', 'verdict'))
    for mod in mods:
        tu = tu_path(mod)
        if tu is None:
            print('%-40s  (no recon TU)' % mod)
            continue
        fns = subprocess.run([sys.executable, str(FL), mod],
                             capture_output=True, text=True,
                             cwd=str(ROOT)).stdout.strip()
        if not fns:
            print('%-40s  (no src scaffolding)' % mod)
            continue
        r = subprocess.run([sys.executable, str(SW), tu, fns],
                           capture_output=True, text=True, cwd=str(ROOT),
                           timeout=3000)
        tot = {}
        for ln in r.stdout.splitlines():
            m = re.match(r'^(G\d+)\s+PASS\s+(\d+)/\s*(\d+)\s+total-diffs\s+(\d+)',
                         ln)
            if m:
                tot[m.group(1)] = ('%s/%s' % (m.group(2), m.group(3)),
                                   int(m.group(4)))
        if len(tot) < 3:
            print('%-40s  ERROR %s' % (mod, (r.stdout + r.stderr)[-160:]))
            continue
        best = min(tot, key=lambda k: tot[k][1])
        flat = len({v[1] for v in tot.values()}) == 1
        print('%-40s %8s %8s %8s   %s'
              % (mod,
                 '%s/%d' % (tot['G0'][0], tot['G0'][1]),
                 '%s/%d' % (tot['G4'][0], tot['G4'][1]),
                 '%s/%d' % (tot['G8'][0], tot['G8'][1]),
                 '=' if flat else best))
        sys.stdout.flush()


if __name__ == '__main__':
    main()
