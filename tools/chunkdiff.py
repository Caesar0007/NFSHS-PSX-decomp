"""chunkdiff.py CPP FN [MINSZ] -- report mismatched RUNS (ours vs oracle) with
index ranges + sizes, largest first, so a far-miss can be localized."""
import sys, difflib, importlib.util
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent; sys.path.insert(0, str(ROOT/'tools'))
cpp, fn = sys.argv[1], sys.argv[2]
minsz = int(sys.argv[3]) if len(sys.argv) > 3 else 6
import importlib.util as _iu
_sp=_iu.spec_from_file_location('va', ROOT/'tools'/'verify_asm.py')
V=_iu.module_from_spec(_sp)
try: _sp.loader.exec_module(V)
except SystemExit: pass
a = V.ours(fn); b = V.oracle(fn)
sm = difflib.SequenceMatcher(None, a, b, autojunk=False)
runs = []
for tag, i1, i2, j1, j2 in sm.get_opcodes():
    if tag != 'equal' and max(i2-i1, j2-j1) >= minsz:
        runs.append((max(i2-i1, j2-j1), tag, i1, i2, j1, j2))
runs.sort(reverse=True)
print(f"ours={len(a)} oracle={len(b)}  mismatched runs >= {minsz}: {len(runs)}")
tot = sum(r[0] for r in runs)
print(f"insns inside those runs: {tot}")
for sz, tag, i1, i2, j1, j2 in runs[:25]:
    print(f"\n--- {tag} size {sz}  ours[{i1}:{i2}]  oracle[{j1}:{j2}]")
    for k in range(i1, min(i2, i1+14)): print("   -", a[k])
    for k in range(j1, min(j2, j1+14)): print("   +", b[k])
