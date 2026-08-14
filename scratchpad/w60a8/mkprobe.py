#!/usr/bin/env python3
"""w60a8 probe builder: emit <root>/scratchpad/build_w60a8probe.py (a copy of
tools/build.py with the aiphysic CalcAcceleration TEXT_MOVES regex made
LABEL-AGNOSTIC) and <root>/scratchpad/verify_w60a8probe.py (verify_asm pointed
at it).  Both live one level under the repo root so build.py's
ROOT = Path(__file__).resolve().parent.parent still resolves correctly.
tools/ itself is never written."""
from pathlib import Path

R = Path(r"C:/Temp/nfs4-decomp")
b = (R / "tools" / "build.py").read_text(encoding="utf-8")

OLD = ('            {"take": r"(?<=\\$L694:\\n)\\tmove\\t\\$2,\\$16\\n",\n'
       '             "after": r"\\tbeq\\t\\$5,\\$2,\\$L694\\n",\n')
NEW = ('            {"take": r"\\tmove\\t\\$2,\\$16\\n(?=\\$L\\d+:\\n\\$L\\d+:\\n\\tlw\\t\\$31,)",\n'
       '             "after": r"\\tbeq\\t\\$5,\\$2,\\$L\\d+\\n",\n')
assert b.count(OLD) == 1, b.count(OLD)
b = b.replace(OLD, NEW)
(R / "scratchpad" / "build_w60a8probe.py").write_text(b, encoding="utf-8", newline="")

v = (R / "tools" / "verify_asm.py").read_text(encoding="utf-8")
OLDV = "spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')"
NEWV = "spec = importlib.util.spec_from_file_location('bld', ROOT / 'scratchpad' / 'build_w60a8probe.py')"
assert v.count(OLDV) == 1
v = v.replace(OLDV, NEWV)
(R / "scratchpad" / "verify_w60a8probe.py").write_text(v, encoding="utf-8", newline="")
print("probe copies written")
