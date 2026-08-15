#!/usr/bin/env python3
"""w63a5 probe: apply an exact byte replacement to a TU, gate N functions, restore.

Usage:
    python scratchpad/w63a5/probe.py <tu> <old_file> <new_file> FN [FN...]
The old/new snippets are read from files (never heredocs -- W61 hazard #14).
Restore is unconditional (finally), and the harness writes a restore log BEFORE
any print so a truncating pipe cannot leave a patched source on disk.
"""
import os
import subprocess
import sys

REPO = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))


def gate(tu, fns):
    out = {}
    for fn in fns:
        r = subprocess.run([sys.executable, os.path.join(REPO, "tools", "verify_asm.py"), tu, fn],
                           cwd=REPO, capture_output=True, text=True)
        txt = (r.stdout or "") + (r.stderr or "")
        line = ""
        for ln in txt.splitlines():
            if fn in ln and ("PASS" in ln or "FAIL" in ln or "NO ORACLE" in ln or "NOT IN" in ln):
                line = ln.strip()
                break
        out[fn] = line or txt.strip().splitlines()[:1]
    return out


def main():
    tu = sys.argv[1]
    old = open(sys.argv[2], "rb").read()
    new = open(sys.argv[3], "rb").read()
    fns = sys.argv[4:]
    path = os.path.join(REPO, tu)
    orig = open(path, "rb").read()
    n = orig.count(old)
    if n != 1:
        print("ANCHOR COUNT = %d (must be 1) -- aborting" % n)
        return 2
    logp = os.path.join(os.path.dirname(os.path.abspath(__file__)), "restore.log")
    open(logp, "wb").write(orig)
    try:
        patched = orig.replace(old, new, 1)
        assert patched != orig
        tmp = path + ".w63a5tmp"
        with open(tmp, "wb") as f:
            f.write(patched)
        assert os.path.getsize(tmp) > 0
        os.replace(tmp, path)
        res = gate(tu, fns)
    finally:
        with open(path + ".w63a5tmp", "wb") as f:
            f.write(orig)
        os.replace(path + ".w63a5tmp", path)
    assert open(path, "rb").read() == orig
    for fn in fns:
        print(res[fn])
    return 0


if __name__ == "__main__":
    sys.exit(main())
