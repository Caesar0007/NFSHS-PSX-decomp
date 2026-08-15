#!/usr/bin/env python3
"""Show the .text instruction differences the .lcomm guard causes in one TU
(objdump -dr both objects, side by side)."""
import importlib.util
import re
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
src = (ROOT / "scratchpad/w63a20/lcomm_probe.py").read_text().replace("\nmain()\n", "\n")
ns = {"__name__": "probe", "__file__": str(ROOT / "scratchpad/w63a20/lcomm_probe.py")}
exec(compile(src, "probe", "exec"), ns)
bp = ns["bp"]
OBJDUMP = Path(bp.MIPS) / "mipsel-none-elf-objdump.exe"

rel = sys.argv[1] if len(sys.argv) > 1 else "recon/frontend/common/screencarselect.cpp"
is_cpp = rel.endswith(".cpp")
g = str(bp.per_tu_flags(ROOT / rel).get("g_value", bp.G_VALUE))
s_text = (ROOT / "build" / (rel + ".s")).read_text()
if is_cpp:
    s_text = s_text.replace("_._", "___")

td = tempfile.mkdtemp()
dis = {}
for tag, m in (("stock", ns["STOCK"]), ("guard", ns["GUARD"])):
    o = Path(td) / (tag + ".o")
    r = ns["run_maspsx"](m, s_text, g, is_cpp, o)
    assert o.exists(), r.stderr[:400]
    d = subprocess.run([str(OBJDUMP), "-dr", "-j", ".text", str(o)],
                       capture_output=True, text=True).stdout
    dis[tag] = [l for l in d.splitlines() if re.match(r"^\s*[0-9a-f]+:", l)
                or "R_MIPS" in l]

a, b = dis["stock"], dis["guard"]
print("stock lines %d  guard lines %d" % (len(a), len(b)))
n = 0
for i in range(max(len(a), len(b))):
    x = a[i] if i < len(a) else "<eof>"
    y = b[i] if i < len(b) else "<eof>"
    if x != y:
        n += 1
        if n <= 40:
            print("  - stock: %s" % x.strip())
            print("  + guard: %s" % y.strip())
print("differing lines:", n)
