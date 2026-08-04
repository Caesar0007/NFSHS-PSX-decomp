#!/usr/bin/env python3
"""w48_a5_tugate.py <recon.c> -- whole-TU gate: compile the TU once, enumerate every FUNC symbol
that has an oracle .s, and print PASS/FAIL per function plus totals. Uses verify_asm's own
compile + normalizer (single compile, so it is ~1 gate run for the whole TU)."""
import sys, os, subprocess, re, importlib.util, difflib
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / 'tools'))
cpp = sys.argv[1]

# discover candidate symbols: FUNC entries in the object
import importlib.util as iu
spec = iu.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
bld = iu.module_from_spec(spec); spec.loader.exec_module(bld)
bld.OUT = bld.BUILD
src = ROOT / cpp
obj = bld.compile_c(src, skip_asm=False) if src.suffix == '.c' else bld.compile_cpp(src)
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
st = subprocess.run([OBJD, '-t', str(obj)], capture_output=True, text=True).stdout
names = []
for ln in st.splitlines():
    if ' F .text' in ln:
        names.append(ln.split()[-1])
names = sorted(set(names))

sys.argv = ['verify_asm.py', cpp, ','.join(names) if names else 'X']
spec2 = iu.spec_from_file_location('va', ROOT / 'tools' / 'verify_asm.py')
va = iu.module_from_spec(spec2)
try:
    spec2.loader.exec_module(va)
except SystemExit:
    pass
npass = nfail = nno = 0
tot = 0
rows = []
for fn in names:
    o = va.ours(fn); e = va.oracle(fn)
    if e is None:
        nno += 1; rows.append((fn, 'NOORACLE', 0)); continue
    if not o:
        nfail += 1; rows.append((fn, 'NOTINOBJ', 0)); continue
    d = [l for l in difflib.unified_diff(o, e, lineterm='')
         if l[0] in '+-' and not l.startswith(('+++', '---'))]
    if not d:
        npass += 1; rows.append((fn, 'PASS', 0))
    else:
        nfail += 1; tot += len(d); rows.append((fn, 'FAIL', len(d)))
for fn, st_, n in rows:
    print(f"{fn:40s} {st_:9s} {n if n else ''}")
print(f"TOTAL {cpp}: PASS={npass} FAIL={nfail} NOORACLE={nno} DIFFSUM={tot}")
