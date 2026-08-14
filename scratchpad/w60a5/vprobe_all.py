"""w60-a5 variant probe (replace-ALL occurrences variant of vprobe.py).

Usage: python scratchpad/w60a5/vprobe_all.py <rel_tu> <variants.json>
variants.json = [ {"name": ..., "subs": [[old, new, expected_count], ...]}, ... ]
expected_count is optional; when given it is asserted.
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
            for sub in v["subs"]:
                old, new = sub[0], sub[1]
                ob, nb = old.encode(), new.encode()
                n = data.count(ob)
                if n == 0 or (len(sub) > 2 and n != sub[2]):
                    print("SKIP %-24s count=%d %r" % (v["name"], n, old[:40]))
                    ok = False
                    break
                data = data.replace(ob, nb)
            if not ok:
                continue
            write_atomic(path, data)
            r = subprocess.run([sys.executable, "tools/tugate.py", tu],
                               cwd=ROOT, capture_output=True, text=True)
            out = [l.strip() for l in (r.stdout + r.stderr).splitlines()
                   if l.strip() and "NO ORACLE" not in l]
            print("%-24s %s" % (v["name"], " | ".join(out[-4:])))
            sys.stdout.flush()
    finally:
        write_atomic(path, orig)


main()
