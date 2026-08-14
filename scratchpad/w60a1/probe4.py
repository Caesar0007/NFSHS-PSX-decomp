#!/usr/bin/env python3
"""W60-A1 _intrhand round 4 -- driven by qty272/reqdelta272, not by guessing.

DIAGNOSIS (instrument output, not a hypothesis):
  pseudo 74 = `pend` (reg/v:SI, set by both `and`s, tested by both branches,
              copied into 73 = `s0`);  pseudo 105 = the indirect callback
              pointer `*p` in the inner loop.
  272-rule priorities: 105 = 3*9/3 = 9.0000 (rank 0, takes $v0)
                        74 = 3*9/6 = 4.5000 (rank 1, takes $a0)
  Retail wants `pend` in $v0.  reqdelta272 prices the flip at refs 9->16 (+7,
  crossing a floor_log2 step) OR live 6->2 (-4) -- AND flags that 74 carries a
  hard-reg PREFERENCE $a0, which find_reg honours BEFORE the numeric scan, so
  no priority dial alone can move it.
So: (A) kill the preference (opacity fence = asm_operands def), (B) shorten
74's live range by sinking the `s0 = pend` copy past the test, (C) both.
"""
import subprocess
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
P = ROOT / "recon/syslib/psx/libetc/INTR.c"

E1 = (b"    pend = I_MASK & (state[0x18] & I_STAT);\r\n"
      b"    s0 = (unsigned short)pend;\r\n"
      b"    if (pend != 0) {\r\n")
E2 = (b"            pend = I_MASK & (g_intr.enabled & I_STAT);\r\n"
      b"            s0 = (unsigned short)pend;\r\n"
      b"        } while (pend != 0);\r\n")

FENCE = b'    __asm__("" : "=r"(pend) : "0"(pend));\r\n'

VARIANTS = {
    "baseline": (E1, E2),
    "A_fence_both": (
        E1.replace(b"    s0 = (unsigned short)pend;\r\n",
                   FENCE + b"    s0 = (unsigned short)pend;\r\n"),
        E2.replace(b"            s0 = (unsigned short)pend;\r\n",
                   b'            __asm__("" : "=r"(pend) : "0"(pend));\r\n'
                   b"            s0 = (unsigned short)pend;\r\n")),
    "A_fence_entry_only": (
        E1.replace(b"    s0 = (unsigned short)pend;\r\n",
                   FENCE + b"    s0 = (unsigned short)pend;\r\n"),
        E2),
    "B_sink_copy": (
        b"    pend = I_MASK & (state[0x18] & I_STAT);\r\n"
        b"    if (pend != 0) {\r\n"
        b"        s0 = (unsigned short)pend;\r\n",
        E2),
    "C_both": (
        b"    pend = I_MASK & (state[0x18] & I_STAT);\r\n"
        b"    if (pend != 0) {\r\n"
        b'        __asm__("" : "=r"(pend) : "0"(pend));\r\n'
        b"        s0 = (unsigned short)pend;\r\n",
        E2.replace(b"            s0 = (unsigned short)pend;\r\n",
                   b'            __asm__("" : "=r"(pend) : "0"(pend));\r\n'
                   b"            s0 = (unsigned short)pend;\r\n")),
}

orig = P.read_bytes()
assert orig.count(E1) == 1 and orig.count(E2) == 1
try:
    for name, (a, b) in VARIANTS.items():
        P.write_bytes(orig.replace(E1, a).replace(E2, b))
        r = subprocess.run([sys.executable, "tools/verify_asm.py",
                            "recon/syslib/psx/libetc/INTR.c", "_intrhand"],
                           cwd=ROOT, capture_output=True, text=True)
        line = [l for l in r.stdout.splitlines() if "_intrhand:" in l]
        print(f"{name:22} {line[0].strip() if line else (r.stdout+r.stderr)[:200]!r}")
finally:
    P.write_bytes(orig)
    assert P.read_bytes() == orig
    print("restored")
