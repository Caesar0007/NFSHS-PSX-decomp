#!/usr/bin/env python3
"""w47_a7_probe.py TU FN,FN,... -- gate a whole TU at each -G and print deltas.

Runs tools/verify_asm.py once per candidate -G value with the g_value override
injected through build.py's NFS4_PROBE_G hook (no table edit -> a timeout-killed
probe cannot leave the tree dirty).  Reports PASS count and total diff bytes so
a -G verdict can be judged on the WHOLE TU, never one function.
"""
import os, re, subprocess, sys
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent
tu, fns = sys.argv[1], sys.argv[2]
gs = sys.argv[3].split(",") if len(sys.argv) > 3 else ["4", "0", "2", "8"]
base = None
for g in gs:
    env = dict(os.environ, NFS4_PROBE_G=f"{tu}={g}")
    r = subprocess.run([sys.executable, str(ROOT / "tools" / "verify_asm.py"), tu, fns],
                       capture_output=True, text=True, env=env, cwd=ROOT, timeout=600)
    out = r.stdout + r.stderr
    npass = len(re.findall(r": PASS", out))
    diffs = sum(int(m) for m in re.findall(r"FAIL (\d+) diffs", out))
    nfail = len(re.findall(r"FAIL \d+ diffs", out))
    tag = f"-G{g:<2}  PASS={npass:3d}  FAIL={nfail:3d}  DIFFS={diffs:5d}"
    if base is None:
        base = (npass, diffs); print(tag + "   (baseline)")
    else:
        print(tag + f"   dPASS={npass-base[0]:+d}  dDIFFS={diffs-base[1]:+d}")
    if "NO ORACLE" in out or r.returncode:
        print("   !! " + out.strip().splitlines()[-1][:120])
