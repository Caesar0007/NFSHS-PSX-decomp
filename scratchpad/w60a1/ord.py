#!/usr/bin/env python3
"""w60a1 ord.py OBJ -- print an object's .text symbols by offset alongside their
retail VA, and the required (VA-sorted) order."""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
OBJDUMP = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump"

vas = {}
for ln in open(ROOT / "configs" / "symbol_addrs.txt", encoding="utf-8",
               errors="replace"):
    m = re.match(r"(\S+?)\s*=\s*(0x[0-9A-Fa-f]+);\s*//\s*type:func", ln)
    if m:
        vas.setdefault(m.group(1), int(m.group(2), 16))

obj = sys.argv[1]
r = subprocess.run([OBJDUMP, "-t", obj], capture_output=True, text=True)
rows = []
for ln in r.stdout.splitlines():
    m = re.match(r"([0-9a-f]{8})\s+(\S*)\s+F\s+\.text\s+([0-9a-f]+)\s+(\S+)", ln)
    if m:
        rows.append((int(m.group(1), 16), int(m.group(3), 16), m.group(4),
                     "l" in m.group(2)))
rows.sort()
base = min((vas.get(n, 1 << 40) for _, _, n, _ in rows), default=0)
print(f"{'off':>6} {'size':>5}  {'retailVA':>10} {'want':>6}  name")
for o, s, n, loc in rows:
    va = vas.get(n, 0)
    print(f"{o:6x} {s:5x}  {va:#010x} {va-base if va else 0:6x}  {n}"
          f"{'  [static]' if loc else ''}")
print("\nRETAIL ORDER:")
for va, n in sorted((vas.get(n, 0), n) for _, _, n, _ in rows):
    print(f"  {va:#010x}  {n}")
