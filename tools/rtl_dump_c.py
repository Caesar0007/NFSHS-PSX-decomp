#!/usr/bin/env python
"""RTL dump helper for a C-LANE recon TU (CC1PSX).  Twin of tools/rtl_dump.py,
which only drives CC1PLPSX.  Usage:
    python scratch/rtl_c_a5.py recon/frontend/psx/memcard.c [-dL -dl -dg ...]
Dumps land in scratch/rtl_a5/<tu>.* (cc1 names them after the -o base).
"""
import subprocess, sys, os
from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
os.chdir(ROOT)
import build as B

src = Path(sys.argv[1]).resolve()
flags = sys.argv[2:] or ["-dg", "-dl", "-dL"]
outdir = ROOT / "scratch" / "rtl_a5"
outdir.mkdir(parents=True, exist_ok=True)
tu = src.stem
i_file = outdir / (tu + ".i")
s_file = outdir / (tu + ".s")
tu_flags = B.per_tu_flags(src)
r = subprocess.run([str(c) for c in [B.CPP, *B.CPP_FLAGS, src, "-o", i_file]],
                   capture_output=True, text=True)
if r.returncode:
    sys.exit("[cpp] " + r.stderr)
cc1 = list(B.CC1_FLAGS)
for k, f in (("no_delayed_branch", "-fno-delayed-branch"),
             ("no_split_addresses", "-mno-split-addresses"),
             ("no_schedule_insns", "-fno-schedule-insns"),
             ("no_schedule_insns2", "-fno-schedule-insns2"),
             ("no_strength_reduce", "-fno-strength-reduce")):
    if tu_flags.get(k):
        cc1.append(f)
cmd = [str(B.CC1), *cc1, *flags, str(i_file), "-o", str(s_file)]
r = subprocess.run(cmd, capture_output=True, text=True, cwd=str(outdir))
print("cmd:", " ".join(cmd))
print("rc", r.returncode)
if r.stdout: print(r.stdout[-2000:])
if r.stderr: print(r.stderr[-2000:])
print("dumps:", sorted(p.name for p in outdir.glob(tu + ".*")))
