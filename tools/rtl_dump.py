#!/usr/bin/env python
"""RTL dump helper: cpp -> CC1PLPSX with -dg/-dl/-dL for one recon C++ TU.
Usage: python scratch/rtl_a7.py <recon/path/tu.cpp> [dumpflags...]
Dumps land in scratch/rtl/<tuname>.* (cc1 names them after the -o base).
"""
import subprocess, sys, os
from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
os.chdir(ROOT)
import build as B

src = Path(sys.argv[1]).resolve()
flags = sys.argv[2:] or ["-dg", "-dl", "-dL"]
outdir = ROOT / "scratch" / "rtl"
outdir.mkdir(parents=True, exist_ok=True)
tu = src.stem
i_file = outdir / (tu + ".i")
s_file = outdir / (tu + ".s")
tu_flags = B.per_tu_flags(src)
g = str(tu_flags.get("g_value", B.G_VALUE))
r = subprocess.run([str(B.CPP), "-x", "c", "-D__cplusplus=1", "-nostdinc", "-undef",
                    "-Dmips", "-D__mips__", "-D__psx__", f"-I{B.RECON}",
                    str(src), "-o", str(i_file)], capture_output=True, text=True)
if r.returncode:
    sys.exit("[cpp] " + r.stderr)
cc1 = ["-quiet", "-O2", f"-G{g}"]
for k, f in (("no_delayed_branch", "-fno-delayed-branch"),
             ("no_split_addresses", "-mno-split-addresses"),
             ("no_schedule_insns", "-fno-schedule-insns"),
             ("no_schedule_insns2", "-fno-schedule-insns2"),
             ("no_strength_reduce", "-fno-strength-reduce")):
    if tu_flags.get(k):
        cc1.append(f)
cmd = [str(B.CC1PL), *cc1, *flags, str(i_file), "-o", str(s_file)]
r = subprocess.run(cmd, capture_output=True, text=True, cwd=str(outdir))
print("cmd:", " ".join(cmd))
print("rc", r.returncode)
if r.stdout: print(r.stdout[-3000:])
if r.stderr: print(r.stderr[-3000:])
print("dumps:", sorted(p.name for p in outdir.glob(tu + ".*")))
