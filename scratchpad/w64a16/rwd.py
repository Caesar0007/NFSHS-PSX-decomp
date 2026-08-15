"""Apply ONE rw.py variant and print the full gate diff (VA_MAX=200)."""
import sys, os, subprocess
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.join(HERE, "..", "..", "tools"))
import importlib, os as _o
rw = importlib.import_module(_o.environ.get("RWMOD","rw2"))

ROOT = os.path.join(HERE, "..", "..")
full = os.path.join(ROOT, rw.SRC)
orig = open(full, "rb").read()
tag = [k for k in rw.V if sys.argv[1] in k][0]
data = orig
for old, new in rw.V[tag]:
    assert old in data, old[:60]
    data = data.replace(old, new)
try:
    open(full + ".t", "wb").write(data)
    os.replace(full + ".t", full)
    env = dict(os.environ, VA_MAX="300")
    r = subprocess.run([sys.executable, "tools/verify_asm.py", rw.SRC, rw.FN],
                       capture_output=True, text=True, cwd=ROOT, env=env)
    print(tag)
    print(r.stdout)
finally:
    open(full + ".t", "wb").write(orig)
    os.replace(full + ".t", full)
    assert open(full, "rb").read() == orig
