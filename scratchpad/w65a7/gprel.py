#!/usr/bin/env python3
"""W65-A7 -- classify the R_MIPS_GPREL16 truncations: genuine gp-distance vs
symbol MISPLACEMENT.  Reads the two probe maps and reports, per symbol, its
linked address and its signed distance from _gp under each script, plus the
total small-data window size.
"""
import re
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
GP = 0x8013C54C
SYMS = ["AIDataRecord_WhichRecord", "AIDataRecord_RecordMethod",
        "AIDataRecord_BestLine", "AIDataRecord_TrackCurve",
        "AITraffic_rawTriggers"]


def addrs(mapfile, names):
    txt = Path(mapfile).read_text(errors="replace")
    out = {}
    for n in names:
        m = re.search(r"^\s+0x0*([0-9a-f]+)\s+" + re.escape(n) + r"\s*$",
                      txt, re.M)
        if m:
            out[n] = int(m.group(1), 16)
    return out


def window(mapfile):
    txt = Path(mapfile).read_text(errors="replace")
    lo, hi = None, None
    for sec in (".sdata", ".sbss"):
        for m in re.finditer(r"^ " + re.escape(sec) + r"\s+0x0*([0-9a-f]+)\s+0x0*([0-9a-f]+)",
                             txt, re.M):
            a, sz = int(m.group(1), 16), int(m.group(2), 16)
            if not sz:
                continue
            lo = a if lo is None else min(lo, a)
            hi = a + sz if hi is None else max(hi, a + sz)
    return lo, hi


for tag in sys.argv[1:]:
    mp = HERE / f"{tag}.map"
    if not mp.exists():
        print(f"[{tag}] no map"); continue
    a = addrs(mp, SYMS)
    print(f"== {tag} ==")
    for n in SYMS:
        v = a.get(n)
        if v is None:
            print(f"   {n:28s} NOT IN MAP")
        else:
            d = v - GP
            ok = -0x8000 <= d < 0x8000
            print(f"   {n:28s} 0x{v:08X}  gp{d:+#x}  "
                  f"{'IN' if ok else 'OUT OF'}-RANGE")
