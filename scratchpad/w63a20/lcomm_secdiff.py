#!/usr/bin/env python3
"""Detail which SECTION differs between stock-maspsx and guard-maspsx objects
for one TU (follow-up to lcomm_probe.py's '*** CONTENT MOVED ***' flag)."""
import importlib.util
import re
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
_s = importlib.util.spec_from_file_location("nfs4build", ROOT / "tools" / "build.py")
bp = importlib.util.module_from_spec(_s)
sys.modules["nfs4build"] = bp
_s.loader.exec_module(bp)
OBJDUMP = Path(bp.MIPS) / "mipsel-none-elf-objdump.exe"
STOCK = Path(r"C:/Temp/maspsx-master/maspsx.py")
GUARD = ROOT / "scratchpad" / "w63a20" / "maspsx_lcomm" / "maspsx.py"

rel = sys.argv[1] if len(sys.argv) > 1 else "recon/frontend/common/screencarselect.cpp"
is_cpp = rel.endswith(".cpp")
g = str(bp.per_tu_flags(ROOT / rel).get("g_value", bp.G_VALUE))
s_text = (ROOT / "build" / (rel + ".s")).read_text()
if is_cpp:
    s_text = s_text.replace("_._", "___")

td = tempfile.mkdtemp()
objs = {}
for tag, m in (("stock", STOCK), ("guard", GUARD)):
    o = Path(td) / (tag + ".o")
    cmd = [sys.executable, str(m), f"--aspsx-version={bp.ASPSX_VERSION}",
           "--expand-div", "--run-assembler", f"--gnu-as-path={bp.AS}",
           *[str(a) for a in bp.AS_ARCH], f"-G{g}",
           "-I", str(bp.RECON if is_cpp else ROOT / "include"), "-I", str(ROOT),
           "-o", str(o)]
    r = subprocess.run(cmd, input=s_text, capture_output=True, text=True, cwd=ROOT)
    assert o.exists(), r.stderr[:400]
    objs[tag] = o
    print(tag, "->", o)

for tag, o in objs.items():
    r = subprocess.run([str(OBJDUMP), "-h", str(o)], capture_output=True, text=True)
    print("=== %s headers ===" % tag)
    print(r.stdout)

for name in sys.argv[2:] or [".text", ".data", ".rodata", ".sdata", ".bss", ".sbss"]:
    dumps = {}
    for tag, o in objs.items():
        r = subprocess.run([str(OBJDUMP), "-s", "-j", name, str(o)],
                           capture_output=True, text=True)
        dumps[tag] = r.stdout
    same = dumps["stock"] == dumps["guard"]
    print("%-10s %s" % (name, "identical" if same else "DIFFERS"))
    if not same:
        a = dumps["stock"].splitlines()
        b = dumps["guard"].splitlines()
        for i in range(max(len(a), len(b))):
            x = a[i] if i < len(a) else "<eof>"
            y = b[i] if i < len(b) else "<eof>"
            if x != y:
                print("   stock: " + x)
                print("   guard: " + y)
                break
        print("   stock lines %d / guard lines %d" % (len(a), len(b)))
