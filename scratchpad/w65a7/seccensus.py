#!/usr/bin/env python3
"""Census of every input section name across the src + asm lanes (batched)."""
import re
import subprocess
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OBJDUMP = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump"
objs = sorted((ROOT / "build" / "src").rglob("*.o")) + \
       sorted((ROOT / "build" / "asm").rglob("*.o"))
assert objs, "no objects -- refusing a vacuous census"
print("objects:", len(objs))
SECRE = re.compile(r"^\s*\d+\s+(\S+)\s+([0-9a-f]{8})\s+")
c, nonempty = Counter(), Counter()
for i in range(0, len(objs), 30):
    b = [str(p.relative_to(ROOT).as_posix()) for p in objs[i:i + 30]]
    r = subprocess.run([OBJDUMP, "-h"] + b, capture_output=True, text=True, cwd=ROOT)
    for ln in r.stdout.splitlines():
        m = SECRE.match(ln)
        if m:
            c[m.group(1)] += 1
            if int(m.group(2), 16):
                nonempty[m.group(1)] += 1
for k, v in c.most_common():
    print(f"  {k:24s} objs={v:5d}  nonempty={nonempty[k]}")
