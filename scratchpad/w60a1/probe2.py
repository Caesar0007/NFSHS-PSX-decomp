#!/usr/bin/env python3
"""W60-A1 _intrhand round 2: the timeout read-then-store copy shape + the
final (I_STAT & I_MASK) operand order."""
import subprocess
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
P = ROOT / "recon/syslib/psx/libetc/INTR.c"

DECLS = b"    long c;\r\n"
TMO = (b"        c = g_intr_timeout;\r\n"
       b"        g_intr_timeout = c + 1;\r\n"
       b"        if (c >= 0x801) {\r\n")
TEST = b"    if ((I_STAT & I_MASK) != 0) {\r\n"

VARIANTS = {
    "baseline": (DECLS, TMO, TEST),
    "copy_then_inplace": (
        b"    long c;\r\n    long t;\r\n",
        b"        t = g_intr_timeout;\r\n"
        b"        c = t;\r\n"
        b"        t = t + 1;\r\n"
        b"        g_intr_timeout = t;\r\n"
        b"        if (c >= 0x801) {\r\n",
        TEST),
    "copy_then_inplace_incr": (
        b"    long c;\r\n    long t;\r\n",
        b"        t = g_intr_timeout;\r\n"
        b"        c = t;\r\n"
        b"        g_intr_timeout = t + 1;\r\n"
        b"        if (c >= 0x801) {\r\n",
        TEST),
    "mask_first_test": (DECLS, TMO, b"    if ((I_MASK & I_STAT) != 0) {\r\n"),
    "both": (
        b"    long c;\r\n    long t;\r\n",
        b"        t = g_intr_timeout;\r\n"
        b"        c = t;\r\n"
        b"        t = t + 1;\r\n"
        b"        g_intr_timeout = t;\r\n"
        b"        if (c >= 0x801) {\r\n",
        b"    if ((I_MASK & I_STAT) != 0) {\r\n"),
}

orig = P.read_bytes()
for k, v in (("DECLS", DECLS), ("TMO", TMO), ("TEST", TEST)):
    assert orig.count(v) == 1, (k, orig.count(v))
try:
    for name, (d, t, s) in VARIANTS.items():
        P.write_bytes(orig.replace(DECLS, d).replace(TMO, t).replace(TEST, s))
        r = subprocess.run([sys.executable, "tools/verify_asm.py",
                            "recon/syslib/psx/libetc/INTR.c", "_intrhand"],
                           cwd=ROOT, capture_output=True, text=True)
        line = [l for l in r.stdout.splitlines() if "_intrhand:" in l]
        print(f"{name:22} {line[0].strip() if line else (r.stdout + r.stderr)[:200]!r}")
finally:
    P.write_bytes(orig)
    assert P.read_bytes() == orig
    print("restored")
