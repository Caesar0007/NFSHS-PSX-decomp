#!/usr/bin/env python3
"""update_data_progress.py -- regenerate regiondiff/DATA_PROGRESS.txt.

Rows = every (region, symbol) pair in the data audit dumps
(regiondiff/data/<REGION>/*.delta.txt, from audit_data.py).  For each row:
find the OWNER TU (the base object defining the symbol, via nm over
build/recon), derive the regional candidate path, and if the candidate
exists gate it with verify_data.py -> DATA-PASS / DATA-FAIL n / BSS /
NOT-IN-OBJECT; otherwise TODO.

Usage: python regiondiff/tools/update_data_progress.py [--only <substr>]
"""
import re, subprocess, sys
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
RD = ROOT / 'regiondiff'
NM = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-nm.exe'
VERIFY = RD / 'tools' / 'verify_data.py'

only = None
if '--only' in sys.argv:
    only = sys.argv[sys.argv.index('--only') + 1]

# rows from the audit dumps
rows = []      # (region, sym, ndeltas)
for rdir in sorted((RD / 'data').iterdir()):
    if not rdir.is_dir():
        continue
    for p in sorted(rdir.glob('*.delta.txt')):
        n = sum(1 for l in p.read_text().splitlines() if l.startswith('  +'))
        sym = p.read_text().split()[0]
        rows.append((rdir.name, sym, n))
if only:
    rows = [r for r in rows if only in r[1]]

# owner map: defined symbol -> recon source path (via build objects)
owner = {}
objs = [p for p in (ROOT / 'build' / 'recon').rglob('*.o')
        if '__' not in p.stem]
want = {sym for _, sym, _ in rows}
want |= {'_vt.' + s[4:] for s in want if s.startswith('_vt_')}
alias = {'_vt.' + s[4:]: s for s in {sym for _, sym, _ in rows} if s.startswith('_vt_')}
for i in range(0, len(objs), 40):
    r = subprocess.run([NM] + [str(o) for o in objs[i:i+40]],
                       capture_output=True, text=True)
    cur = None
    for ln in r.stdout.splitlines():
        if ln.endswith(':') and not ln.startswith(' '):
            cur = ln[:-1]
        p = ln.split()
        if len(p) == 3 and p[1] in 'TDBSRdbsr' and p[2] in want and cur:
            rel = Path(cur).resolve().relative_to((ROOT / 'build').resolve())
            owner.setdefault(p[2], str(rel)[:-2].replace('\\', '/'))  # strip .o
    # single-object listings have no "file:" header lines
    if len(objs[i:i+40]) == 1:
        o = objs[i]
        for ln in r.stdout.splitlines():
            p = ln.split()
            if len(p) == 3 and p[1] in 'TDBSRdbsr' and p[2] in want:
                rel = o.resolve().relative_to((ROOT / 'build').resolve())
                owner.setdefault(p[2], str(rel)[:-2].replace('\\', '/'))

# symbols with no recon owner: check the asm-data side (dlabel) -- vtables
# and D_* tables are materialized there, not in recon TUs; their regional
# reconstruction is a different mechanism (regional asm-data), class ASM-DATA.
asmdata = set()
unowned = {s for _, s, _ in rows if s not in owner}
if unowned:
    r = subprocess.run(['git', 'grep', '-l', '-E',
                        'dlabel (' + '|'.join(re.escape(s) for s in unowned) + ')',
                        '--', 'asm/data'], capture_output=True, text=True, cwd=ROOT)
    if r.stdout.strip():
        r2 = subprocess.run(['git', 'grep', '-h', '-oE',
                             'dlabel (' + '|'.join(re.escape(s) for s in unowned) + ')',
                             '--', 'asm/data'], capture_output=True, text=True, cwd=ROOT)
        asmdata = {l.split()[1] for l in r2.stdout.splitlines() if l.startswith('dlabel ')}

status = {}
groups = defaultdict(list)
for region, sym, nd in rows:
    u = owner.get(sym)
    if u is None:
        status[(region, sym)] = 'ASM-DATA' if sym in asmdata else 'NO-OWNER'
        continue
    cand = ROOT / 'regiondiff' / 'recon' / region / Path(u).relative_to('recon')
    groups[(region, str(cand), u)].append(sym)
for (region, candp, u), symlist in sorted(groups.items()):
    cand = Path(candp)
    if not cand.exists():
        for s in symlist:
            status[(region, s)] = 'TODO'
        continue
    lane = u    # recon/<unit>.<ext>
    r = subprocess.run([sys.executable, str(VERIFY), region,
                        str(cand.relative_to(ROOT)), ','.join(symlist),
                        '--lane-as=' + lane],
                       capture_output=True, text=True, cwd=ROOT)
    out = r.stdout + r.stderr
    for s in symlist:
        m = re.search(re.escape(s) + r': (DATA-PASS|DATA-FAIL (\d+) words|BSS|NOT IN OBJECT|NOT IN SYMMAP)', out)
        if m:
            t = m.group(1)
            status[(region, s)] = ('SEALED' if t == 'DATA-PASS'
                                   else 'BSS' if t == 'BSS'
                                   else 'FAIL ' + m.group(2) if t.startswith('DATA-FAIL')
                                   else 'NO-SYM' if 'SYMMAP' in t
                                   else 'NOT-IN-OBJ')
        else:
            status[(region, s)] = 'ERROR'

c = defaultdict(int)
for v in status.values():
    c[v.split()[0]] += 1
out = []
out.append('NFS4-PSX regional DATA reconstruction -- per-symbol progress')
out.append('(gate: regiondiff/tools/verify_data.py; audit: tools/audit_data.py)')
out.append('TOTAL: %d rows, %d SEALED / %d FAIL / %d TODO / %d other'
           % (len(rows), c['SEALED'], c['FAIL'],
              c['TODO'], len(rows) - c['SEALED'] - c['FAIL'] - c['TODO']))
out.append('=' * 84)
out.append(f'{"status":<10} {"deltas":>6}  {"region":<16} {"owner":<34} symbol')
for region, sym, nd in rows:
    st = status.get((region, sym), 'TODO')
    u = owner.get(sym, '?')
    out.append(f'{st:<10} {nd:>6}  {region:<16} {u:<34} {sym}')
if not only:
    (RD / 'DATA_PROGRESS.txt').write_text('\n'.join(out) + '\n', newline='\n')
print('\n'.join(out[:4]))
print('board written' if not only else '\n'.join(out[4:]))
