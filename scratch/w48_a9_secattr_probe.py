#!/usr/bin/env python
"""w48-a9 -- the SECTION-ATTRIBUTE vs -G0 RECONCILIATION probe.

a10 (w48, class 4) derives "syslib is a -G0 class" from the oracle census
(0 %gp_rel in 410 syslib fns + 263 positive absolute-4-byte-scalar sites).
My whole-TU -G0 ladder says -G0 COSTS +2726 diffs / 23 PASS regressions.

Both are true, and this probe shows why: 11 syslib recon TUs already emulate
-G0 PER SYMBOL with `__attribute__((section(".bss")))` / `.data`.  Measuring
-G0 on top of that hack answers the wrong question.  The right question is:

    with the per-symbol hack REMOVED, does -G0 reproduce it (or better)?

Variants gated per TU (source patched IN THIS WORKTREE, then RESTORED):
    A  attrs kept,     tree -G      = today's baseline
    B  attrs stripped, tree -G      = the hack's value (control)
    C  attrs stripped, -G0          = the honest flag identity
    D  attrs stripped, -G0 + nosplit

usage: python scratch/w48_a9_secattr_probe.py <mod> [<mod> ...]
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
AX = ROOT / 'scratch' / 'w48_a9_axis.py'
SECATTR = re.compile(r'\s*__attribute__\s*\(\(\s*section\s*\(\s*"[^"]*"\s*\)\s*\)\)')


def gate(mod, cfgs, tag):
    r = subprocess.run([sys.executable, str(AX), '--out',
                        'scratch/w48_a9/secattr_%s.json' % tag]
                       + sum([['--cfg', c] for c in cfgs], []) + [mod],
                       capture_output=True, text=True, cwd=str(ROOT))
    return r.stdout + r.stderr


def main():
    for mod in sys.argv[1:]:
        src = ROOT / 'recon' / (mod + '.c')
        orig = src.read_text(encoding='utf-8', newline='')
        n = len(SECATTR.findall(orig))
        print('### %s  (%d section attributes)' % (mod, n))
        print(gate(mod, ['A_attrs_G4::'], 'A').rstrip())
        try:
            src.write_text(SECATTR.sub('', orig), encoding='utf-8', newline='')
            print(gate(mod, ['B_noattrs_G4::', 'C_noattrs_G0:0:',
                             'D_noattrs_G0_nosplit:0:-mno-split-addresses',
                             'E_noattrs_G4_nosplit::-mno-split-addresses'],
                       'CD').rstrip())
        finally:
            src.write_text(orig, encoding='utf-8', newline='')
            assert src.read_text(encoding='utf-8', newline='') == orig
            print('   [source restored: %d bytes]' % len(orig))
        print()


if __name__ == '__main__':
    main()
