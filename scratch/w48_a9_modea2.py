#!/usr/bin/env python
"""w48-a9 -- MODE A' : lab fidelity for syslib TUs the LAB CANNOT COMPILE AS-IS.

11 syslib recon TUs use `__attribute__((section(".bss")))` on file statics (a
per-SYMBOL emulation of "keep this 4-byte object out of .sdata").  The real
CC1PSX accepts it; the rebuilt stock mips-elf/mips-ecoff cc1 rejects it
("section attributes are not supported for this target").

Mode A' removes the attribute from the PREPROCESSED input given to BOTH
compilers, so the comparison stays apples-to-apples and still answers the
question Mode A exists to answer: *does SN's patched CC1PSX diverge from stock
gcc-2.8.1 on these function bodies?*  What it does NOT answer is the exact
retail addressing form of those statics (they move to .sdata on both sides).
Every Mode-A' number is therefore labelled A', never A.

usage: python scratch/w48_a9_modea2.py <mod> [<mod> ...]
"""
import importlib.util
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
_spec = importlib.util.spec_from_file_location(
    'fp', ROOT / 'scratch' / 'w47_a9_fp.py')
fp = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(fp)

SECATTR = re.compile(r'__attribute__\s*\(\(\s*section\s*\(\s*"[^"]*"\s*\)\s*\)\)')


def tu_path(mod):
    for ext in ('.c', '.cpp'):
        p = ROOT / 'recon' / (mod + ext)
        if p.exists():
            return p
    return None


def main():
    print('%-34s %6s %6s   %s' % ('module', 'ident', 'total', 'divergent fns'))
    for mod in sys.argv[1:]:
        src = tu_path(mod)
        if src is None:
            print('%-34s (no TU)' % mod)
            continue
        d = fp.SCRATCH / 'a2' / mod.replace('/', '_')
        d.mkdir(parents=True, exist_ok=True)
        i0 = d / (src.stem + '.i')
        fp.preprocess(src, i0)
        txt = i0.read_text(encoding='utf-8', errors='replace', newline='')
        n = len(SECATTR.findall(txt))
        i0.write_text(SECATTR.sub('', txt), encoding='utf-8', newline='')
        ref, e1 = fp.compile_s('psyq', fp.REF_FLAGS_C, i0, mod.replace('/', '_') + '_ref')
        cand, e2 = fp.compile_s('elf', fp.NEAR_C, i0, mod.replace('/', '_') + '_cand')
        if ref is None or cand is None:
            print("%-34s COMPILE FAILED %s" % (mod, ((e1 or '') + (e2 or ''))[:100]))
            continue
        rows, same, tot = fp.compare(ref, cand)
        div = [k for k, v, _ in rows if v != 'SAME']
        print('%-34s %6d %6d   %s   [A\' -- %d section attrs stripped]'
              % (mod, same, tot, ','.join(div)[:60], n))


if __name__ == '__main__':
    main()
