"""W86-H2 variant harness (read-only w.r.t. the repo except the one candidate
file it edits and immediately restores).

usage:  python scratchpad/w86/H2_try.py <bakname> <candpath> <region> <fns> <lane> <variants.json>

variants.json = [ {"name": ..., "edits": [[old, new], ...]}, ... ]
Each variant is applied to the pristine backup text, written to <candpath>,
gated, then the backup is restored.  Byte-exact restore is asserted.
"""
import json
import os
import subprocess
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))


def read(p):
    with open(p, "rb") as f:
        return f.read()


def write(p, b):
    with open(p, "wb") as f:
        f.write(b)


def gate(region, cand, fns, lane):
    cmd = [sys.executable, "regiondiff/tools/verify_region.py", region, cand, fns,
           "--lane-as=" + lane]
    r = subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True)
    return (r.stdout or "") + (r.stderr or "")


def main():
    bak, cand, region, fns, lane, vjson = sys.argv[1:7]
    base = read(bak)
    variants = json.load(open(vjson, "r", encoding="utf-8"))
    try:
        for v in variants:
            txt = base.decode("latin-1")
            ok = True
            for old, new in v["edits"]:
                if txt.count(old) != 1:
                    print("%-34s SKIP (anchor count %d)" % (v["name"], txt.count(old)))
                    ok = False
                    break
                txt = txt.replace(old, new)
            if not ok:
                continue
            write(cand, txt.encode("latin-1"))
            out = gate(region, cand, fns, lane)
            keep = [l.rstrip() for l in out.splitlines()
                    if ("PASS" in l or "FAIL" in l or "Error" in l or "error" in l)]
            print("%-34s %s" % (v["name"], " | ".join(keep[:8])))
            sys.stdout.flush()
    finally:
        write(cand, base)
        assert read(cand) == base, "RESTORE FAILED"
        print("[restored %s]" % cand)


main()
