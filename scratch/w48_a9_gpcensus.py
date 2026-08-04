#!/usr/bin/env python
"""w48-a9 -- per-syslib-object %gp_rel census over the ORACLE .s files.

w47-a7's frontend -G0 class rule was derived from "0 GPREL16 relocs across all
50 overlay objects".  The same discriminator applied per syslib object: for
every function of a module, look at its oracle `asm/nonmatchings/**/<fn>.s`
and count `%gp_rel(...)` occurrences.

An object with ZERO gp_rel in EVERY oracle function is a -G0 CANDIDATE
(necessary, not sufficient -- see the w47 caveat: it may simply own no small
symbol).  An object with gp_rel is definitively NOT -G0.

usage: python scratch/w48_a9_gpcensus.py <mod> [<mod> ...]
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
FL = ROOT / 'scratch' / 'w47_a9_fnlist.py'

sys.path.insert(0, str(ROOT / 'scratch'))
import importlib.util
_spec = importlib.util.spec_from_file_location('vfy', ROOT / 'scratch' / 'w47_a9_verify.py')


def oracle_path(fn):
    for seg in ('main', 'front'):
        p = ROOT / 'asm' / 'nonmatchings' / seg / (fn + '.s')
        if p.exists() and p.name in {e.name for e in p.parent.iterdir()}:
            return p
    # VA-suffixed fallback via symbol_addrs.txt
    txt = (ROOT / 'configs' / 'symbol_addrs.txt')
    return None


def main():
    print('%-34s %5s %6s %6s   %s' %
          ('module', 'fns', 'w/gprel', 'gprel', 'verdict'))
    for mod in sys.argv[1:]:
        fns = subprocess.run([sys.executable, str(FL), mod],
                             capture_output=True, text=True,
                             cwd=str(ROOT)).stdout.strip()
        if not fns:
            print('%-34s (no scaffolding)' % mod)
            continue
        n = ng = tot = miss = 0
        for fn in fns.split(','):
            p = oracle_path(fn)
            if p is None:
                miss += 1
                continue
            n += 1
            c = len(re.findall(r'%gp_rel', p.read_text(errors='replace')))
            if c:
                ng += 1
                tot += c
        print('%-34s %5d %6d %6d   %s%s'
              % (mod, n, ng, tot,
                 '-G0 CANDIDATE' if tot == 0 else 'NOT -G0',
                 ('  (%d oracle files missing)' % miss) if miss else ''))


if __name__ == '__main__':
    main()
