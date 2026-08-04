#!/usr/bin/env python
"""w48-a9 -- the `-mno-split-addresses` STRUCTURAL fingerprint census.

Methodology (reference_psx_cpp_reconstruction_methodology, §3.16 / w47-a10 rank 3):
`$at` is the ASSEMBLER's own address-macro scratch register.  cc1 never
allocates it.  So an `$at` appearing inside a retail function body means the
compiler emitted a MACRO (`la $r,sym` / `lw $r,sym` / `lw $r,sym($idx)`) and
the assembler expanded it -- which is exactly what `-mno-split-addresses`
produces.  With split addresses ON, cc1 lowers the address itself into a
`lui %hi / addiu %lo` pair using an ordinary allocated register and `$at`
never appears.

This is an ORACLE-side (retail bytes) discriminator, independent of any gate
fit, so it can promote a flag from "improves the score" to "identity".

usage: python scratch/w48_a9_atcensus.py <mod> [<mod> ...]
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
FL = ROOT / 'scratch' / 'w47_a9_fnlist.py'

# `$at` as an operand (not `$at` inside a comment).  spimdisasm prints $at.
AT = re.compile(r'\$at\b')


def oracle_path(fn):
    for seg in ('main', 'front'):
        p = ROOT / 'asm' / 'nonmatchings' / seg / (fn + '.s')
        if p.exists() and p.name in {e.name for e in p.parent.iterdir()}:
            return p
    return None


def main():
    print('%-34s %5s %6s %6s   %s' % ('module', 'fns', 'w/$at', '$at', 'fns with $at'))
    for mod in sys.argv[1:]:
        fns = subprocess.run([sys.executable, str(FL), mod],
                             capture_output=True, text=True,
                             cwd=str(ROOT)).stdout.strip()
        if not fns:
            print('%-34s (no scaffolding)' % mod)
            continue
        n = na = tot = 0
        hit = []
        for fn in fns.split(','):
            p = oracle_path(fn)
            if p is None:
                continue
            n += 1
            body = []
            for ln in p.read_text(errors='replace').splitlines():
                ln = re.sub(r'/\*.*?\*/', '', ln)
                body.append(ln.split('#')[0])
            c = len(AT.findall('\n'.join(body)))
            if c:
                na += 1
                tot += c
                hit.append('%s:%d' % (fn, c))
        print('%-34s %5d %6d %6d   %s' % (mod, n, na, tot, ' '.join(hit)[:90]))


if __name__ == '__main__':
    main()
