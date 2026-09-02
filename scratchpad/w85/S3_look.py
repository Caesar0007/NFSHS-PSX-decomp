"""S3_look.py <target-rel> <spec.py> <casename> <fn>  -- apply one case, print vdiff, revert."""
import importlib.util, subprocess, sys, shutil
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
rel, specf, case, fn = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]
tgt = ROOT / rel
snap = ROOT / 'scratchpad' / 'w85' / 'best' / Path(rel).name
if not snap.exists():
    shutil.copyfile(tgt, snap)

spec = importlib.util.spec_from_file_location('spec', specf)
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


t = base
for old, new in dict(m.CASES)[case]:
    o = fix(old, t)
    n = fix(new, None)
    if o.count(CR) == 0 and old.count(chr(10)) > 0 and t.count(o) == 1:
        n = new.replace(CR, LF)
    assert t.count(o) == 1, "patch miss %d" % t.count(o)
    t = t.replace(o, n)
tgt.write_text(t, encoding='utf-8', newline='')
r = subprocess.run([sys.executable, str(ROOT / 'tools' / 'vdiff.py'), rel, fn],
                   cwd=str(ROOT), capture_output=True, text=True)
print((r.stdout + r.stderr)[-4000:])
shutil.copyfile(snap, tgt)
