"""w48-a3 per-fn -fno-delayed-branch SPLICE probe harness.

Patches tools/build.py IN PLACE (additive override line appended right after
the PER_FN_NO_DELAYED_BRANCH dict literal), runs the whole-TU verify_asm gate,
then ALWAYS restores build.py in a finally block.

Usage:
    python scratch/w48_a3_probe.py <recon/path/TU.c> <fn1,fn2,...>   <allfns,...>
        arg2 = the set to SPLICE (may be empty string for a control run)
        arg3 = the whole-TU function list to GATE
"""
import subprocess, sys, os
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BUILD = ROOT / "tools" / "build.py"
MARK = "def per_fn_no_delayed_branch(src: Path) -> set:"


def main():
    rel = sys.argv[1]
    splice = [x for x in sys.argv[2].split(",") if x]
    gate = sys.argv[3]
    orig = BUILD.read_bytes()
    try:
        txt = orig.decode("utf-8")
        assert txt.count(MARK) == 1, "marker not unique"
        override = ("PER_FN_NO_DELAYED_BRANCH[%r] = set(%r)  # w48-a3 PROBE\n\n\n"
                    % (rel, splice))
        txt = txt.replace(MARK, override + MARK)
        BUILD.write_bytes(txt.encode("utf-8"))
        r = subprocess.run([sys.executable, "tools/verify_asm.py", rel, gate],
                           cwd=ROOT, capture_output=True, text=True, timeout=1200)
        for ln in (r.stdout + r.stderr).splitlines():
            if "PASS" in ln or "FAIL" in ln or "ORACLE" in ln or "OBJECT" in ln or "Error" in ln:
                print(ln)
    finally:
        BUILD.write_bytes(orig)
        assert BUILD.read_bytes() == orig


main()
