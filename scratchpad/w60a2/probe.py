#!/usr/bin/env python3
"""probe.py <patchfile> <recon-file> <Fn[,Fn...]>

Runs tools/verify_asm.py UNMODIFIED on disk, but with <patchfile> exec'd into its
namespace immediately after it has loaded tools/build.py as `bld` -- so a candidate
PER_FN_* table entry can be A/B'd without editing tools/build.py (which other wave
agents share).  Never writes to tools/.
"""
import sys
from pathlib import Path

ROOT = Path(r'C:/Temp/nfs4-decomp')
sys.path.insert(0, str(ROOT / 'tools'))
patch = Path(sys.argv[1]).resolve()
va = ROOT / 'tools' / 'verify_asm.py'
src = va.read_text()
needle = "bld.OUT = bld.BUILD"
assert needle in src, "verify_asm.py shape changed"
src = src.replace(needle, needle + "\nexec(compile(open(r'%s').read(), r'%s', 'exec'))"
                  % (patch.as_posix(), patch.as_posix()), 1)
sys.argv = [str(va)] + sys.argv[2:]
g = {'__file__': str(va), '__name__': '__main__'}
exec(compile(src, str(va), 'exec'), g)
