#!/usr/bin/env python3
"""W84-C1 CLUSTER-RESOLVED RUNG FINGERPRINT.

Instead of scoring a rung by TOTAL FntFlush diff count (which conflates 2.7-era
codegen deltas with the reload_cse_regs identity), score each rung on the two
INDEPENDENT binary predicates that make up the 6-word residual:

  P1  reload_cse_regs fired?   ours has `addu a0,a2,zero` (fired) vs the retail
      `lw a0,16(sp)` raw spill+reload (did not fire).
  P2  colour stores at TOP?    retail emits `sw a2,28(sp); sw a2,32(sp)` right
      after `li a2,128`, before the callee-saved saves; ours has sched2 carry
      them below `sw zero,20(sp)`.

Usage:  python scratchpad/w84/C1_rungsweep.py [ver ...]
Runs the TU's REAL lane (maspsx route, TU flags aliased) with only the cc1
binary swapped via NFS4_FORCE_CC1_VER -- probe-only, per build.py's own note.
"""
import os, re, subprocess, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
GATE = ROOT / 'scratchpad' / 'w84' / 'C1_verify.py'
VDIFF = ROOT / 'scratchpad' / 'w84' / 'C1_vdiff.py'
CAND = sys.argv[1] if len(sys.argv) > 1 and sys.argv[1].endswith(('.c', '.cpp')) \
       else 'scratchpad/w84/C1_FONT.c'
VERS = sys.argv[2:] if len(sys.argv) > 2 else [
    '2.6.0', '2.6.3', '2.7.2-970404', '2.7.2', '2.8.0', '2.8.1',
    '2.91.66', '2.95.2', '2.8.1-sn',
]


def run(ver, script, *args):
    env = dict(os.environ)
    if ver:
        env['NFS4_FORCE_CC1_VER'] = ver
    else:
        env.pop('NFS4_FORCE_CC1_VER', None)
    r = subprocess.run([sys.executable, str(script), CAND, *args],
                       capture_output=True, text=True, cwd=ROOT, env=env)
    return r.stdout + r.stderr


def cell(ver):
    out = run(ver, GATE, 'FntFlush,FntPrint')
    res = {}
    for fn in ('FntFlush', 'FntPrint'):
        m = re.search(rf'{fn}: (PASS \((\d+) insns\)|FAIL (\d+) diffs \(ours (\d+) / oracle (\d+)\))', out)
        if not m:
            res[fn] = ('ERR', out.strip().splitlines()[-1][:90] if out.strip() else '?')
        elif m.group(1).startswith('PASS'):
            res[fn] = ('PASS', int(m.group(2)))
        else:
            res[fn] = ('FAIL', int(m.group(3)), int(m.group(4)), int(m.group(5)))
    # cluster predicates from the OURS side of the full diff
    d = run(ver, VDIFF, 'FntFlush')
    ours = []
    for ln in d.splitlines():
        if ln.startswith(('---', '+++', '@@')) or ln.startswith('['):
            continue
        if ln.startswith('+'):
            continue
        ours.append(ln[1:] if ln.startswith('-') else ln)
    body = '\n'.join(ours)
    p1_fired = 'addu a0,a2,zero' in body          # reload_cse turned lw into a copy
    p1_raw = 'lw a0,16(sp)' in body               # retail's raw spill+reload survived
    # P2: index of first colour store vs the `sw zero,20(sp)` marker
    idx28 = next((i for i, l in enumerate(ours) if l.strip() == 'sw a2,28(sp)'), None)
    idx20 = next((i for i, l in enumerate(ours) if l.strip() == 'sw zero,20(sp)'), None)
    p2_top = (idx28 is not None and idx20 is not None and idx28 < idx20)
    return res, p1_fired, p1_raw, p2_top


print(f'candidate: {CAND}')
print(f'{"rung":14s} {"FntFlush":>22s} {"FntPrint":>18s}  P1(reload_cse)      P2(colour stores)')
for ver in [None] + VERS:
    try:
        res, fired, raw, top = cell(ver)
    except Exception as e:                                    # noqa: BLE001
        print(f'{str(ver):14s} EXC {e}')
        continue
    def fmt(t):
        return f'PASS {t[1]}' if t[0] == 'PASS' else (
            f'FAIL {t[1]} @{t[2]}/{t[3]}' if t[0] == 'FAIL' else f'ERR {t[1]}')
    p1 = 'FIRED (move)' if fired else ('raw sw;lw' if raw else 'n/a-matches')
    p2 = 'TOP (retail)' if top else 'carried down'
    print(f'{str(ver or "TU lane (2.8.0)"):14s} {fmt(res["FntFlush"]):>22s} '
          f'{fmt(res["FntPrint"]):>18s}  {p1:18s}  {p2}')
