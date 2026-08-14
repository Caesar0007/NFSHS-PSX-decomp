#!/usr/bin/env python3
"""W60-A1 _intrhand variant probe: patch the two `pend = ...` statements, gate,
restore.  Byte-mode, finally-restore, no whole-file backup restores of anyone
else's work (only this one file, and only lines this script wrote)."""
import subprocess
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
P = ROOT / "recon/syslib/psx/libetc/INTR.c"

CUR1 = b"pend = I_MASK & (state[0x18] & I_STAT);"
CUR2 = b"pend = I_MASK & (g_intr.enabled & I_STAT);"

VARIANTS = {
    "split_inner_first": (
        b"pend = state[0x18] & I_STAT;\r\n            pend = pend & I_MASK;",
        b"pend = g_intr.enabled & I_STAT;\r\n                pend = pend & I_MASK;"),
    "split_mask_first": (
        b"pend = state[0x18] & I_STAT;\r\n            pend = I_MASK & pend;",
        b"pend = g_intr.enabled & I_STAT;\r\n                pend = I_MASK & pend;"),
    "istat_first": (
        b"pend = (I_STAT & state[0x18]) & I_MASK;",
        b"pend = (I_STAT & g_intr.enabled) & I_MASK;"),
    "flat_orig": (
        b"pend = (state[0x18] & I_STAT) & I_MASK;",
        b"pend = (g_intr.enabled & I_STAT) & I_MASK;"),
}

orig = P.read_bytes()
assert orig.count(CUR1) == 1 and orig.count(CUR2) == 1
try:
    for name, (a, b) in VARIANTS.items():
        P.write_bytes(orig.replace(CUR1, a).replace(CUR2, b))
        r = subprocess.run([sys.executable, "tools/verify_asm.py",
                            "recon/syslib/psx/libetc/INTR.c", "_intrhand"],
                           cwd=ROOT, capture_output=True, text=True)
        line = [l for l in r.stdout.splitlines() if "_intrhand:" in l]
        print(f"{name:22} {line[0].strip() if line else r.stdout[:120]!r}")
finally:
    P.write_bytes(orig)
    assert P.read_bytes() == orig
    print("restored")
