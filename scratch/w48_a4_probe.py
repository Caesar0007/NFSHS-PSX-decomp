"""w48-a4 probe harness: per-FUNCTION -fno-delayed-branch splice probe.

Patches tools/build.py's PER_FN_NO_DELAYED_BRANCH dict IN PLACE (adding the
requested file->{fns} entry), runs the WHOLE-TU verify_asm gate, then restores
build.py in a finally block.  Report-only: nothing is ever left on disk.

usage:  python scratch/w48_a4_probe.py <recon-rel-path> <fn>[,<fn>...] <allfns>
        (allfns = comma list gated for the whole-TU report)
"""
import io
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
BUILD = ROOT / "tools" / "build.py"
ANCHOR = "PER_FN_NO_DELAYED_BRANCH = {\n"


def gate(rel, fns):
    r = subprocess.run(
        [sys.executable, str(ROOT / "tools" / "verify_asm.py"), rel, fns],
        capture_output=True, text=True, cwd=str(ROOT))
    out = []
    for ln in (r.stdout + r.stderr).splitlines():
        if re.search(r"(PASS|FAIL|NO ORACLE|NOT IN OBJECT)", ln):
            out.append(ln.strip())
    return out


def main():
    rel, probe_fns, all_fns = sys.argv[1], sys.argv[2], sys.argv[3]
    orig = BUILD.read_text(newline="")
    assert ANCHOR in orig or ANCHOR.replace("\n", "\r\n") in orig, "anchor missing"
    nl = "\r\n" if ANCHOR.replace("\n", "\r\n") in orig else "\n"
    anchor = ANCHOR.replace("\n", nl)
    ins = ('    "%s": {%s},%s'
           % (rel, ", ".join('"%s"' % f for f in probe_fns.split(",")), nl))
    # a duplicate key later in the literal WINS in python, so append ours after
    # the anchor is wrong -> instead insert just before the closing brace of the
    # dict so it overrides any pre-existing entry for the same file.
    idx = orig.index(anchor)
    close = orig.index(nl + "}" + nl, idx)
    patched = orig[:close + len(nl)] + ins + orig[close + len(nl):]
    try:
        BUILD.write_text(patched, newline="")
        for ln in gate(rel, all_fns):
            print(ln)
    finally:
        BUILD.write_text(orig, newline="")
        assert BUILD.read_text(newline="") == orig


if __name__ == "__main__":
    main()
