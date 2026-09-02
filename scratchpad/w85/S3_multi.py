"""S3_multi.py <target-rel> <spec.py> [--keep NAME]

spec.py defines CASES = [(name, [(old, new), ...]), ...].
Each case's patch list is applied to the BEST snapshot, the whole TU is gated,
then reverted.  --keep NAME leaves that case applied and updates the snapshot.
Line endings are preserved byte-faithfully.
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

keep = None
if '--keep' in sys.argv:
    keep = sys.argv[sys.argv.index('--keep') + 1]

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


kept_text = None
for name, patches in m.CASES:
    t = base
    bad = None
    for old, new in patches:
        o = fix(old, t)
        n = fix(new, None)
        if o.count(CR) == 0 and old.count(chr(10)) > 0 and t.count(o) == 1:
            n = new.replace(CR, LF)
        if t.count(o) != 1:
            bad = "PATCH MISS (%d) %r" % (t.count(o), old[:70])
            break
        t = t.replace(o, n)
    if bad:
        print("%-40s %s" % (name, bad))
        continue
    tgt.write_text(t, encoding='utf-8', newline='')
    r = subprocess.run([sys.executable, str(ROOT / 'tools' / 'tugate.py'), rel],
                       cwd=str(ROOT), capture_output=True, text=True)
    out = (r.stdout + r.stderr).strip().splitlines()
    summ = [l for l in out if l.strip().endswith('PASS') and '/' in l]
    fails = [l for l in out if l.strip() and l.strip()[0].isdigit()]
    print("%-40s %s   %s" % (name,
          summ[-1].strip() if summ else 'COMPILE-FAIL',
          ' ; '.join(f.strip() for f in fails[:5])))
    if keep == name:
        kept_text = t

if kept_text is not None:
    tgt.write_text(kept_text, encoding='utf-8', newline='')
    shutil.copyfile(tgt, snap)
    print('[KEPT %s -- snapshot updated]' % keep)
else:
    shutil.copyfile(snap, tgt)
    print('[reverted]')
