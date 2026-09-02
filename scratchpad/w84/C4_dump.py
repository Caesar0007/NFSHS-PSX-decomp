#!/usr/bin/env python
"""W84-C4: RTL dumps for a cc1_272-lane C TU (stcdint.c).
Usage: python scratchpad/w84/C4_dump.py [dumpflags...]
Dumps land in scratchpad/w84/rtl/.
"""
import subprocess, sys, os
from pathlib import Path
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools"))
os.chdir(ROOT)
import build as B

src = ROOT / "recon/syslib/psx/libcd/stcdint.c"
flags = sys.argv[1:] or ["-dd"]
outdir = ROOT / "scratchpad" / "w84" / "rtl"
outdir.mkdir(parents=True, exist_ok=True)
tu = "stcdint"
i_file = outdir / (tu + ".i")
s_file = outdir / (tu + ".s")
tu_flags = B.per_tu_flags(src)
g = str(tu_flags.get("g_value", "0"))
r = subprocess.run([str(B.CPP), "-x", "c", "-nostdinc", "-undef",
                    "-Dmips", "-D__mips__", "-D__psx__", f"-I{B.RECON}",
                    str(src), "-o", str(i_file)], capture_output=True, text=True)
if r.returncode:
    sys.exit("[cpp] " + r.stderr)
cc1 = ["-quiet", "-O2", f"-G{g}", "-mgas"]
if tu_flags.get("no_strength_reduce"):
    cc1.append("-fno-strength-reduce")
cmd = [str(B.CC1_272), *cc1, *flags, str(i_file), "-o", str(s_file)]
r = subprocess.run(cmd, capture_output=True, text=True, cwd=str(outdir))
print("cmd:", " ".join(str(c) for c in cmd))
print("rc", r.returncode)
if r.stdout: print(r.stdout[-3000:])
if r.stderr: print(r.stderr[-3000:])
print("dumps:", sorted(p.name for p in outdir.glob(tu + ".*")))
