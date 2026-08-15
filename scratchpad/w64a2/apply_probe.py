"""Apply a list of (old,new) byte pairs to a file, run a command, restore.
Usage: python apply_probe.py <patchmodule> <variantname> -- <cmd...>
The patch module must expose VARIANTS: dict name -> list[(old,new)] and SRC.
"""
import importlib.util, os, subprocess, sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
mod_path, name = sys.argv[1], sys.argv[2]
assert sys.argv[3] == "--"
cmd = sys.argv[4:]

spec = importlib.util.spec_from_file_location("patchmod", mod_path)
mod = importlib.util.module_from_spec(spec)
spec.loader.exec_module(mod)

full = os.path.join(ROOT, mod.SRC)
orig = open(full, "rb").read()
crlf = orig.count(b"\r\n") > orig.count(b"\n") // 2


def fix(b):
    if crlf and b"\r\n" not in b:
        return b.replace(b"\n", b"\r\n")
    return b


data = orig
try:
    for old, new in mod.VARIANTS[name]:
        old, new = fix(old), fix(new)
        assert data.count(old) == 1, ("anchor count %d for %r" % (data.count(old), old[:60]))
        data = data.replace(old, new)
    tmp = full + ".probetmp"
    open(tmp, "wb").write(data)
    os.replace(tmp, full)
    r = subprocess.run(cmd, cwd=ROOT)
finally:
    tmp = full + ".probetmp"
    open(tmp, "wb").write(orig)
    os.replace(tmp, full)
    assert open(full, "rb").read() == orig
    sys.stderr.write("(restored)\n")
