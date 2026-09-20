"""fn_diffcount.py CPP -- per-function diff-line count of one recon TU against retail (verify_asm's normalised listing).
Prints only functions that differ: name, oracle/ours instruction counts, differing lines."""
import difflib
import importlib.util
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
NM = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-nm.exe'
sys.path.insert(0, str(ROOT / 'tools'))
cpp = sys.argv[1]
sys.argv = [sys.argv[0], cpp, '__none__']
sp = importlib.util.spec_from_file_location('va', ROOT / 'tools' / 'verify_asm.py')
V = importlib.util.module_from_spec(sp)
try:
    sp.loader.exec_module(V)
except SystemExit:
    pass
obj = 'build/' + cpp + '.o'
out = subprocess.run([NM, '-n', obj], capture_output=True, text=True, cwd=str(ROOT)).stdout
tot = 0
for ln in out.splitlines():
    p = ln.split()
    if len(p) != 3 or p[1] not in 'Tt' or p[2].startswith(('gcc2_', '__gnu')):
        continue
    fn = p[2]
    try:
        o, u = V.oracle(fn), V.ours(fn)
    except BaseException:
        continue
    if not o:
        continue
    d = sum(1 for l in difflib.unified_diff(o, u, lineterm='', n=0) if l[:1] in '+-' and not l.startswith(('+++', '---')))
    if d:
        tot += d
        print('%4d  %4d/%-4d %s' % (d, len(o), len(u), fn[:90]))
print('total differing lines', tot)
