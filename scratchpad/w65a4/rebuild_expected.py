#!/usr/bin/env python3
"""w65a4 -- rebuild ONLY the expected/ objects affected by the oracle relabel.

A full `tools/build.py --out expected --no-link` also re-assembles every
asm/data/*.s, and `assemble_s()` is NOT tolerant (sys.exit on failure) -- while
this wave a peer belt is actively rewriting asm/data/data_8010CCD4_*.data.s.
A half-written peer file would abort the whole expected build.

So: import tools/build.py as a module (the REAL code path, no re-implementation)
and drive `compile_c` for exactly the 5 src stubs whose INCLUDE_ASM pulls a
relabelled oracle .s.
"""
import importlib.util
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
# build.py does a bare `import fix_symsizes` (known gotcha: it assumes cwd/tools
# is importable), so put tools/ on sys.path before exec'ing it.
sys.path.insert(0, str(ROOT / "tools"))
spec = importlib.util.spec_from_file_location("nfs4build", ROOT / "tools" / "build.py")
b = importlib.util.module_from_spec(spec)
sys.modules["nfs4build"] = b
spec.loader.exec_module(b)

b.OUT = ROOT / "expected"

STUBS = [
    "src/game/common/aispeeds.c",
    "src/game/common/physics.c",
    "src/game/common/r3dcar.c",
    "src/syslib/psx/libmath/DIVSF3.c",
    "src/syslib/psx/libcard/PATCH.c",
]

for rel in STUBS:
    p = ROOT / rel
    obj = b.OUT / (rel + ".o")
    before = obj.stat().st_mtime if obj.exists() else 0
    b.compile_c(p, False)                      # skip_asm=False -> assembles the oracle
    assert obj.exists() and obj.stat().st_mtime > before, f"{rel}: object not rewritten"
    print(f"  rebuilt {obj.relative_to(ROOT).as_posix()}  ({obj.stat().st_size} bytes)")
print(f"{len(STUBS)} expected objects rebuilt")
