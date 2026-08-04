"""w48-a4 flag probe: add PER_TU_FLAGS keys for ONE TU, whole-TU gate, restore.

usage: python scratch/w48_a4_flag.py <rel.c> <key=val,...|-> <allfns>
  key=val: no_split_addresses=1, no_delayed_branch=1, no_schedule_insns=1,
           no_schedule_insns2=1, g_value=0 ...
  '-' = baseline (no patch).
PER_TU_FLAGS is a dict LITERAL: a duplicate key silently DISCARDS the earlier
entry, so we MERGE with any pre-existing entry for the same TU (w47 04G hazard).
"""
import ast
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
BUILD = ROOT / "tools" / "build.py"


def gate(rel, fns):
    r = subprocess.run(
        [sys.executable, str(ROOT / "tools" / "verify_asm.py"), rel, fns],
        capture_output=True, text=True, cwd=str(ROOT))
    return [ln.strip() for ln in (r.stdout + r.stderr).splitlines()
            if re.search(r"(PASS|FAIL|NOT IN OBJECT|error)", ln)]


def main():
    rel, spec, allfns = sys.argv[1:4]
    orig = BUILD.read_text(newline="")
    nl = "\r\n" if orig.count("\r\n") > 100 else "\n"
    patched = orig
    if spec != "-":
        sys.path.insert(0, str(ROOT / "tools"))
        import importlib.util
        s = importlib.util.spec_from_file_location("bld", BUILD)
        m = importlib.util.module_from_spec(s)
        s.loader.exec_module(m)
        merged = dict(m.PER_TU_FLAGS.get(rel, {}))
        for kv in spec.split(","):
            k, v = kv.split("=")
            merged[k] = v if k == "g_value" else True
        anchor = "PER_TU_FLAGS = {" + nl
        i = orig.index(anchor)
        close = orig.index(nl + "}" + nl, i)
        ins = "    %r: %r,%s" % (rel, merged, nl)
        patched = orig[:close + len(nl)] + ins + orig[close + len(nl):]
    try:
        BUILD.write_text(patched, newline="")
        for ln in gate(rel, allfns):
            print(ln)
    finally:
        BUILD.write_text(orig, newline="")
        assert BUILD.read_text(newline="") == orig, "RESTORE FAILED"


if __name__ == "__main__":
    main()
