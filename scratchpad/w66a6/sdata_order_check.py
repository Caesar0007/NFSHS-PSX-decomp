#!/usr/bin/env python3
"""W66-A6: .sdata run order/delta check against retail, from an ALREADY-BUILT
object.  No compile, no source edit -- read-only receipt generator.

Usage: python scratchpad/w66a6/sdata_order_check.py <recon/....cpp> <lo> <hi>
   e.g. ... recon/game/common/audiocmn.cpp 0x8013C628 0x8013C71C
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OBJD = str(Path(r"C:/Tools/mips-ps1/mips/bin") / "mipsel-none-elf-objdump.exe")
DECL_RE = re.compile(r"^(?:char|int|short|u_char|u_int|void)\s+\*?\s*(\w+)"
                     r"[^;]*;\s*/\* @0x([0-9a-f]{8})", re.M)

rel = sys.argv[1]
lo = int(sys.argv[2], 16)
hi = int(sys.argv[3], 16)
src = ROOT / rel
obj = ROOT / "build" / (rel + ".o")
rmap = {m.group(1): int(m.group(2), 16)
        for m in DECL_RE.finditer(src.read_text(encoding="utf-8", errors="replace"))}

rows = []
for ln in subprocess.run([OBJD, "-t", str(obj)], capture_output=True,
                         text=True).stdout.split("\n"):
    p = ln.split()
    if len(p) >= 5 and ".sdata" in ln and not p[-1].startswith("."):
        try:
            rows.append((int(p[0], 16), p[-1]))
        except ValueError:
            pass
rows = sorted(set(rows))
known = [(o, n, rmap[n]) for o, n in rows if n in rmap and lo <= rmap[n] <= hi]
prev = None
bad = 0
for o, n, v in known:
    if prev is not None:
        do, dv = o - prev[0], v - prev[1]
        if do != dv:
            bad += 1
            print("  MISMATCH after %-28s : d_ours=%-4d d_retail=%-4d (%s)"
                  % (prev[2], do, dv, n))
    prev = (o, v, n)
order_ok = [v for _, _, v in known] == sorted(v for _, _, v in known)
print("%s  run 0x%08x..0x%08x : %d symbols, order_matches=%s, delta mismatches=%d/%d"
      % (rel, lo, hi, len(known), order_ok, bad, max(0, len(known) - 1)))
