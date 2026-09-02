"""M4 experiment driver: patch recon/frontend/common/fememcard.cpp from a saved
baseline with one (old,new) replacement, gate one fn, print the result.
usage: python scratchpad/w85/m4/try.py <baseline> <fn> <variantfile>
variantfile = python literal list of (old,new) pairs."""
import ast, pathlib, subprocess, sys

ROOT = pathlib.Path(__file__).resolve().parents[3]
TGT = ROOT / 'recon/frontend/common/fememcard.cpp'
base = pathlib.Path(sys.argv[1]).read_text()
fn = sys.argv[2]
pairs = ast.literal_eval(pathlib.Path(sys.argv[3]).read_text())
s = base
for old, new in pairs:
    assert old in s, 'MISSING: ' + old[:60]
    s = s.replace(old, new, 1)
TGT.write_text(s)
r = subprocess.run([sys.executable, str(ROOT/'tools'/'verify_asm.py'),
                    'recon/frontend/common/fememcard.cpp', fn],
                   cwd=str(ROOT), capture_output=True, text=True)
print(r.stdout.strip().splitlines()[0] if r.stdout.strip() else r.stderr[-500:])
