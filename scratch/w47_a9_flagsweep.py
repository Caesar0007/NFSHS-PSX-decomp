#!/usr/bin/env python
"""w47-a9 -- MODE B flag sweep (oracle-direction), whole-TU, gate numbers.

For each module: gate the whole TU at the tree's own flags (BASE), then once
per candidate flag, and print the TOTAL-DIFF delta and the PASS delta.

    module                      base            flag              dD   dPASS

Only flags with a NON-ZERO effect are printed (a zero row means the flag is
inert on that TU -- itself a receipt, counted in the trailer).

The candidate list is a10's w47 ranked table with every proven NO-OP removed
(-funsigned-char, -mgpopt, -fno-defer-pop, -mgas, -msplit-addresses: all
CC1PSX defaults / inert on MIPS).

usage:
  python scratch/w47_a9_flagsweep.py [--cc1 PATH] [--flags f1,f2] <mod> ...
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
VERIFY = ROOT / 'scratch' / 'w47_a9_verify.py'
FL = ROOT / 'scratch' / 'w47_a9_fnlist.py'

FLAGS = [
    ('sgnchar',   '-fsigned-char'),
    ('nosplit',   '-mno-split-addresses'),
    ('inlinefn',  '-finline-functions'),
    ('framep',    '-fno-omit-frame-pointer'),
    ('mmemcpy',   '-mmemcpy'),
    ('regstruct', '-freg-struct-return'),
    ('nosched1',  '-fno-schedule-insns'),
    ('nosched2',  '-fno-schedule-insns2'),
    ('nodelay',   '-fno-delayed-branch'),
    ('nostrred',  '-fno-strength-reduce'),
    ('shortenum', '-fshort-enums'),
    ('nocommon',  '-fno-common'),
    ('unroll',    '-funroll-loops'),
    ('wstrings',  '-fwritable-strings'),
    ('nobuiltin', '-fno-builtin'),
    ('nocallsave', '-fno-caller-saves'),
    ('nocsejmp',  '-fno-cse-follow-jumps'),
    ('noexpens',  '-fno-expensive-optimizations'),
]

LINE = re.compile(r'^\s{2}(\S+): (PASS \((\d+) insns\)|FAIL (\d+) diffs'
                  r' \(ours (\d+) / oracle (\d+)\)|NO ORACLE|NOT IN OBJECT)')


def gate(tu, fns, extra, cc1, env0):
    import os
    env = dict(os.environ)
    env.pop('NFS4_A9_CC1FLAGS', None)
    env.pop('NFS4_A9_CC1', None)
    if extra:
        env['NFS4_A9_CC1FLAGS'] = extra
    if cc1:
        env['NFS4_A9_CC1'] = cc1
    try:
        r = subprocess.run([sys.executable, str(VERIFY), tu, fns],
                           capture_output=True, text=True, env=env,
                           cwd=str(ROOT), timeout=900)
    except subprocess.TimeoutExpired:
        return None
    res = {}
    for ln in (r.stdout + r.stderr).splitlines():
        m = LINE.match(ln)
        if not m:
            continue
        res[m.group(1)] = 0 if m.group(2).startswith('PASS') else (
            int(m.group(4)) if m.group(2).startswith('FAIL') else None)
    return res or None


def tot(res):
    return (sum(1 for v in res.values() if v == 0),
            sum(v for v in res.values() if isinstance(v, int)))


def main():
    args = sys.argv[1:]
    cc1 = None
    flags = FLAGS
    while args and args[0].startswith('--'):
        if args[0] == '--cc1':
            cc1 = args[1]
            args = args[2:]
        elif args[0] == '--flags':
            want = args[1].split(',')
            flags = [f for f in FLAGS if f[0] in want]
            args = args[2:]
        else:
            args = args[1:]
    print('%-38s %-11s %-24s %7s %7s' %
          ('module', 'base P/D', 'flag', 'dDIFF', 'dPASS'))
    for mod in args:
        tu = None
        for ext in ('.c', '.cpp'):
            if (ROOT / 'recon' / (mod + ext)).exists():
                tu = 'recon/' + mod + ext
        if tu is None:
            print('%-38s (no recon TU)' % mod)
            continue
        fns = subprocess.run([sys.executable, str(FL), mod],
                             capture_output=True, text=True,
                             cwd=str(ROOT)).stdout.strip()
        if not fns:
            print('%-38s (no scaffolding)' % mod)
            continue
        base = gate(tu, fns, '', cc1, None)
        if base is None:
            print('%-38s BASE GATE FAILED' % mod)
            continue
        bp, bd = tot(base)
        inert, broke = [], []
        for name, fl in flags:
            r = gate(tu, fns, fl, cc1, None)
            if r is None:
                broke.append(name)
                continue
            p, d = tot(r)
            if d == bd and p == bp:
                inert.append(name)
                continue
            print('%-38s %-11s %-24s %+7d %+7d'
                  % (mod, '%d/%d' % (bp, bd), fl, d - bd, p - bp))
            sys.stdout.flush()
        print('%-38s %-11s inert: %s%s'
              % (mod, '%d/%d' % (bp, bd), ' '.join(inert) or '-',
                 ('   REJECTED/FAILED: ' + ' '.join(broke)) if broke else ''))
        sys.stdout.flush()


if __name__ == '__main__':
    main()
