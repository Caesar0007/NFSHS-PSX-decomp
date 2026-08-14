#!/usr/bin/env python3
"""tu_order_audit (W59-A18 spec): for every build object, check that the .text
symbol OFFSET order matches the retail VA order from configs/symbol_addrs.txt.
An inversion = functions emitted in the wrong intra-TU order (the MSC02 class:
link-visible wrong VAs the byte gate cannot see)."""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OBJDUMP = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump"

vas = {}
dup = set()
for ln in open(ROOT / "configs" / "symbol_addrs.txt", encoding="utf-8",
               errors="replace"):
    m = re.match(r"(\S+?)\s*=\s*(0x[0-9A-Fa-f]+);\s*//\s*type:func", ln)
    if m:
        if m.group(1) in vas and vas[m.group(1)] != int(m.group(2), 16):
            dup.add(m.group(1))          # name maps to >1 VA (per-TU static
        vas.setdefault(m.group(1), int(m.group(2), 16))
# w60 unlock: a name with multiple VAs (per-TU static copies, e.g.
# iSPCH_GetOffset16 x3) mis-attributes the FIRST VA to every object holding a
# copy => FALSE inversions (spchdata/spchrule were 3 phantoms).  Skip them --
# report the count so the exclusion is never silent (anti-vacuity rule).
for n in dup:
    del vas[n]

bad = 0
objs = sorted(o for o in (ROOT / "build" / "recon").rglob("*.o")
              if "diffsrc" not in o.parts)
for obj in objs:
    r = subprocess.run([OBJDUMP, "-t", str(obj)], capture_output=True, text=True)
    syms = []
    for ln in r.stdout.splitlines():
        m = re.match(r"([0-9a-f]{8})\s+\S*\s+F\s+\.text\s+[0-9a-f]+\s+(\S+)", ln)
        if m and m.group(2) in vas:
            syms.append((int(m.group(1), 16), vas[m.group(2)], m.group(2)))
    syms.sort()
    last_va = -1
    for off, va, name in syms:
        if va < last_va:
            print(f"INVERSION {obj.relative_to(ROOT)}: {name} (VA {va:#x}) "
                  f"after a higher-VA symbol")
            bad += 1
        else:
            last_va = va
print(f"{len(objs)} objects audited, {bad} inversions "
      f"({len(dup)} multi-VA names excluded: {' '.join(sorted(dup)) or '-'})")
sys.exit(1 if bad else 0)
