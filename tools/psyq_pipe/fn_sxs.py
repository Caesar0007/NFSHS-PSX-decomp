"""fn_sxs.py CPP FUNC [START [COUNT]] -- unified diff (full context) of one function, retail (-) vs ours (+)."""
import difflib
import importlib.util
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tools'))
cpp, fn = sys.argv[1], sys.argv[2]
start = int(sys.argv[3]) if len(sys.argv) > 3 else 0
count = int(sys.argv[4]) if len(sys.argv) > 4 else 100000
sys.argv = [sys.argv[0], cpp, '__none__']
sp = importlib.util.spec_from_file_location('va', ROOT / 'tools' / 'verify_asm.py')
V = importlib.util.module_from_spec(sp)
try:
    sp.loader.exec_module(V)
except SystemExit:
    pass
o, u = V.oracle(fn), V.ours(fn)
out = list(difflib.unified_diff(o, u, lineterm='', n=100000))[3:]
for i, l in enumerate(out[start:start + count]):
    print('%4d %s' % (i + start, l))
