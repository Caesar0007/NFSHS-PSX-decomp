#!/usr/bin/env python3
"""w63a5 probe2: apply a LIST of exact replacements (JSON) to a TU, gate, restore.

    python scratchpad/w63a5/probe2.py <tu> <spec.json> FN [FN...]

spec.json = {"name": "...", "subs": [[old, new], ...], "count": {"old": n}}
Every `old` must occur exactly once unless an explicit count is given.
Restore is unconditional; the original is snapshotted to restore.log first.
"""
import json
import os
import subprocess
import sys

REPO = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
HERE = os.path.dirname(os.path.abspath(__file__))


def gate(tu, fns):
    lines = []
    for fn in fns:
        r = subprocess.run([sys.executable, os.path.join(REPO, "tools", "verify_asm.py"), tu, fn],
                           cwd=REPO, capture_output=True, text=True)
        txt = (r.stdout or "") + (r.stderr or "")
        hit = [l.strip() for l in txt.splitlines()
               if fn in l and ("PASS" in l or "FAIL" in l or "ORACLE" in l or "NOT IN" in l)]
        lines.append(hit[0] if hit else "??? " + fn)
    return lines


def main():
    tu, specp = sys.argv[1], sys.argv[2]
    fns = sys.argv[3:]
    spec = json.load(open(specp, encoding="utf-8"))
    path = os.path.join(REPO, tu)
    orig = open(path, "rb").read()
    txt = orig.decode("utf-8")
    counts = spec.get("count", {})
    for old, new in spec["subs"]:
        want = counts.get(old, 1)
        n = txt.count(old)
        if n != want:
            print("%s: ANCHOR %r count=%d want=%d -- ABORT" % (spec.get("name", "?"), old[:50], n, want))
            return 2
        txt = txt.replace(old, new)
    open(os.path.join(HERE, "restore.log"), "wb").write(orig)
    try:
        tmp = path + ".w63a5tmp"
        with open(tmp, "wb") as f:
            f.write(txt.encode("utf-8"))
        assert os.path.getsize(tmp) > len(orig) // 2
        os.replace(tmp, path)
        res = gate(tu, fns)
    finally:
        with open(path + ".w63a5tmp", "wb") as f:
            f.write(orig)
        os.replace(path + ".w63a5tmp", path)
    assert open(path, "rb").read() == orig
    print("[%s] %s" % (spec.get("name", "?"), " | ".join(res)))
    return 0


if __name__ == "__main__":
    sys.exit(main())
