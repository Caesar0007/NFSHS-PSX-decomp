#!/usr/bin/env python3
"""update_region_progress.py -- regenerate regiondiff/REGION_PROGRESS.txt.

Walks regiondiff/MANIFEST.tsv; for every row whose candidate recon file
exists, runs verify_region.py (one compile per candidate file, functions
batched) and records REGION-PASS / FAIL n; rows without a candidate are
TODO.  The board is the regional pipeline's MATCH_PROGRESS equivalent.

Usage: python regiondiff/tools/update_region_progress.py [--only <substr>]
"""
import re, subprocess, sys
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
RD = ROOT / 'regiondiff'
VERIFY = RD / 'tools' / 'verify_region.py'

only = None
if '--only' in sys.argv:
    only = sys.argv[sys.argv.index('--only') + 1]

rows = []
hdr = None
for ln in (RD / 'MANIFEST.tsv').read_text().splitlines():
    f = ln.rstrip('\n').split('\t')
    if hdr is None:
        hdr = f; continue
    rows.append(dict(zip(hdr, f)))
if only:
    rows = [r for r in rows if only in r['function'] or only in r['unit']]

# group rows by (candidate, repr_region); one compile+gate run per group
groups = defaultdict(list)
for r in rows:
    groups[(r['candidate'], r['repr_region'], r['unit'])].append(r)

status = {}   # (function, repr_region) -> text
for (cand, region, unit), grp in sorted(groups.items()):
    cpath = ROOT / cand
    fns = [r['function'] for r in grp]
    if not cpath.exists():
        for fn in fns:
            status[(fn, region)] = 'TODO'
        continue
    lane = None
    for ext in ('.cpp', '.c'):
        if (ROOT / 'recon' / (unit + ext)).exists():
            lane = 'recon/' + unit + ext
    cmd = [sys.executable, str(VERIFY), region, cand, ','.join(fns)]
    if lane:
        cmd.append('--lane-as=' + lane)
    p = subprocess.run(cmd, capture_output=True, text=True, cwd=ROOT)
    out = p.stdout + p.stderr
    for fn in fns:
        m = re.search(re.escape(fn) + r': (REGION-PASS \((\d+) insns\)|FAIL (\d+) diffs[^\n\[]*)', out)
        if m:
            status[(fn, region)] = ('SEALED' if m.group(1).startswith('REGION-PASS')
                                    else 'FAIL ' + m.group(3))
        else:
            status[(fn, region)] = 'ERROR'

sealed = sum(1 for v in status.values() if v == 'SEALED')
todo = sum(1 for v in status.values() if v == 'TODO')
fail = sum(1 for v in status.values() if v.startswith('FAIL'))
err = sum(1 for v in status.values() if v == 'ERROR')

out = []
out.append('NFS4-PSX regional-variant reconstruction -- per-row progress')
out.append('(gate: regiondiff/tools/verify_region.py; plan: MANIFEST.tsv)')
out.append(f'TOTAL: {len(rows)} rows, {sealed} SEALED / {fail} FAIL / '
           f'{todo} TODO / {err} ERROR')
out.append('=' * 88)
out.append(f'{"status":<10} {"words":>6}  {"region":<10} {"unit":<28} function')
for r in rows:
    st = status.get((r['function'], r['repr_region']), 'TODO')
    out.append(f'{st:<10} {r["words"]:>6}  {r["repr_region"]:<10} '
               f'{r["unit"]:<28} {r["function"]}')
if not only:
    (RD / 'REGION_PROGRESS.txt').write_text('\n'.join(out) + '\n', newline='\n')
print('\n'.join(out[:4]))
print('board written' if not only else '\n'.join(out[4:]))
