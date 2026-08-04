"""w48-a4 variant harness: swap ONE function's body text in a recon TU,
run the WHOLE-TU gate, restore in finally.  CRLF-preserving, absolute paths.

usage: python scratch/w48_a4_var.py <rel.c> <startmarker> <endmarker> <bodyfile> <allfns>
  startmarker/endmarker = unique literal substrings bounding the region to
  replace (inclusive of start, exclusive of end).  bodyfile = replacement text
  (LF; converted to the TU's dominant newline).
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent


def gate(rel, fns):
    import os
    if os.environ.get("SBS"):
        r = subprocess.run(
            [sys.executable, str(ROOT / "tools" / "side_by_side.py"), rel,
             os.environ["SBS"]], capture_output=True, text=True, cwd=str(ROOT))
        return (r.stdout + r.stderr).splitlines()
    r = subprocess.run(
        [sys.executable, str(ROOT / "tools" / "verify_asm.py"), rel, fns],
        capture_output=True, text=True, cwd=str(ROOT))
    return [ln.strip() for ln in (r.stdout + r.stderr).splitlines()
            if re.search(r"(PASS|FAIL|NO ORACLE|NOT IN OBJECT|Error|error:)", ln)]


def main():
    rel, start, end, bodyfile, allfns = sys.argv[1:6]
    p = ROOT / rel
    orig = p.read_text(newline="")
    nl = "\r\n" if orig.count("\r\n") > orig.count("\n") / 2 else "\n"
    assert orig.count(start) == 1, "start marker not unique: %d" % orig.count(start)
    i = orig.index(start)
    if end == "@EOF":
        j = len(orig)
    else:
        assert orig.count(end) == 1, "end marker not unique"
        j = orig.index(end)
    assert j > i
    body = Path(bodyfile).read_text().replace("\r\n", "\n").replace("\n", nl)
    try:
        p.write_text(orig[:i] + body + orig[j:], newline="")
        for ln in gate(rel, allfns):
            print(ln)
    finally:
        p.write_text(orig, newline="")
        assert p.read_text(newline="") == orig, "RESTORE FAILED"


if __name__ == "__main__":
    main()
