#!/usr/bin/env python3
"""W65-A6: every `sym = 0xVA;` row in linkers/undefined_syms_auto.txt whose symbol
now HAS a real object definition.  A linker-script assignment beats an object
definition, so each of these rows silently orphans the storage this belt created
(the "ld-provided absolute that also has a real definition" class, W62-A18 sec.3).
Output = the exact line numbers for the link lane to drop."""
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
cen = json.load(open(ROOT / "scratchpad/w65a6/census_recon.json"))
defined = set(cen["defined"])

p = ROOT / "linkers/undefined_syms_auto.txt"
rows = []
for i, line in enumerate(open(p, encoding="latin-1"), 1):
    m = re.match(r"^\s*(\S+)\s*=\s*(0x[0-9A-Fa-f]+)\s*;", line)
    if m and m.group(1) in defined:
        rows.append((i, m.group(1), m.group(2)))

print("linkers/undefined_syms_auto.txt: %d rows now shadow a REAL definition" % len(rows))
for i, s, v in rows:
    print("  line %4d  %-22s %s" % (i, s, v))
