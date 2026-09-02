"""S3_sweep.py <target-rel> <specfile>  -- try many single-site replacements, gate each.

specfile is a python file defining:
    OLD = "...."          # exact text to replace (must occur exactly once)
    VARIANTS = [(name, newtext), ...]
Each variant is applied to the BEST snapshot, gated with tugate, then reverted.
Line endings of the target file are preserved byte-faithfully.
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

spec = importlib.util.spec_from_file_location('spec', sys.argv[2])
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)

base = snap.read_text(encoding='utf-8', newline='')
CR = chr(13) + chr(10)
LF = chr(10)
CRLF = base.count(CR) > base.count(LF) / 2


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


m.OLD = fix(m.OLD)
m.VARIANTS = [(n, fix(v)) for n, v in m.VARIANTS]
assert base.count(m.OLD) == 1, "OLD occurs %d times" % base.count(m.OLD)

for name, new in m.VARIANTS:
    tgt.write_text(base.replace(m.OLD, new), encoding='utf-8', newline='')
    r = subprocess.run([sys.executable, str(ROOT / 'tools' / 'tugate.py'), rel],
                       cwd=str(ROOT), capture_output=True, text=True)
    out = (r.stdout + r.stderr).strip().splitlines()
    summ = [l for l in out if l.strip().endswith('PASS') and '/' in l]
    fails = [l for l in out if l.strip() and l.strip()[0].isdigit()]
    tail = summ[-1].strip() if summ else ' | '.join(l.strip() for l in out[-5:])
    extra = ('   ' + ' ; '.join(f.strip() for f in fails[:5])) if fails else ''
    print("%-44s %s%s" % (name, tail, extra))

shutil.copyfile(snap, tgt)
print('[all reverted to snapshot]')
