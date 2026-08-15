#!/usr/bin/env python3
"""W65-A7 -- derive the CONTROL script (= current linkers/nfs4.ld with the
W65-A7 change backed out) so the byte-neutrality A/B is measured on the SAME
object lists even while a peer keeps regenerating the blob placements.
"""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
txt = (ROOT / "linkers" / "nfs4.ld").read_text()

n = len(re.findall(r"^\s*build/src/\*\(.*\n", txt, re.M))
assert n == 7, f"expected 7 build/src/* catch-alls, found {n}"
ctrl = re.sub(r"^\s*build/src/\*\(.*\n", "", txt, flags=re.M)
ctrl = re.sub(r"    /\* W65-A7:.*?\*/\n", "", ctrl, flags=re.S)
old = """    /DISCARD/ :
    {
        *(.pdr); *(.reginfo); *(.MIPS.abiflags); *(.gnu.attributes);
        *(.comment); *(.mdebug*); *(.rel.dyn); *(.rel*); *(.note*);
        *(.debug*); *(.line); *(.stab*); *(.got*); *(.dyn*);
    }
}"""
assert old in ctrl
ctrl = ctrl.replace(old, """    /DISCARD/ :
    {
        *(*);
    }
}""")
out = HERE / "nfs4_ctrl.ld"
out.write_text(ctrl)
print(f"wrote {out} ({len(ctrl)} bytes, from {len(txt)})")
