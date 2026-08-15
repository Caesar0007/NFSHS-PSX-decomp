"""w64a5: apply a multi-edit variant then run an arbitrary tool, then restore.
usage: python pq2.py <spec.py> <variant> <tool.py> [args...]
"""
import importlib.util
import os
import subprocess
import sys

ROOT = r"C:\Temp\nfs4-decomp"
_s = importlib.util.spec_from_file_location("spec", sys.argv[1])
spec = importlib.util.module_from_spec(_s)
_s.loader.exec_module(spec)
name = sys.argv[2]
cmd = sys.argv[3:]
tu = os.path.join(ROOT, spec.TU.replace("/", os.sep))
orig = open(tu, "rb").read()
crlf = orig.count(b"\r\n") > 0


def enc(s):
    b = s.encode("utf-8").replace(b"\r\n", b"\n")
    return b.replace(b"\n", b"\r\n") if crlf else b


data = orig
for b_, r_ in spec.VARIANTS[name]:
    eb = enc(b_)
    assert data.count(eb) == 1
    data = data.replace(eb, enc(r_))
try:
    with open(tu + ".tmp", "wb") as fh:
        fh.write(data)
    os.replace(tu + ".tmp", tu)
    r = subprocess.run([sys.executable] + cmd, cwd=ROOT, capture_output=True,
                       text=True, timeout=1800)
    print(r.stdout + r.stderr)
finally:
    with open(tu + ".tmp", "wb") as fh:
        fh.write(orig)
    os.replace(tu + ".tmp", tu)
