#!/usr/bin/env python
"""w47-a9 -- ORACLE-DIRECTION sweep (fingerprint MODE B).

Runs scratch/w47_a9_verify.py (= tools/verify_asm.py + env flag hooks, same
normalizer, same maspsx/as, so the numbers ARE gate numbers) over one recon TU
under N candidate flag configurations, and tabulates

    config  ->  PASS count  /  total diff count  /  per-fn deltas vs the baseline

so a flag that moves a module TOWARD the retail oracle is visible immediately.

usage:
  python scratch/w47_a9_sweep.py <recon/rel/path.c[pp]> <fn1,fn2,...|@file>
         [--cfg 'LABEL:GVALUE:EXTRA FLAGS'] ...          (repeatable)
  (with no --cfg the default ladder G0/G4/G8 is used)

A config string is  LABEL : GVALUE : EXTRA
  GVALUE empty -> leave -G as the tree's own (per-TU) value
  EXTRA  empty -> no extra cc1 flags
"""
import os
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
VERIFY = ROOT / "scratch" / "w47_a9_verify.py"

LINE = re.compile(r'^\s{2}(\S+): (PASS \((\d+) insns\)|FAIL (\d+) diffs'
                  r' \(ours (\d+) / oracle (\d+)\)|NO ORACLE|NOT IN OBJECT)')


def run_cfg(tu, fns, gvalue, extra, cc1=None):
    env = dict(os.environ)
    env.pop('NFS4_A9_GVALUE', None)
    env.pop('NFS4_A9_CC1FLAGS', None)
    env.pop('NFS4_A9_CC1', None)
    if gvalue:
        env['NFS4_A9_GVALUE'] = gvalue
    if extra:
        env['NFS4_A9_CC1FLAGS'] = extra
    if cc1:
        env['NFS4_A9_CC1'] = cc1
    r = subprocess.run([sys.executable, str(VERIFY), tu, fns],
                       capture_output=True, text=True, env=env, cwd=str(ROOT),
                       timeout=900)
    res = {}
    for ln in (r.stdout + r.stderr).splitlines():
        m = LINE.match(ln)
        if not m:
            continue
        fn, body = m.group(1), m.group(2)
        if body.startswith('PASS'):
            res[fn] = 0
        elif body.startswith('FAIL'):
            res[fn] = int(m.group(4))
        else:
            res[fn] = None            # NO ORACLE / NOT IN OBJECT
    if not res:
        res['<BUILD FAILED>'] = (r.stdout + r.stderr).strip()[-400:]
    return res


def main():
    tu = sys.argv[1]
    fns = sys.argv[2]
    if fns.startswith('@'):
        fns = Path(fns[1:]).read_text(encoding='utf-8').strip()
    cfgs = []
    i = 3
    while i < len(sys.argv):
        if sys.argv[i] == '--cfg':
            lab, g, extra, cc1 = (sys.argv[i + 1].split(':', 3)
                                  + ['', '', ''])[:4]
            cfgs.append((lab, g, extra, cc1))
            i += 2
        else:
            i += 1
    if not cfgs:
        cfgs = [('G0', '0', '', ''), ('G4', '4', '', ''),
                ('G8', '8', '', '')]

    out = {}
    for lab, g, extra, cc1 in cfgs:
        out[lab] = run_cfg(tu, fns, g, extra, cc1 or None)
        r = out[lab]
        if '<BUILD FAILED>' in r:
            print('%-22s BUILD FAILED: %s' % (lab, r['<BUILD FAILED>'][:200]))
            continue
        p = sum(1 for v in r.values() if v == 0)
        d = sum(v for v in r.values() if isinstance(v, int))
        print('%-22s PASS %2d/%2d   total-diffs %5d' % (lab, p, len(r), d))

    names = sorted({k for r in out.values() for k in r if k != '<BUILD FAILED>'})
    labs = [c[0] for c in cfgs if '<BUILD FAILED>' not in out[c[0]]]
    print()
    print('%-44s %s' % ('function', ' '.join('%8s' % l for l in labs)))
    for n in names:
        row = ''.join('%9s' % ('PASS' if out[l].get(n) == 0
                               else ('-' if out[l].get(n) is None
                                     else out[l][n])) for l in labs)
        print('%-44s %s' % (n[:44], row))


if __name__ == '__main__':
    main()
