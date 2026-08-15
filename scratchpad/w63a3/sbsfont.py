#!/usr/bin/env python3
"""Side-by-side ours-vs-oracle for one SYS.c symbol (no normalization)."""
import re
import subprocess
import sys

OBJ = "build/recon/syslib/psx/libgpu/FONT.c.o"
OD = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump"
fn = sys.argv[1]
orc_path = sys.argv[2] if len(sys.argv) > 2 else "asm/nonmatchings/main/%s.s" % fn

out = subprocess.run([OD, "-d", OBJ], capture_output=True, text=True).stdout
ours = []
grab = False
for ln in out.splitlines():
    if ln.endswith("<%s>:" % fn):
        grab = True
        continue
    if grab:
        if not ln.strip():
            break
        m = re.match(r"\s*[0-9a-f]+:\s+[0-9a-f ]+\t(.*)", ln)
        if m:
            ours.append(re.sub(r"\s+", " ", m.group(1).strip()))

orc = []
for ln in open(orc_path):
    if ln.strip().startswith("nonmatching"):
        continue
    m = re.search(r"\*/\s+(\S+)\s*(.*)$", ln)
    if m:
        orc.append(re.sub(r"\s+", " ", (m.group(1) + " " + m.group(2)).strip()))

n = max(len(ours), len(orc))
for i in range(n):
    a = ours[i] if i < len(ours) else ""
    b = orc[i] if i < len(orc) else ""
    mark = "" if a.split()[:1] == b.split()[:1] else "   <<<"
    print("%3d %-40s | %-42s%s" % (i, a, b, mark))
print("ours=%d oracle=%d" % (len(ours), len(orc)))
