#!/usr/bin/env python3
"""W65-A8  own-hunk staging for linkers/nfs4.ld (the W61 shared-file standard).

A peer belt (A5, the jump-table lane) has UNCOMMITTED rdata_* entries in the
same file.  `git add linkers/nfs4.ld` would sweep their work into my commit --
the exact hazard W64-A18 sec.8 recorded in the other direction.

This stages ONLY the hunks whose every +/- line names one of MY blob stems.
Any hunk that touches a foreign stem is left in the working tree, untouched.

  python scratchpad/w65a8/stage_own_hunks.py [--apply]
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
FILE = "linkers/nfs4.ld"
MINE = ("data_8010CCD4", "sdata_8013C54C", "front_data")


def main():
    d = subprocess.run(["git", "diff", "-U3", "--", FILE], cwd=ROOT,
                       capture_output=True, text=True).stdout
    lines = d.split("\n")
    hstart = next(i for i, L in enumerate(lines) if L.startswith("@@"))
    header, body = lines[:hstart], lines[hstart:]
    hunks, cur = [], None
    for L in body:
        if L.startswith("@@"):
            cur = [L]
            hunks.append(cur)
        elif cur is not None:
            cur.append(L)
    keep, skip = [], []
    for h in hunks:
        ch = [L for L in h[1:] if L[:1] in "+-"]
        if ch and all(any(m in L for m in MINE) for L in ch):
            keep.append(h)
        else:
            skip.append(h)
    print(f"hunks: {len(hunks)}  mine={len(keep)}  foreign(left alone)={len(skip)}")
    for h in skip:
        ch = [L for L in h[1:] if L[:1] in "+-"][:2]
        print("   SKIP " + h[0].strip() + "  e.g. " + (ch[0][:70] if ch else ""))
    if not keep:
        print("nothing of mine to stage")
        return 0
    patch = "\n".join(header + [L for h in keep for L in h]) + "\n"
    p = Path(__file__).resolve().parent / "own_hunks.patch"
    p.write_text(patch, newline="")
    if "--apply" in sys.argv:
        r = subprocess.run(["git", "apply", "--cached", "--recount",
                            "--unidiff-zero", str(p)], cwd=ROOT,
                           capture_output=True, text=True)
        print("git apply --cached rc", r.returncode, r.stderr.strip())
        return r.returncode
    print(f"(dry run) wrote {p}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
