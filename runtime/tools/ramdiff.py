#!/usr/bin/env python3
"""ramdiff.py -- compare two 2 MiB RAM dumps from run_frames.py.

Usage:
  py -3.14 runtime/tools/ramdiff.py traces/a.ram traces/b.ram \
      [--probe status/probe-X.patch]   # excludes the probe's own patch sites
"""
import argparse, json, sqlite3, sys
from pathlib import Path

RUNTIME = Path(__file__).resolve().parents[1]
BASE_VA = 0x80000000

ap = argparse.ArgumentParser()
ap.add_argument('a')
ap.add_argument('b')
ap.add_argument('--probe')
ap.add_argument('--max-show', type=int, default=16)
args = ap.parse_args()

A = (RUNTIME / args.a if not Path(args.a).is_absolute() else Path(args.a)).read_bytes()
B = (RUNTIME / args.b if not Path(args.b).is_absolute() else Path(args.b)).read_bytes()
excl = []
if args.probe:
    p = json.loads((RUNTIME / args.probe).read_text())
    excl = [(int(va, 16), size) for va, size in p['exclude_ranges']]

def excluded(va):
    return any(base <= va < base + size for base, size in excl)

db = sqlite3.connect(RUNTIME / 'analysis.sqlite')
def owner(va):
    r = db.execute("SELECT name, address FROM functions WHERE image='nfs4-f.exe' "
                   "AND address<=? ORDER BY address DESC LIMIT 1",
                   (va | 0x80000000,)).fetchone()
    if r and (va | 0x80000000) - r[1] < 0x8000:
        return f'{r[0]}+0x{(va | 0x80000000) - r[1]:X}'
    s = db.execute("SELECT name, address FROM symbols WHERE image='nfs4-f.exe' "
                   "AND address<=? ORDER BY address DESC LIMIT 1",
                   (va | 0x80000000,)).fetchone()
    return f'{s[0]}+0x{(va | 0x80000000) - s[1]:X}' if s else '?'

diffs = shown = 0
for off in range(0, min(len(A), len(B)), 4):
    if A[off:off+4] != B[off:off+4]:
        va = BASE_VA + off
        if excluded(va):
            continue
        diffs += 1
        if shown < args.max_show:
            aw = int.from_bytes(A[off:off+4], 'little')
            bw = int.from_bytes(B[off:off+4], 'little')
            print(f'  0x{va:08X}: {aw:08x} != {bw:08x}   [{owner(va)}]')
            shown += 1
print(f'{"IDENTICAL" if not diffs else str(diffs) + " differing words"} '
      f'(outside {len(excl)} excluded probe ranges)' if excl else
      ('IDENTICAL' if not diffs else f'{diffs} differing words'))
sys.exit(0 if not diffs else 1)
