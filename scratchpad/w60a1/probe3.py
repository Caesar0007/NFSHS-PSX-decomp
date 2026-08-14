#!/usr/bin/env python3
"""W60-A1 _intrhand round 3: from the COUNT-EXACT 116/116 basin (copy-then-in-place
timeout shape), re-sweep the pend AND-order spellings.  04Z/1121: falsifications are
basin-relative -- the round-1 ranking was measured in the 115-insn basin."""
import subprocess
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
P = ROOT / "recon/syslib/psx/libetc/INTR.c"

DECLS = b"    long c;\r\n"
TMO = (b"        c = g_intr_timeout;\r\n"
       b"        g_intr_timeout = c + 1;\r\n"
       b"        if (c >= 0x801) {\r\n")
NEW_DECLS = b"    long c;\r\n    long t;\r\n"
NEW_TMO = (b"        t = g_intr_timeout;\r\n"
           b"        c = t;\r\n"
           b"        t = t + 1;\r\n"
           b"        g_intr_timeout = t;\r\n"
           b"        if (c >= 0x801) {\r\n")

E1 = b"pend = I_MASK & (state[0x18] & I_STAT);"
E2 = b"pend = I_MASK & (g_intr.enabled & I_STAT);"

FORMS = {
    "mask_outer(cur)": (E1, E2),
    "flat_orig": (b"pend = (state[0x18] & I_STAT) & I_MASK;",
                  b"pend = (g_intr.enabled & I_STAT) & I_MASK;"),
    "inner_then_mask_2stmt": (
        b"pend = state[0x18] & I_STAT;\r\n    pend = pend & I_MASK;",
        b"pend = g_intr.enabled & I_STAT;\r\n            pend = pend & I_MASK;"),
    "mask_then_inner_2stmt": (
        b"pend = state[0x18] & I_STAT;\r\n    pend = I_MASK & pend;",
        b"pend = g_intr.enabled & I_STAT;\r\n            pend = I_MASK & pend;"),
    "istat_outer": (b"pend = I_STAT & (state[0x18] & I_MASK);",
                    b"pend = I_STAT & (g_intr.enabled & I_MASK);"),
}

orig = P.read_bytes()
assert orig.count(DECLS) == 1 and orig.count(TMO) == 1
assert orig.count(E1) == 1 and orig.count(E2) == 1
base = orig.replace(DECLS, NEW_DECLS).replace(TMO, NEW_TMO)
try:
    for name, (a, b) in FORMS.items():
        P.write_bytes(base.replace(E1, a).replace(E2, b))
        r = subprocess.run([sys.executable, "tools/verify_asm.py",
                            "recon/syslib/psx/libetc/INTR.c", "_intrhand"],
                           cwd=ROOT, capture_output=True, text=True)
        line = [l for l in r.stdout.splitlines() if "_intrhand:" in l]
        print(f"{name:24} {line[0].strip() if line else (r.stdout+r.stderr)[:200]!r}")
finally:
    P.write_bytes(orig)
    assert P.read_bytes() == orig
    print("restored")
