"""w48-a4: sweep N candidate bodies for ONE function through the gate.

usage: python scratch/w48_a4_sweep.py <rel.c> <start> <end> <allfns> <targetfn> <dir-with-*.txt>
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent


def main():
    rel, start, end, allfns, target, vdir = sys.argv[1:7]
    p = ROOT / rel
    orig = p.read_text(newline="")
    nl = "\r\n" if orig.count("\r\n") > orig.count("\n") / 2 else "\n"
    assert orig.count(start) == 1
    i = orig.index(start)
    j = len(orig) if end == "@EOF" else orig.index(end)
    try:
        for f in sorted(Path(vdir).glob("*.txt")):
            body = f.read_text().replace("\r\n", "\n").replace("\n", nl)
            p.write_text(orig[:i] + body + orig[j:], newline="")
            r = subprocess.run(
                [sys.executable, str(ROOT / "tools" / "verify_asm.py"), rel, allfns],
                capture_output=True, text=True, cwd=str(ROOT))
            lines = [ln.strip() for ln in (r.stdout + r.stderr).splitlines()
                     if re.search(r"(PASS|FAIL|NOT IN OBJECT|error)", ln)]
            tgt = [l for l in lines if l.startswith(target + ":")]
            other = [l for l in lines if not l.startswith(target + ":")]
            print("%-28s %s   | others: %s" % (
                f.name, tgt[0] if tgt else (lines[:1] or ["?"])[0],
                " ".join(l.split(": ")[1].split(" diffs")[0] for l in other)))
    finally:
        p.write_text(orig, newline="")
        assert p.read_text(newline="") == orig, "RESTORE FAILED"


if __name__ == "__main__":
    main()
