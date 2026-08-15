"""w64a5: apply ONE variant from a spec, then run an arbitrary command, then restore.
usage: python prun.py <spec.py> <variant> <cmd...>
"""
import importlib.util
import os
import subprocess
import sys

ROOT = r"C:\Temp\nfs4-decomp"

spec_path, name = sys.argv[1], sys.argv[2]
cmd = sys.argv[3:]
_s = importlib.util.spec_from_file_location("spec", spec_path)
spec = importlib.util.module_from_spec(_s)
_s.loader.exec_module(spec)

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
    r = subprocess.run([sys.executable] + cmd, cwd=ROOT, capture_output=True,
                       text=True, timeout=1800)
    print(r.stdout + r.stderr)
finally:
    with open(tu + ".tmp", "wb") as fh:
        fh.write(orig)
    os.replace(tu + ".tmp", tu)
