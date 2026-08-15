#!/usr/bin/env python3
"""W62-A19 TILING test -- the decisive link-prep question.

For every recon object:  implied_base = retail_VA(sym) - our_offset(sym)
(consistent across all its symbols iff the object reproduces retail's internal
layout).  end = implied_base + our .text section size.  Sorting by base, the
objects must TILE retail .text with no overlap; every byte NOT produced by an
object needs a filler in the regenerated .ld.

Writes spine_tiled.txt (the ordered object spine with holes marked).
"""
import json
import re
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
ROM = ROOT / "rom" / "nfs4-f.exe"
FBASE = 0x8000F800                      # VA - file offset

BANDS = [("front.text", 0x800128F0, 0x8005125F),
         ("main.text", 0x8005797C, 0x8010CCD3)]

vas, dup = {}, set()
for ln in open(ROOT / "configs" / "symbol_addrs.txt", errors="replace"):
    m = re.match(r"(\S+?)\s*=\s*(0x[0-9A-Fa-f]+);\s*//\s*type:func", ln)
    if m:
        n, v = m.group(1), int(m.group(2), 16)
        if n in vas and vas[n] != v:
            dup.add(n)
        vas.setdefault(n, v)
for n in dup:
    del vas[n]
# VA-encoding names (func_XXXXXXXX / D_XXXXXXXX) are their own authority
objdata = json.load(open(HERE / "objdata.json"))
rom = ROM.read_bytes()

rows = []
inconsistent = []
for o, d in objdata.items():
    tsz = d.get("secs", {}).get(".text", 0)
    if not tsz:
        continue
    bases = defaultdict(list)
    for s in d["syms"]:
        if s["sec"] != ".text":
            continue
        va = vas.get(s["name"])
        if va is None:
            m = re.match(r"(?:func|D|lbl)_([0-9A-Fa-f]{8})$", s["name"])
            if m:
                va = int(m.group(1), 16)
        if va is None:
            continue
        bases[va - s["off"]].append(s["name"])
    if not bases:
        continue
    best = max(bases.items(), key=lambda kv: len(kv[1]))
    if len(bases) > 1:
        inconsistent.append((o, {hex(k): len(v) for k, v in bases.items()}))
    rows.append({"obj": o, "base": best[0], "size": tsz,
                 "end": best[0] + tsz, "nsym": len(best[1]),
                 "nbase": len(bases)})

rows.sort(key=lambda r: r["base"])
print(f"objects with .text            : {len(rows)}")
print(f"objects with INCONSISTENT base: {len(inconsistent)} "
      f"(internal layout drift -- base taken from the majority symbol group)")

holes, overl = [], []
for i in range(len(rows) - 1):
    a, b = rows[i], rows[i + 1]
    if b["base"] > a["end"]:
        holes.append((a["end"], b["base"], a["obj"], b["obj"]))
    elif b["base"] < a["end"]:
        overl.append((b["base"], a["end"], a["obj"], b["obj"]))

# band edges
first, last = rows[0], rows[-1]
print(f"first object base             : {first['base']:#x} ({first['obj']})")
print(f"last object end               : {last['end']:#x} ({last['obj']})")

zero = nonzero = 0
zbytes = nzbytes = 0
for a, b, oa, ob in holes:
    blob = rom[a - FBASE:b - FBASE]
    if set(blob) <= {0}:
        zero += 1
        zbytes += b - a
    else:
        nonzero += 1
        nzbytes += b - a
print(f"HOLES between objects         : {len(holes)}  "
      f"({sum(b-a for a,b,_,_ in holes)} bytes)")
print(f"   all-zero padding holes     : {zero} ({zbytes} bytes)")
print(f"   holes with REAL CONTENT    : {nonzero} ({nzbytes} bytes) "
      f"<- need a filler object in the .ld")
print(f"OVERLAPS between objects      : {len(overl)}")

with open(HERE / "spine_tiled.txt", "w") as f:
    f.write("# W62-A19 TILED SPINE -- base  end  size  nsym  object\n")
    prev = None
    for r in rows:
        if prev is not None and r["base"] > prev:
            blob = rom[prev - FBASE:r["base"] - FBASE]
            kind = "ZEROPAD" if set(blob) <= {0} else "CONTENT"
            f.write(f"    ---- HOLE {prev:#010x}..{r['base']:#010x} "
                    f"({r['base']-prev} bytes) {kind}\n")
        elif prev is not None and r["base"] < prev:
            f.write(f"    ---- OVERLAP {r['base']:#010x}..{prev:#010x} "
                    f"({prev-r['base']} bytes)\n")
        f.write(f"{r['base']:#010x} {r['end']:#010x} {r['size']:#8x} "
                f"{r['nsym']:4d}{'  *DRIFT*' if r['nbase']>1 else '        '} "
                f"{r['obj']}\n")
        prev = max(prev or 0, r["end"])
    f.write("\n# HOLES WITH REAL CONTENT (need a filler / missing object tail)\n")
    for a, b, oa, ob in holes:
        blob = rom[a - FBASE:b - FBASE]
        if set(blob) <= {0}:
            continue
        f.write(f"CONTENT {a:#010x}..{b:#010x} ({b-a} bytes) after {oa} "
                f"before {ob}\n")
    f.write("\n# OVERLAPS\n")
    for a, b, oa, ob in overl:
        f.write(f"OVERLAP {a:#010x}..{b:#010x} ({b-a} bytes) {oa} vs {ob}\n")
    f.write("\n# OBJECTS WITH INCONSISTENT IMPLIED BASE\n")
    for o, m in sorted(inconsistent, key=lambda x: -len(x[1])):
        f.write(f"MULTIBASE {o} {m}\n")

print("\ncontent holes:")
for a, b, oa, ob in holes:
    blob = rom[a - FBASE:b - FBASE]
    if set(blob) <= {0}:
        continue
    print(f"    {b-a:5d}B {a:#x}..{b:#x} after {oa.replace('build/recon/','')}")
print("\noverlaps:")
for a, b, oa, ob in overl:
    print(f"    {b-a:5d}B {a:#x}..{b:#x} {oa.replace('build/recon/','')} "
          f"vs {ob.replace('build/recon/','')}")
print("-> spine_tiled.txt")
