#!/usr/bin/env python3
"""W60-A3 CORRECTION TOOL — run tools/verify_asm.py's EXACT gate logic over an
arbitrary .o instead of a freshly-compiled one.

Why: the first cut of probe_272.py / probe_moves.py classified a word mismatch as
"reloc" whenever the two MNEMONICS matched.  That is vacuous — it silently
excused genuine same-mnemonic differences (e.g. a commutative `or $2,$2,$3` vs
retail `or $2,$3,$2`, which carries no relocation at all) and manufactured a
FALSE REAL=0 for _set_draw_mode.

Rather than re-invent the classification, this loads verify_asm.py's SOURCE and
executes it with exactly two textual substitutions: the compile step is replaced
by "take the object from $GATE_OBJ".  Every normalizer, the reloc/GPREL addend
zeroing, the branch-target masking, the dead-%hi rule and the difflib count are
therefore the gate's own, not a re-implementation.

  GATE_OBJ=<path-to.o> python gatecmp.py <any-recon-path> <FUNC[,FUNC...]>

The <recon-path> argument is only used by verify_asm for its `cpp.suffix` check
and is never read; pass the real TU path for clarity.
"""
import os
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
VA = ROOT / "tools" / "verify_asm.py"
src = VA.read_text()

# --- substitution 1: drop the build.py import + compile, take $GATE_OBJ ------
m = re.search(
    r"# compile via build\.py's compile_cpp\n"
    r"import importlib\.util\n"
    r"spec = .*?\n"
    r"bld = .*?\n"
    r"bld\.OUT = bld\.BUILD\n"
    r"obj = .*?\n", src)
if not m:
    sys.exit("gatecmp: verify_asm.py's compile block changed shape -- re-derive "
             "the substitution before trusting any number from this tool")
src = src[:m.start()] + "obj = Path(os.environ['GATE_OBJ'])\n" + src[m.end():]

assert "bld." not in src, "gatecmp: a build.py reference survived the substitution"

g = {"__name__": "__gatecmp__", "__file__": str(VA)}
sys.argv = [str(VA)] + sys.argv[1:]
try:
    exec(compile(src, str(VA), "exec"), g)
except SystemExit as e:
    sys.exit(e.code)
