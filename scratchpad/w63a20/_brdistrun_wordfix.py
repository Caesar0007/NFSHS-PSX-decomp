#!/usr/bin/env python3
"""Run tools/brdist.py for one TU with TWO substitutions:
  (a) the object goes to a private dir (env W63A20_OUT), as in _brdistrun.py;
  (b) THE .word FIX -- oracle_branches() skips every line starting with '.',
      but spimdisasm emits an unrecognised instruction (every GTE/COP2 op) as
      `.word 0x4A480012`, which occupies a REAL instruction slot.  Skipping it
      under-counts the oracle's instruction index, so every branch whose target
      label lies past a `.word` reports a bogus distance.  Each `.word` is
      exactly one 4-byte instruction, so counting it fixes the index.

This is a PROOF harness for a proposed tools/brdist.py patch, not a tool."""
import os
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
sys.path.insert(0, str(ROOT / "tools"))

src = (ROOT / "tools" / "brdist.py").read_text()

OLD_OUT = "head = src.split('allpass=True')[0]"
assert src.count(OLD_OUT) == 1, "brdist.py head anchor moved -- re-derive"
src = src.replace(OLD_OUT, OLD_OUT + "\n"
                  "head = head.replace('bld.OUT = bld.BUILD',\n"
                  "    'bld.OUT = Path(os.environ[\"W63A20_OUT\"]);"
                  " bld.OUT.mkdir(parents=True, exist_ok=True)')\n"
                  "assert 'W63A20_OUT' in head, 'OUT redirect anchor missing'\n")

OLD_W = ("        if not s or s.startswith(('.', 'glabel', 'nonmatching', "
         "'dlabel', 'jlabel', 'alabel')) or s.endswith(':'):\n"
         "            continue\n")
NEW_W = ("        if s.startswith('.word'):\n"
         "            idx += 1          # a spimdisasm `.word` IS one instruction\n"
         "            continue\n"
         "        if not s or s.startswith(('.', 'glabel', 'nonmatching', "
         "'dlabel', 'jlabel', 'alabel')) or s.endswith(':'):\n"
         "            continue\n")
assert src.count(OLD_W) == 1, "brdist.py oracle_branches filter moved -- re-derive"
src = src.replace(OLD_W, NEW_W)

exec(compile(src, str(ROOT / "tools" / "brdist.py"), "exec"),
     {"__name__": "__main__", "__file__": str(ROOT / "tools" / "brdist.py")})
