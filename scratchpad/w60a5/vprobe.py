"""w60-a5 variant probe: apply (old,new) text substitutions to a recon TU,
gate the whole TU, restore in a finally.

Usage: python scratchpad/w60a5/vprobe.py <rel_tu> <variants.json>
variants.json = [ {"name": "...", "subs": [[old, new], ...]}, ... ]
Line endings preserved (byte mode, exact substring match on the raw bytes).
"""
import json
import os
import subprocess
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))


def write_atomic(path, data):
    tmp = path + ".w60a5tmp"
    with open(tmp, "wb") as f:
        f.write(data)
    assert os.path.getsize(tmp) == len(data) and len(data) > 50
    os.replace(tmp, path)


def gate(tu):
    r = subprocess.run([sys.executable, "tools/tugate.py", tu],
                       cwd=ROOT, capture_output=True, text=True)
    out = [l.strip() for l in (r.stdout + r.stderr).splitlines()
           if l.strip() and "NO ORACLE" not in l]
    return " | ".join(out[-4:])


def main():
    tu = sys.argv[1]
    variants = json.load(open(sys.argv[2], encoding="utf-8"))
    path = os.path.join(ROOT, tu.replace("/", os.sep))
    with open(path, "rb") as f:
        orig = f.read()
    try:
        for v in variants:
            data = orig
            ok = True
            for old, new in v["subs"]:
                ob, nb = old.encode(), new.encode()
                if data.count(ob) != 1:
                    print("SKIP %-22s anchor count=%d %r"
                          % (v["name"], data.count(ob), old[:40]))
                    ok = False
                    break
                data = data.replace(ob, nb, 1)
            if not ok:
                continue
            write_atomic(path, data)
            print("%-22s %s" % (v["name"], gate(tu)))
            sys.stdout.flush()
    finally:
        write_atomic(path, orig)


main()
