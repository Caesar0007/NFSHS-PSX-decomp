#!/usr/bin/env python3
"""W60-A1 _intrhand: g_intr_timeout storage-shape probe (catalog "STORAGE-SHAPE MENU")."""
import subprocess
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
P = ROOT / "recon/syslib/psx/libetc/INTR.c"
DECL = b"extern int g_intr_timeout[];                 /* @0x80135B90 */"

VARIANTS = {
    "unsized[]": b"extern int g_intr_timeout[];                 /* @0x80135B90 */",
    "sized[1]": b"extern int g_intr_timeout[1];                /* @0x80135B90 */",
    "sized[2]": b"extern int g_intr_timeout[2];                /* @0x80135B90 */",
    "sized[4]": b"extern int g_intr_timeout[4];                /* @0x80135B90 */",
    "vol_unsized": b"extern volatile int g_intr_timeout[];        /* @0x80135B90 */",
}

orig = P.read_bytes()
assert orig.count(DECL) == 1
try:
    for name, decl in VARIANTS.items():
        P.write_bytes(orig.replace(DECL, decl))
        r = subprocess.run([sys.executable, "tools/verify_asm.py",
                            "recon/syslib/psx/libetc/INTR.c", "_intrhand"],
                           cwd=ROOT, capture_output=True, text=True)
        line = [l for l in r.stdout.splitlines() if "_intrhand:" in l]
        print(f"{name:14} {line[0].strip() if line else r.stdout[:150]!r}")
finally:
    P.write_bytes(orig)
    assert P.read_bytes() == orig
    print("restored")
