#!/usr/bin/env python3
"""w60a8 ordplan: for one TU object, print current emission order (offset) vs
retail VA order, so a reorder plan can be written by hand."""
import re, subprocess, sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
OBJDUMP = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump"

vas = {}
for ln in open(ROOT / "configs" / "symbol_addrs.txt", encoding="utf-8", errors="replace"):
    m = re.match(r"(\S+?)\s*=\s*(0x[0-9A-Fa-f]+);\s*//\s*type:func", ln)
    if m:
        vas.setdefault(m.group(1), int(m.group(2), 16))

obj = ROOT / "build" / "recon" / "game" / "common" / (sys.argv[1] + ".cpp.o")
r = subprocess.run([OBJDUMP, "-t", str(obj)], capture_output=True, text=True)
syms = []
for ln in r.stdout.splitlines():
    m = re.match(r"([0-9a-f]{8})\s+\S*\s+F\s+\.text\s+([0-9a-f]+)\s+(\S+)", ln)
    if m:
        n = m.group(3)
        syms.append((int(m.group(1), 16), int(m.group(2), 16), n, vas.get(n)))
syms.sort()
print(f"--- {obj.name}: {len(syms)} .text symbols, current emission order ---")
for i, (off, size, n, va) in enumerate(syms):
    print(f"{i:3} off={off:#08x} size={size:#6x} va={va and hex(va)}  {n}")
print(f"--- retail VA order ---")
known = [s for s in syms if s[3] is not None]
for i, (off, size, n, va) in enumerate(sorted(known, key=lambda s: s[3])):
    print(f"{i:3} va={va:#x}  {n}")
print(f"unknown-VA symbols: {[s[2] for s in syms if s[3] is None]}")
