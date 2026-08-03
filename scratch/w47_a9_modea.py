#!/usr/bin/env python
"""w47-a9 -- MODE A batch: near-oracle LAB FIDELITY per TU, and the
FLAG-SEMANTICS FAITHFULNESS test.

fidelity(TU)      = #functions where  cc1-elf[near flags]  reproduces
                    CC1PSX[build flags]  instruction-for-instruction.
                    A TU with low fidelity is a TU the lab may NOT speak about.

faithful(TU,flag) = does the lab react to `flag` on the SAME functions the real
                    CC1PSX reacts on?  Computed as
                        Rset = {fn : CC1PSX(base) != CC1PSX(base+flag)}
                        Cset = {fn : cc1elf(near) != cc1elf(near+flag)}
                    and reported as |Rset & Cset| / |Rset| / |Cset|.
                    Faithful (Rset == Cset) => a lab prediction about `flag`
                    on this TU is admissible evidence.

usage:
  python scratch/w47_a9_modea.py fidelity <mod> [<mod> ...]
  python scratch/w47_a9_modea.py faithful '<flag ...>' <mod> [<mod> ...]
"""
import importlib.util
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
_spec = importlib.util.spec_from_file_location(
    'fp', ROOT / 'scratch' / 'w47_a9_fp.py')
fp = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(fp)


def tu_path(mod):
    for ext in ('.c', '.cpp'):
        p = ROOT / 'recon' / (mod + ext)
        if p.exists():
            return p
    return None


def streams(exe, flags, i_file, tag):
    s, err = fp.compile_s(exe, flags, i_file, tag)
    if s is None:
        return None, err
    return {k: fp.norm(v) for k, v in fp.fns(s).items()}, err


def main():
    mode = sys.argv[1]
    if mode == 'fidelity':
        mods = sys.argv[2:]
        extra = None
    else:
        extra = sys.argv[2].split()
        mods = sys.argv[3:]

    if mode == 'fidelity':
        print('%-40s %7s %7s   %s' % ('module', 'ident', 'total', 'divergent fns'))
    else:
        print('%-40s %6s %6s %6s   %s'
              % ('module', 'real', 'lab', 'both', 'verdict'))

    for mod in mods:
        src = tu_path(mod)
        if src is None:
            print('%-40s (no recon TU)' % mod)
            continue
        cxx = src.suffix != '.c'
        ref_exe = 'psyqpp' if cxx else 'psyq'
        cand_exe = 'ecoffpp' if cxx else 'elf'
        ref_flags = fp.REF_FLAGS_CPP if cxx else fp.REF_FLAGS_C
        near_flags = fp.NEAR_CPP if cxx else fp.NEAR_C
        i_file = fp.preprocess(src, fp.SCRATCH / 'i' / (src.name + '.i'))

        R, rerr = streams(ref_exe, ref_flags, i_file, 'A_ref')
        C, cerr = streams(cand_exe, near_flags, i_file, 'A_cand')
        if R is None or C is None:
            print('%-40s COMPILE FAILED %s' % (mod, (rerr or cerr)[:120]))
            continue

        if mode == 'fidelity':
            bad = [k for k in sorted(R) if C.get(k) != R[k]]
            print('%-40s %7d %7d   %s'
                  % (mod, len(R) - len(bad), len(R), ','.join(bad)[:70]))
            sys.stdout.flush()
            continue

        R2, _ = streams(ref_exe, list(ref_flags) + extra, i_file, 'A_ref2')
        C2, _ = streams(cand_exe, list(near_flags) + extra, i_file, 'A_cand2')
        if R2 is None or C2 is None:
            print('%-40s FLAG REJECTED' % mod)
            continue
        Rset = {k for k in R if R2.get(k) != R[k]}
        Cset = {k for k in C if C2.get(k) != C[k]}
        both = Rset & Cset
        if not Rset and not Cset:
            v = 'flag INERT on this TU'
        elif Rset == Cset:
            v = 'FAITHFUL'
        else:
            v = 'PARTIAL (real-only %d, lab-only %d)' % (
                len(Rset - Cset), len(Cset - Rset))
        print('%-40s %6d %6d %6d   %s'
              % (mod, len(Rset), len(Cset), len(both), v))
        sys.stdout.flush()


if __name__ == '__main__':
    main()
