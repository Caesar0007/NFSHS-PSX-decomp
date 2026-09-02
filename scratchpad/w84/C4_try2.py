#!/usr/bin/env python
"""W84-C4: like C4_try.py but prints the FULL cc1 .s body and the sbs diff."""
import subprocess, sys, os, re, shutil
from pathlib import Path
ROOT = Path(__file__).resolve().parents[2]
os.chdir(ROOT)
sys.path.insert(0, str(ROOT / "scratchpad" / "w84"))
import importlib.util
spec = importlib.util.spec_from_file_location("c4try", ROOT / "scratchpad/w84/C4_try.py")
m = importlib.util.module_from_spec(spec); spec.loader.exec_module(m)

BAK = ROOT / "scratchpad/w84/C4_stcdint_backup.c"
SRC = ROOT / "recon/syslib/psx/libcd/stcdint.c"

name = sys.argv[1]
what = sys.argv[2] if len(sys.argv) > 2 else "s"
try:
    m.apply(name)
    print("### VARIANT", name)
    print(m.gate())
    if what in ("s", "both"):
        subprocess.run([sys.executable, "scratchpad/w84/C4_dump.py"],
                       capture_output=True, text=True)
        s = (ROOT / "scratchpad/w84/rtl/stcdint.s").read_text(errors="replace")
        mm = re.search(r"^_st_dma:.*?\n\t\.end", s, re.S | re.M)
        print("--- cc1 .s ---")
        print(mm.group(0) if mm else "(not found)")
    if what in ("d", "both"):
        r = subprocess.run([sys.executable, "tools/sbs.py",
                            "recon/syslib/psx/libcd/stcdint.c", "_st_dma"],
                           capture_output=True, text=True)
        print(r.stdout)
finally:
    shutil.copyfile(BAK, SRC)
