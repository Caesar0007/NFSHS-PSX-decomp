"""w64a5: apply ONE variant from a spec and print the full gate diff (VA_MAX uncapped)."""
import importlib.util
import os
import subprocess
import sys

ROOT = r"C:\Temp\nfs4-decomp"


def load(path):
    spec = importlib.util.spec_from_file_location("spec", path)
    m = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(m)
    return m


spec = load(sys.argv[1])
name = sys.argv[2]
tu = os.path.join(ROOT, spec.TU.replace("/", os.sep))
orig = open(tu, "rb").read()
crlf = orig.count(b"\r\n") > 0


def enc(s):
    b = s.encode("ascii").replace(b"\r\n", b"\n")
    return b.replace(b"\n", b"\r\n") if crlf else b


base = enc(spec.BASE)
assert orig.count(base) == 1
env = dict(os.environ, VA_MAX="400")
try:
    with open(tu + ".tmp", "wb") as fh:
        fh.write(orig.replace(base, enc(spec.VARIANTS[name])))
    os.replace(tu + ".tmp", tu)
    r = subprocess.run([sys.executable, "tools/verify_asm.py", spec.TU, spec.FUNC],
                       cwd=ROOT, capture_output=True, text=True, timeout=900, env=env)
    print(r.stdout + r.stderr)
finally:
    with open(tu + ".tmp", "wb") as fh:
        fh.write(orig)
    os.replace(tu + ".tmp", tu)
