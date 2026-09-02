"""D3_probe.py FILE VARIANTFILE -- apply edit-sets to a recon file, gate whole TU, restore.
variantfile defines VARIANTS = [(name, [(old,new), ...]), ...]
"""
import sys, subprocess, importlib.util
from pathlib import Path
ROOT = Path(r'C:/Temp/nfs4-decomp')
rel, vf = sys.argv[1], sys.argv[2]
spec = importlib.util.spec_from_file_location('v', vf)
m = importlib.util.module_from_spec(spec); spec.loader.exec_module(m)
p = ROOT/rel
orig = p.read_text(encoding='utf-8', errors='surrogateescape')
def gate():
    r = subprocess.run([sys.executable, str(ROOT/'tools'/'tugate.py'), rel],
                       capture_output=True, text=True, cwd=str(ROOT))
    out = r.stdout
    fails = [l.strip() for l in out.splitlines() if l.startswith('  ') and l.strip() and not l.strip().startswith('__none__')]
    lines = [l for l in out.strip().splitlines() if 'PASS' in l]
    last = lines[-1] if lines else (r.stderr.strip().splitlines()[-1][:200] if r.stderr.strip() else 'NO OUTPUT')
    return last, fails
try:
    base, bf = gate(); print("BASE:", base)
    for entry in m.VARIANTS:
        name, edits = entry
        txt = orig; ok = True
        for old, new in edits:
            if old not in txt: print(f"  [{name}] SKIP: pattern not found: {old[:60]!r}"); ok=False; break
            txt = txt.replace(old, new, 1)
        if not ok: continue
        p.write_text(txt, encoding='utf-8', errors='surrogateescape')
        res, fails = gate(); print(f"  [{name}] {res}")
        for f in fails[:6]: print("      ", f)
        p.write_text(orig, encoding='utf-8', errors='surrogateescape')
finally:
    p.write_text(orig, encoding='utf-8', errors='surrogateescape')
