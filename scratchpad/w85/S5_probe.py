"""S5_probe.py FILE  -- apply a variant (old->new) to a recon file, gate the whole TU, restore.
usage: python S5_probe.py <relpath> <variantfile>
variantfile: python file defining VARIANTS = [(name, old, new), ...]
"""
import sys, subprocess, importlib.util
from pathlib import Path
ROOT = Path(r'C:/Temp/nfs4-decomp')
rel = sys.argv[1]
vf  = sys.argv[2]
spec = importlib.util.spec_from_file_location('v', vf)
m = importlib.util.module_from_spec(spec); spec.loader.exec_module(m)
p = ROOT/rel
orig = p.read_text(encoding='utf-8', errors='surrogateescape')
def gate():
    r = subprocess.run([sys.executable, str(ROOT/'tools'/'tugate.py'), rel],
                       capture_output=True, text=True, cwd=str(ROOT))
    out = r.stdout
    fails = [l.strip() for l in out.splitlines() if 'FAIL' in l]
    last = out.strip().splitlines()[-1] if out.strip() else 'NO OUTPUT'
    if 'error' in r.stderr.lower() or 'Error' in r.stderr:
        last += ' | STDERR: ' + r.stderr.strip().splitlines()[-1][:200] if r.stderr.strip() else last
    return last, fails
try:
    base, bf = gate()
    print("BASE:", base)
    for name, old, new in m.VARIANTS:
        if old not in orig:
            print(f"  [{name}] SKIP: pattern not found"); continue
        p.write_text(orig.replace(old, new, 1), encoding='utf-8', errors='surrogateescape')
        res, fails = gate()
        print(f"  [{name}] {res}")
        for f in fails[:8]: print("      ", f)
        p.write_text(orig, encoding='utf-8', errors='surrogateescape')
finally:
    p.write_text(orig, encoding='utf-8', errors='surrogateescape')
