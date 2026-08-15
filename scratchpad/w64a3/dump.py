#!/usr/bin/env python
"""W64-A3 RTL dump harness for the SYS.c ALT rung (cc1_alt 2.8.1 +
-mno-split-addresses), replicating _compile_c_272's cc1 command line exactly.

  python scratchpad/w64a3/dump.py [-dj -dJ -dR ...]
Dumps land in scratchpad/w64a3/rtl/<tu>.*  (never in build/**, which other
belts overwrite -- the w63-a3 stale-dump hazard).
"""
import os
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools"))
os.chdir(ROOT)
import build as B                                    # noqa: E402

rel = os.environ.get("W64A3_TU", "recon/syslib/psx/libgpu/SYS.c")
src = (ROOT / rel).resolve()
flags = sys.argv[1:] or ["-dj", "-dJ", "-dR", "-dl", "-dg"]
outdir = Path(__file__).resolve().parent / "rtl"
outdir.mkdir(parents=True, exist_ok=True)
tu = src.stem
i_file = outdir / (tu + ".i")
s_file = outdir / (tu + ".s")

r = subprocess.run([str(c) for c in [B.CPP, *B.CPP_FLAGS, src, "-o", i_file]],
                   capture_output=True, text=True)
if r.returncode:
    sys.exit("[cpp] " + r.stderr)

tu_flags = B.per_tu_flags(src)
ver = tu_flags.get("cc1_alt")
cc1 = B._resolve_cc1_alt(ver) if ver else B.CC1_272
tu_g_value = str(tu_flags.get("g_value", "0"))
cc1_flags = ["-quiet", "-O2", "-G" + tu_g_value, "-mgas"]
for k, f in (("no_delayed_branch", "-fno-delayed-branch"),
             ("no_strength_reduce", "-fno-strength-reduce"),
             ("signed_char", "-fsigned-char"),
             ("no_schedule_insns", "-fno-schedule-insns"),
             ("no_schedule_insns2", "-fno-schedule-insns2"),
             ("no_builtin", "-fno-builtin"),
             ("no_split_addresses", "-mno-split-addresses")):
    if tu_flags.get(k):
        cc1_flags.append(f)
cc1_flags = B._cc1_flags_for_rung(ver, cc1_flags) if ver else cc1_flags
cmd = [str(cc1), *cc1_flags, *flags, str(i_file), "-o", str(s_file)]
r = subprocess.run(cmd, capture_output=True, text=True, cwd=str(outdir))
print("cc1:", cc1)
print("cmd:", " ".join(cmd))
print("rc", r.returncode)
if r.stdout:
    print(r.stdout[-1500:])
if r.stderr:
    print(r.stderr[-1500:])
print("dumps:", sorted(p.name for p in outdir.glob(tu + ".*")))
