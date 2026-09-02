"""S3_try.py -- device-removal probe harness for W85-S3.

usage:
  python scratchpad/w85/S3_try.py <target-rel-path> <spec.py> [--keep]
  python scratchpad/w85/S3_try.py <target-rel-path> --restore

spec.py defines PATCHES = [(old, new), ...] applied in order to the BEST
snapshot (scratchpad/w85/best/<basename>); line endings preserved.
"""
import importlib.util, subprocess, sys, shutil
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
BEST = ROOT / 'scratchpad' / 'w85' / 'best'
BEST.mkdir(parents=True, exist_ok=True)

rel = sys.argv[1]
tgt = ROOT / rel
snap = BEST / Path(rel).name
if not snap.exists():
    shutil.copyfile(tgt, snap)

if sys.argv[2] == '--restore':
    shutil.copyfile(snap, tgt)
    print('restored from snapshot')
    sys.exit(0)

if sys.argv[2] == '--resnap':
    shutil.copyfile(tgt, snap)
    print('snapshot updated from target')
    sys.exit(0)

keep = '--keep' in sys.argv
spec = importlib.util.spec_from_file_location('spec', sys.argv[2])
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)

text = snap.read_text(encoding='utf-8', newline='')
CR = chr(13) + chr(10)
LF = chr(10)
CRLF = text.count(CR) > text.count(LF) / 2


def fix(s, hay=None):
    s = s.replace(CR, LF)
    a = s.replace(LF, CR)
    if hay is None:
        return a if CRLF else s
    if hay.count(a) == 1:
        return a
    if hay.count(s) == 1:
        return s
    return a if CRLF else s


for old, new in m.PATCHES:
    old, new = fix(old), fix(new)
    n = text.count(old)
    if n != 1:
        sys.exit("PATCH MISS: %d occurrences\n---\n%s" % (n, old[:400]))
    text = text.replace(old, new)
tgt.write_text(text, encoding='utf-8', newline='')

r = subprocess.run([sys.executable, str(ROOT / 'tools' / 'tugate.py'), rel],
                   cwd=str(ROOT), capture_output=True, text=True)
print((r.stdout + r.stderr).strip()[-6000:])

if keep:
    shutil.copyfile(tgt, snap)
    print('[KEPT -- snapshot updated]')
else:
    shutil.copyfile(snap, tgt)
    print('[reverted]')
