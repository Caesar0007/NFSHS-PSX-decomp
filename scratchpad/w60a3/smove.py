#!/usr/bin/env python3
"""Probe a PER_FN_TEXT_MOVES spec WITHOUT touching tools/build.py.

Takes the FINAL .s build.py already produced for SYS.c, applies the requested
move inside one function's .ent/.end region, re-assembles with the same
`as` command line build.py uses, and prints a side-by-side vs the oracle.

  python smove.py <fn> <take-regex> <after-regex> [--slot]
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
AS = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-as.exe"
OD = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump"
S = ROOT / "build/recon/syslib/psx/libgpu/SYS.c.s"
OUT = ROOT / "scratchpad/w60a3/probe.s"
OBJ = ROOT / "scratchpad/w60a3/probe.o"

fn = sys.argv[1]
take = sys.argv[2].encode().decode("unicode_escape")
after = sys.argv[3].encode().decode("unicode_escape")
slot = "--slot" in sys.argv

txt = S.read_text(errors="replace")
m = re.search(r"^\t\.ent\t%s\b[^\n]*\n" % re.escape(fn), txt, re.M)
assert m, "no .ent for %s" % fn
m2 = re.search(r"^\t\.end\t%s[ \t]*$" % re.escape(fn), txt[m.end():], re.M)
end = m.end() + m2.start()
region = txt[m.start():end]

mt = re.search(take, region)
assert mt, "take regex did not match"
moved = mt.group(0)
region2 = region[:mt.start()] + region[mt.end():]
ma = re.search(after, region2)
assert ma, "after regex did not match"
ins = moved
if slot:
    ins = "\t.set\tnoreorder\n\t.set\tnomacro\n" + moved + "\t.set\tmacro\n\t.set\treorder\n"
region2 = region2[:ma.end()] + ins + region2[ma.end():]
OUT.write_text(txt[:m.start()] + region2 + txt[end:])

r = subprocess.run([AS, "-EL", "-march=r3000", "-mtune=r3000", "-G0",
                    "-I", str(ROOT / "include"), "-I", str(ROOT),
                    "-o", str(OBJ), str(OUT)], capture_output=True, text=True)
if r.returncode:
    sys.exit("as failed:\n" + r.stdout + r.stderr)

out = subprocess.run([OD, "-d", str(OBJ)], capture_output=True, text=True).stdout
ours, grab = [], False
for ln in out.splitlines():
    if ln.endswith("<%s>:" % fn):
        grab = True
        continue
    if grab:
        if not ln.strip():
            break
        mm = re.match(r"\s*[0-9a-f]+:\s+[0-9a-f ]+\t(.*)", ln)
        if mm:
            ours.append(re.sub(r"\s+", " ", mm.group(1).strip()))
orc = []
for ln in open(ROOT / ("asm/nonmatchings/main/%s.s" % fn)):
    if ln.strip().startswith("nonmatching"):
        continue
    mm = re.search(r"\*/\s+(\S+)\s*(.*)$", ln)
    if mm:
        orc.append(re.sub(r"\s+", " ", (mm.group(1) + " " + mm.group(2)).strip()))

bad = 0
for i in range(max(len(ours), len(orc))):
    a = ours[i] if i < len(ours) else ""
    b = orc[i] if i < len(orc) else ""
    mark = ""
    if a.split()[:1] != b.split()[:1]:
        mark = "   <<<"
        bad += 1
    print("%3d %-40s | %-42s%s" % (i, a, b, mark))
print("ours=%d oracle=%d  mnemonic-mismatch=%d" % (len(ours), len(orc), bad))
