#!/usr/bin/env python3
"""Run the SHIPPED tools/brdist.py for one TU, with its object redirected to a
private output dir (env W63A20_OUT) so the census never touches build/.

The only edit is to the `head` slice brdist.py takes out of verify_asm.py:
`bld.OUT = bld.BUILD` -> a private dir.  Asserted, never silently skipped."""
import os
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
sys.path.insert(0, str(ROOT / "tools"))

src = (ROOT / "tools" / "brdist.py").read_text()
OLD = "head = src.split('allpass=True')[0]"
assert src.count(OLD) == 1, "brdist.py head anchor moved -- re-derive"
NEW = (OLD + "\n"
       "head = head.replace('bld.OUT = bld.BUILD',\n"
       "    'bld.OUT = Path(os.environ[\"W63A20_OUT\"]);"
       " bld.OUT.mkdir(parents=True, exist_ok=True)')\n"
       "assert 'W63A20_OUT' in head, 'OUT redirect anchor missing'\n")
src = src.replace(OLD, NEW)

exec(compile(src, str(ROOT / "tools" / "brdist.py"), "exec"),
     {"__name__": "__main__", "__file__": str(ROOT / "tools" / "brdist.py")})
