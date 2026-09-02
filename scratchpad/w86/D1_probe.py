#!/usr/bin/env python
"""W86-D1 probe driver: apply a text edit to a recon TU, gate, always restore.

usage: python D1_probe.py <file> <spec.json>
spec.json = {"label": str, "edits": [[old, new], ...], "fns": [names] or null}
If fns is null -> whole-TU tugate.  Always restores the file.
"""
import json
import os
import subprocess
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))


def gate(path, fns):
    env = dict(os.environ)
    env["NFS4_SOURCE_ONLY"] = "1"
    if fns:
        cmd = [sys.executable, "tools/verify_asm.py", path] + [",".join(fns)]
    else:
        cmd = [sys.executable, "tools/tugate.py", path]
    p = subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True, env=env)
    return (p.stdout or "") + (p.stderr or "")


def main():
    path = sys.argv[1]
    spec = json.load(open(sys.argv[2]))
    full = os.path.join(ROOT, path)
    orig = open(full, "rb").read()
    txt = orig.decode("utf-8", "surrogateescape")
    try:
        new = txt
        for old, rep in spec["edits"]:
            if old not in new:
                old2 = old.replace("\r\n", "\n").replace("\n", "\r\n")
                rep2 = rep.replace("\r\n", "\n").replace("\n", "\r\n")
                if old2 not in new:
                    print("MISS: %r" % old[:90])
                    return 2
                old, rep = old2, rep2
            new = new.replace(old, rep, 1)
        open(full, "wb").write(new.encode("utf-8", "surrogateescape"))
        if os.environ.get("D1_SAVE"):
            open(os.environ["D1_SAVE"], "wb").write(new.encode("utf-8", "surrogateescape"))
        out = gate(path, spec.get("fns"))
        print("### %s" % spec.get("label", "?"))
        print(out.strip())
    finally:
        open(full, "wb").write(orig)
    return 0


if __name__ == "__main__":
    sys.exit(main())
