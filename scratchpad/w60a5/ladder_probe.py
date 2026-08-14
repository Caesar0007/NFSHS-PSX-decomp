"""w60-a5: ladder the PER_FN_CC1_VER_SPLICE rung for one fn, whole-TU gated.

Usage: python scratchpad/w60a5/ladder_probe.py <rel_tu> <ver> [<ver> ...]
Rewrites ONLY the quoted rung string inside the PER_FN_CC1_VER_SPLICE entry
for <rel_tu> (atomic temp + os.replace), runs tools/tugate.py, restores the
original file in a finally.
"""
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
    vers = sys.argv[2:]
    with open(BUILD, "rb") as f:
        orig = f.read()
    key = ('"%s": {"' % tu).encode()
    i = orig.find(key)
    assert i != -1, "TU not found in PER_FN_CC1_VER_SPLICE"
    start = i + len(key)
    end = orig.find(b'"', start)
    try:
        for v in vers:
            new = orig[:start] + v.encode() + orig[end:]
            write_atomic(BUILD, new)
            r = subprocess.run([sys.executable, "tools/tugate.py", tu],
                               cwd=ROOT, capture_output=True, text=True)
            out = [l for l in (r.stdout + r.stderr).splitlines()
                   if l.strip() and "NO ORACLE" not in l]
            print("RUNG %-14s %s" % (v, " | ".join(x.strip() for x in out[-4:])))
            sys.stdout.flush()
    finally:
        write_atomic(BUILD, orig)


main()
