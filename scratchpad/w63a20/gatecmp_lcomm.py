#!/usr/bin/env python3
"""gatecmp_lcomm.py -- run THE REAL GATE twice (stock maspsx vs .lcomm-guard
maspsx) and diff the PASS/FAIL verdicts.

12H anti-drift pattern: this loads tools/verify_asm.py's OWN SOURCE and
substitutes exactly two things --
  * `bld.OUT = bld.BUILD`  ->  a PRIVATE output dir (so a concurrent belt's
    build/ is never touched or polluted);
  * env `NFS4_MASPSX`      ->  the patched private maspsx copy.
Every normalizer, oracle lookup and alias resolution stays verify_asm's own.

usage: python gatecmp_lcomm.py <tu-rel> [<tu-rel> ...]
       (gates EVERY fn the board lists at 100% for that TU)
"""
import io
import json
import os
import re
import runpy
import sys
import contextlib
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / "tools"))       # build.py does `import fix_symsizes`
                                              # relying on being run FROM tools/
SRC = (ROOT / "tools" / "verify_asm.py").read_text()
ANCHOR = "bld.OUT = bld.BUILD"
assert SRC.count(ANCHOR) == 1
SRC_PRIV = SRC.replace(ANCHOR, 'bld.OUT = Path(os.environ["W63A20_OUT"]); bld.OUT.mkdir(parents=True, exist_ok=True)')

BOARD = {}
for ln in open(ROOT / "MATCH_PROGRESS.txt", encoding="utf-8", errors="replace"):
    m = re.match(r"^(0x[0-9A-F]+)\s+(\d+\.\d+)%\s+(\S+)\s+(\S+)\s*$", ln)
    if m and float(m.group(2)) >= 100.0:
        BOARD.setdefault(m.group(3), []).append(m.group(4))


RUNNER = HERE / "_gaterun.py"
RUNNER.write_text(
    "import os, sys\n"
    "from pathlib import Path\n"
    "ROOT = Path(r'%s')\n" % ROOT.as_posix() +
    "sys.path.insert(0, str(ROOT / 'tools'))\n"
    "SRC = open(ROOT / 'tools' / 'verify_asm.py').read().replace(\n"
    "    'bld.OUT = bld.BUILD',\n"
    "    'bld.OUT = Path(os.environ[\"W63A20_OUT\"]); bld.OUT.mkdir(parents=True, exist_ok=True)')\n"
    "sys.argv = ['verify_asm.py'] + sys.argv[1:]\n"
    "exec(compile(SRC, str(ROOT / 'tools' / 'verify_asm.py'), 'exec'),\n"
    "     {'__name__': '__main__', '__file__': str(ROOT / 'tools' / 'verify_asm.py')})\n")


def gate(rel, fns, maspsx, outdir):
    """Each gate runs in a FRESH subprocess: exec'ing verify_asm.py repeatedly
    inside ONE interpreter silently produced 0 verdict lines from the 2nd TU on
    (module-level state in the re-exec'd build.py), which would have faked a
    'no verdict moves' result -- the 12H vacuity class."""
    env = dict(os.environ, NFS4_MASPSX=str(maspsx), W63A20_OUT=str(outdir))
    import subprocess
    r = subprocess.run([sys.executable, str(RUNNER), rel, ",".join(fns)],
                       capture_output=True, text=True, env=env, cwd=str(ROOT))
    buf = io.StringIO(r.stdout + r.stderr)
    verdict = {}
    for ln in buf.getvalue().splitlines():
        m = re.match(r"^(\S+):\s+(PASS|FAIL|NO ORACLE|NOT IN OBJECT)(.*)$", ln.strip())
        if m:
            verdict[m.group(1)] = (m.group(2), m.group(3).strip())
    if not verdict:
        return verdict, r.stdout + r.stderr
    return verdict, buf.getvalue()


def main():
    STOCK = Path(r"C:/Temp/maspsx-master/maspsx.py")
    GUARD = HERE / "maspsx_lcomm" / "maspsx.py"
    moved = 0
    total = 0
    for rel in sys.argv[1:]:
        # a TU list piped in from a python-written .out file carries CRLF on
        # Windows: an unstripped '\r' made verify_asm fail to open the file and
        # print NOTHING -> every TU read "PASS=0, verdict moves=0", a textbook
        # 12H vacuous pass (only the last, \r-free, line was real).
        rel = rel.strip()
        unit = rel[len("recon/"):].rsplit(".", 1)[0]
        fns = BOARD.get(unit, [])
        if not fns:
            print(f"{rel}: no 100% board rows"); continue
        va, _ = gate(rel, fns, STOCK, HERE / "gateout_stock")
        vb, lb = gate(rel, fns, GUARD, HERE / "gateout_guard")
        diff = {k: (va.get(k), vb.get(k)) for k in set(va) | set(vb)
                if va.get(k, ("?",))[0] != vb.get(k, ("?",))[0]}
        total += len(fns)
        moved += len(diff)
        print("%-46s %3d fns  stock PASS=%d  guard PASS=%d  verdict moves=%d %s"
              % (rel[6:], len(fns),
                 sum(1 for v in va.values() if v[0] == "PASS"),
                 sum(1 for v in vb.values() if v[0] == "PASS"),
                 len(diff), diff or ""))
    print("\nTOTAL fns gated %d   verdict moves %d" % (total, moved))


main()
