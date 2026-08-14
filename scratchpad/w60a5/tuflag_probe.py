"""w60-a5: probe PER_TU_FLAGS variants for one TU (atomic rewrite + restore).

Usage: python scratchpad/w60a5/tuflag_probe.py <rel_tu> '<dict literal>' ...
Each argument after the TU is the replacement flag-dict TEXT, e.g.
  '{"cc1_272": True, "no_schedule_insns": True}'
The TU must already have a PER_TU_FLAGS entry in tools/build.py.
"""
import ast
import os
import re
import subprocess
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
BUILD = os.path.join(ROOT, "tools", "build.py")


def write_atomic(path, data):
    tmp = path + ".w60a5tmp"
    with open(tmp, "wb") as f:
        f.write(data)
    assert os.path.getsize(tmp) > 1000
    os.replace(tmp, path)


def main():
    tu = sys.argv[1]
    variants = sys.argv[2:]
    with open(BUILD, "rb") as f:
        orig = f.read()
    pat = re.compile((r'("%s":\s*)(\{[^}]*\})' % re.escape(tu)).encode())
    m = pat.search(orig)
    assert m, "no PER_TU_FLAGS entry for " + tu
    try:
        for v in variants:
            new = orig[:m.start(2)] + v.encode() + orig[m.end(2):]
            ast.parse(new.decode("utf-8", "replace"))
            write_atomic(BUILD, new)
            r = subprocess.run([sys.executable, "tools/tugate.py", tu],
                               cwd=ROOT, capture_output=True, text=True)
            out = [l.strip() for l in (r.stdout + r.stderr).splitlines()
                   if l.strip() and "NO ORACLE" not in l]
            print("%-52s %s" % (v, " | ".join(out[-4:])))
            sys.stdout.flush()
    finally:
        write_atomic(BUILD, orig)


main()
