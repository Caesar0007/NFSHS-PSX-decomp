"""w64a5: apply ONE variant from a spec and run tools/qty272.py on it."""
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
keep = sys.argv[3] if len(sys.argv) > 3 else None
tu = os.path.join(ROOT, spec.TU.replace("/", os.sep))
orig = open(tu, "rb").read()
crlf = orig.count(b"\r\n") > 0


def enc(s):
    b = s.encode("ascii").replace(b"\r\n", b"\n")
    return b.replace(b"\n", b"\r\n") if crlf else b


base = enc(spec.BASE)
assert orig.count(base) == 1
try:
    with open(tu + ".tmp", "wb") as fh:
        fh.write(orig.replace(base, enc(spec.VARIANTS[name])))
    os.replace(tu + ".tmp", tu)
    cmd = [sys.executable, "tools/qty272.py", spec.TU, spec.FUNC]
    if keep:
        cmd += ["--keep", keep]
    r = subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True, timeout=900)
    print(r.stdout + r.stderr)
finally:
    with open(tu + ".tmp", "wb") as fh:
        fh.write(orig)
    os.replace(tu + ".tmp", tu)
