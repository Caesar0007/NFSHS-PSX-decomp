#!/usr/bin/env python3
"""brdist_tree.py -- TREE-WIDE per-branch DISTANCE census (the gate blind spot).

Runs tools/brdist.py (loaded from source at run time, so it is always the
shipped logic -- including the w63-a15 vacuity fix) over every recon TU that has
board rows.  Two deviations, both mechanical:

  * the object goes to a PRIVATE output dir (env W63A20_OUT) instead of build/,
    so this census neither reads nor writes the tree the 17 live belts are
    churning -- every TU is compiled FRESH by verify_asm's own front end;
  * each TU runs in its own subprocess (brdist.py is a script, and re-exec'ing
    verify_asm inside one interpreter drops output from the 2nd TU on).

usage: python brdist_tree.py <out.txt> [--only <substr>]
"""
import os
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
HERE = Path(__file__).resolve().parent
OUTDIR = HERE / "brdistout"

RUNNER = HERE / "_brdistrun.py"   # written with the Write tool (heredoc/
                                  # generated-source hazards: 13F)
assert RUNNER.exists()


def board_units():
    units = set()
    for ln in open(ROOT / "MATCH_PROGRESS.txt", encoding="utf-8", errors="replace"):
        m = re.match(r"^(0x[0-9A-F]+)\s+(\d+\.\d+)%\s+(\S+)\s+(\S+)\s*$", ln)
        if m:
            units.add(m.group(3))
    rels = []
    for u in sorted(units):
        for ext in (".cpp", ".c"):
            p = ROOT / "recon" / (u + ext)
            if p.exists():
                rels.append(p.relative_to(ROOT).as_posix())
                break
    return rels


def main():
    out = open(sys.argv[1], "w", encoding="utf-8")
    only = sys.argv[sys.argv.index("--only") + 1] if "--only" in sys.argv else None
    rels = [r for r in board_units() if not only or only in r]
    OUTDIR.mkdir(parents=True, exist_ok=True)
    tot_fns = tot_bad = tu_fail = 0
    for i, rel in enumerate(rels, 1):
        env = dict(os.environ, W63A20_OUT=str(OUTDIR))
        r = subprocess.run([sys.executable, str(RUNNER), rel],
                           capture_output=True, text=True, env=env, cwd=str(ROOT))
        body = r.stdout.strip()
        m = re.search(r"# (\d+) fns checked, (\d+) with branch-offset/count divergence", body)
        if not m:
            tu_fail += 1
            out.write("### %s  TU FAIL\n%s\n" % (rel, (r.stdout + r.stderr).strip()[:600]))
            print("[%d/%d] %-52s TU FAIL" % (i, len(rels), rel[6:]), flush=True)
            out.flush()
            continue
        nf, nb = int(m.group(1)), int(m.group(2))
        tot_fns += nf
        tot_bad += nb
        out.write("### %s  (%d fns, %d divergent)\n" % (rel, nf, nb))
        if nb:
            out.write(body + "\n")
        out.flush()
        print("[%d/%d] %-52s %4d fns  %2d divergent" % (i, len(rels), rel[6:], nf, nb),
              flush=True)
    out.write("\nTOTAL: %d TUs, %d fns checked, %d divergent, %d TU failures\n"
              % (len(rels), tot_fns, tot_bad, tu_fail))
    out.close()
    print("TOTAL: %d TUs, %d fns, %d divergent, %d TU failures"
          % (len(rels), tot_fns, tot_bad, tu_fail))


main()
