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
alias_groups_resolved = 0
alias_groups_excluded = 0
objs = sorted(o for o in (ROOT / "build" / "recon").rglob("*.o")
              if "diffsrc" not in o.parts)
for obj in objs:
    r = subprocess.run([OBJDUMP, "-t", str(obj)], capture_output=True, text=True)
    by_offset = {}
    for ln in r.stdout.splitlines():
        m = re.match(r"([0-9a-f]{8})\s+\S*\s+F\s+\.text\s+[0-9a-f]+\s+(\S+)", ln)
        if m and m.group(2) in vas:
            off = int(m.group(1), 16)
            name = m.group(2)
            by_offset.setdefault(off, []).append((vas[name], name))
    syms = []
    for off, aliases in by_offset.items():
        distinct_vas = {va for va, _name in aliases}
        if len(distinct_vas) == 1:
            va, name = aliases[0]
            syms.append((off, va, name))
            continue
        # P426: natural source aliases may share one text offset with the
        # VA-suffixed oracle key for a duplicated static helper.  The explicit
        # suffix identifies this object's retail copy; treating both aliases
        # as sequential functions creates a false inversion at the next row.
        # If no unique suffix proves the copy, exclude and count the group
        # instead of silently selecting an arbitrary VA.
        explicit = [(va, name) for va, name in aliases
                    if name.upper().endswith("_%08X" % va)]
        if len(explicit) == 1:
            va, name = explicit[0]
            syms.append((off, va, name))
            alias_groups_resolved += 1
        else:
            alias_groups_excluded += 1
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
      f"({len(dup)} multi-VA names excluded: {' '.join(sorted(dup)) or '-'}; "
      f"{alias_groups_resolved} co-equal alias groups resolved; "
      f"{alias_groups_excluded} ambiguous alias groups excluded)")
sys.exit(1 if bad else 0)
