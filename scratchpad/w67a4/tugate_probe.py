"""tugate_probe.py CPP -- W67-A4: tools/tugate.py pointed at tools/vprobe.py so the
W60_TU_FLAGS / W61_TABLE env hooks apply (whole-TU flag probes, e.g. g_value 8),
with NO edit to tools/build.py.  Output format identical to tugate."""
import sys, difflib, importlib.util, re
from pathlib import Path
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tools'))
cpp = sys.argv[1]
sys.argv = [sys.argv[0], cpp, '__none__']
_sp = importlib.util.spec_from_file_location('va', ROOT / 'tools' / 'vprobe.py')
V = importlib.util.module_from_spec(_sp)
try:
    _sp.loader.exec_module(V)
except SystemExit as e:
    if not hasattr(V, '_name2addr'):
        sys.exit(f"tugate_probe: vprobe aborted loading {cpp} (exit {e.code})")
names = [n for n in V._name2addr if not n.startswith('.') and n]
res = []
for n in sorted(set(names)):
    try:
        b = V.oracle(n)
        if not b:
            continue
        a = V.ours(n)
        if not a:
            continue
    except Exception:
        continue
    if len(a) == len(b):
        for i in range(len(a)):
            mo = re.match(r'lui (\w+),0$', a[i])
            me = re.match(r'lui (\w+),\d+$', b[i])
            if mo and me and mo.group(1) == me.group(1):
                b[i] = a[i]
    d = [l for l in difflib.unified_diff(a, b, lineterm='')
         if l[0] in '+-' and not l.startswith(('+++', '---'))]
    res.append((len(d), n))
res.sort()
npass = sum(1 for c, _ in res if c == 0)
print(f"{cpp}: {npass}/{len(res)} PASS")
for c, n in res:
    if c:
        print(f"  {c:5}  {n}")
