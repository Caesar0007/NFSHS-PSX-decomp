#!/usr/bin/env python3
"""objdump of OUR compiled object for one symbol (w41-a4) -- the way to read
our own frame size / sp-displacement set without the oracle interleaved.
Usage: python tools/ourdis.py recon/game/psx/overlays.cpp RaceSummary__Fv
Frame recipe: pipe through  grep -oE '(sh|sw|lw|lhu)\s+\S+,[0-9]+\(sp\)'
and compare slot widths/gaps against the same over the oracle .s."""
import importlib.util
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / 'tools'))
spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
bld = importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)
bld.OUT = bld.BUILD
src = ROOT / sys.argv[1]
obj = bld.compile_c(src, skip_asm=False) if src.suffix == '.c' else bld.compile_cpp(src)
dis = subprocess.run([str(bld.OBJCOPY.parent / 'mipsel-none-elf-objdump.exe'),
                      '-d', '-r', '-z', str(obj)],
                     capture_output=True, text=True).stdout
fn = sys.argv[2]; cap = False
for ln in dis.splitlines():
    m = re.match(r'^[0-9a-f]{8} <(.+)>:', ln)
    if m:
        cap = (m.group(1) == fn)
        continue
    if cap and ln.strip():
        print(ln)
