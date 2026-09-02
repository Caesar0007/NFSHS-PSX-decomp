"""S5_sweep.py <relpath>  -- find single-line clearable devices, try deleting each
(and all together), gate the whole TU each time, always restore."""
import sys, re, subprocess
from pathlib import Path
ROOT = Path(r'C:/Temp/nfs4-decomp')
rel = sys.argv[1]
p = ROOT/rel
orig = p.read_text(encoding='utf-8', errors='surrogateescape')
lines = orig.split('\n')

DEV = re.compile(r'__asm__\s*(__volatile__|volatile)?\s*\(\s*""')
VOL = re.compile(r'\*\s*\(\s*volatile\b')

def gate():
    r = subprocess.run([sys.executable, str(ROOT/'tools'/'tugate.py'), rel],
                       capture_output=True, text=True, cwd=str(ROOT))
    out = r.stdout.strip().splitlines()
    if not out: return 'COMPILE-FAIL', []
    fails = [l.strip() for l in out if 'FAIL' in l or re.match(r'^\s+\d+\s', l)]
    return out[-1], fails

cands = []
for i,l in enumerate(lines):
    if DEV.search(l):
        # single-line statement only
        if l.rstrip().endswith(');'):
            cands.append(('asm', i, l.strip()))
        else:
            cands.append(('asm-multiline-SKIP', i, l.strip()))
    elif VOL.search(l):
        cands.append(('vol', i, l.strip()))

print(f"--- {rel}: {len(cands)} candidate device lines ---")
for k,i,t in cands: print(f"  L{i+1} [{k}] {t[:110]}")
base,_ = gate(); print("BASE:", base)

def test(newlines, label):
    p.write_text('\n'.join(newlines), encoding='utf-8', errors='surrogateescape')
    r, f = gate()
    print(f"  {label}: {r}")
    for x in f[:6]: print("        ", x[:120])
    p.write_text(orig, encoding='utf-8', errors='surrogateescape')
    return r

try:
    single = [c for c in cands if c[0]=='asm']
    if single:
        nl = [l for i,l in enumerate(lines) if i not in {c[1] for c in single}]
        test(nl, f"DELETE ALL {len(single)} asm fences")
        if len(single) > 1:
            for k,i,t in single:
                nl = [l for j,l in enumerate(lines) if j != i]
                test(nl, f"del L{i+1}")
    vols = [c for c in cands if c[0]=='vol']
    for k,i,t in vols:
        nl = list(lines)
        nl[i] = re.sub(r'\*\s*\(\s*volatile\s+', '*(', nl[i])
        nl[i] = re.sub(r'\(\s*volatile\s+', '(', nl[i])
        test(nl, f"devolatile L{i+1}")
finally:
    p.write_text(orig, encoding='utf-8', errors='surrogateescape')
