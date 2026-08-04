#!/usr/bin/env python
"""w48-a9 -- the syslib FLAG/IDENTITY AXIS runner.

For every (module, config) pair it runs scratch/w47_a9_verify.py (= the stock
tools/verify_asm.py with env flag hooks, same normalizer / maspsx / GNU as, so
every number IS a gate number) and records, PER FUNCTION:

    diffs, ours_insn_count, oracle_insn_count

From that it derives the three quantities the w47 IDENTITY BAR needs:

    PASS      -- diffs == 0                    (the bar's conversion test)
    DIFFS     -- sum of diffs                  (the nudge measure)
    CNTEX     -- ours == oracle insn count     (the bar's "exact count" test)

Results are appended to a JSON ledger so a later run can diff configs per fn
and prove ZERO PASS REGRESSIONS.

usage:
  python scratch/w48_a9_axis.py --out scratch/w48_a9/<tag>.json \
        --cfg 'LABEL:GVALUE:EXTRA CC1 FLAGS' [--cfg ...] <mod> [<mod> ...]

  GVALUE empty -> tree's own -G;  EXTRA empty -> tree's own flags (BASE).
"""
import json
import os
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
VERIFY = ROOT / 'scratch' / 'w47_a9_verify.py'
FL = ROOT / 'scratch' / 'w47_a9_fnlist.py'

LINE = re.compile(r'^\s{2}(\S+): (PASS \((\d+) insns\)|FAIL (\d+) diffs'
                  r' \(ours (\d+) / oracle (\d+)\)|NO ORACLE|NOT IN OBJECT)')


def tu_path(mod):
    for ext in ('.c', '.cpp'):
        if (ROOT / 'recon' / (mod + ext)).exists():
            return 'recon/' + mod + ext
    return None


def gate(tu, fns, gvalue, extra, cc1=None, timeout=1800):
    env = dict(os.environ)
    for k in ('NFS4_A9_GVALUE', 'NFS4_A9_CC1FLAGS', 'NFS4_A9_CC1'):
        env.pop(k, None)
    if gvalue:
        env['NFS4_A9_GVALUE'] = gvalue
    if extra:
        env['NFS4_A9_CC1FLAGS'] = extra
    if cc1:
        env['NFS4_A9_CC1'] = cc1
    env['VA_MAX'] = '0'
    try:
        r = subprocess.run([sys.executable, str(VERIFY), tu, fns],
                           capture_output=True, text=True, env=env,
                           cwd=str(ROOT), timeout=timeout)
    except subprocess.TimeoutExpired:
        return None, 'TIMEOUT'
    res = {}
    for ln in (r.stdout + r.stderr).splitlines():
        m = LINE.match(ln)
        if not m:
            continue
        fn, body = m.group(1), m.group(2)
        if body.startswith('PASS'):
            res[fn] = [0, int(m.group(3)), int(m.group(3))]
        elif body.startswith('FAIL'):
            res[fn] = [int(m.group(4)), int(m.group(5)), int(m.group(6))]
        else:
            res[fn] = None
    if not res:
        return None, (r.stdout + r.stderr).strip()[-500:]
    return res, None


def summarize(res):
    p = sum(1 for v in res.values() if v and v[0] == 0)
    d = sum(v[0] for v in res.values() if v)
    c = sum(1 for v in res.values() if v and v[1] == v[2])
    n = sum(1 for v in res.values() if v)
    return p, d, c, n


def main():
    args = sys.argv[1:]
    cfgs, out, cc1 = [], None, None
    mods = []
    i = 0
    while i < len(args):
        if args[i] == '--cfg':
            lab, g, extra = (args[i + 1].split(':', 2) + ['', ''])[:3]
            cfgs.append((lab, g, extra))
            i += 2
        elif args[i] == '--out':
            out = args[i + 1]
            i += 2
        elif args[i] == '--cc1':
            cc1 = args[i + 1]
            i += 2
        else:
            mods.append(args[i])
            i += 1
    if not cfgs:
        cfgs = [('BASE', '', '')]

    ledger = {}
    if out and Path(ROOT / out).exists():
        ledger = json.loads((ROOT / out).read_text())

    print('%-34s %-14s %7s %7s %7s %7s' %
          ('module', 'config', 'PASS', 'of', 'DIFFS', 'CNTEX'))
    for mod in mods:
        tu = tu_path(mod)
        if tu is None:
            print('%-34s (no recon TU)' % mod)
            continue
        fns = subprocess.run([sys.executable, str(FL), mod],
                             capture_output=True, text=True,
                             cwd=str(ROOT)).stdout.strip()
        if not fns:
            print('%-34s (no scaffolding)' % mod)
            continue
        ledger.setdefault(mod, {})
        for lab, g, extra in cfgs:
            res, err = gate(tu, fns, g, extra, cc1)
            if res is None:
                print('%-34s %-14s  GATE FAILED: %s' % (mod, lab, str(err)[:120]))
                continue
            ledger[mod][lab] = res
            p, d, c, n = summarize(res)
            print('%-34s %-14s %7d %7d %7d %7d' % (mod, lab, p, n, d, c))
            sys.stdout.flush()
        if out:
            Path(ROOT / out).parent.mkdir(parents=True, exist_ok=True)
            (ROOT / out).write_text(json.dumps(ledger, indent=1))


if __name__ == '__main__':
    main()
