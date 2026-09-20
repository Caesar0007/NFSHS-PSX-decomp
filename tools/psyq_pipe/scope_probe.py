"""scope_probe.py FILE.cpp|FILE.c -- compile a probe with the retail compiler and -g, print each function's SCOPE TREE as the
debug directives give it (.begin/.bend nesting + the locals declared in each scope).  For learning which source constructs
make cc1plus 2.8.0 emit a scope (the BLOCKS class of the SYM board)."""
import re
import subprocess
import sys
from pathlib import Path

src = Path(sys.argv[1])
cc = 'C:/Temp/psq43/COMPILER/' + ('CC1PLPSX.EXE' if src.suffix == '.cpp' else 'CC1PSX.EXE')
cpp = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-cpp.exe'
i = src.with_suffix('.i')
s = src.with_suffix('.s')
r = subprocess.run([cpp, '-x', 'c', '-nostdinc', '-undef', '-P', str(src), '-o', str(i)], capture_output=True, text=True)
if r.returncode:
    i.write_text(src.read_text())
r = subprocess.run([cc, '-quiet', '-O2', '-G4', '-g', str(i), '-o', str(s)], capture_output=True, text=True)
print((r.stdout + r.stderr)[-600:])
fn, depth = None, 0
for l in s.read_text(errors='replace').splitlines():
    m = re.match(r'^\t\.ent\t(\S+)', l)
    if m:
        fn, depth = m.group(1), 0
        print('==', fn)
        continue
    if fn is None:
        continue
    if re.match(r'^\t\.begin\t', l):
        print('   ' + '  ' * depth + '{'); depth += 1
    elif re.match(r'^\t\.bend\t', l):
        depth -= 1; print('   ' + '  ' * depth + '}')
    else:
        m = re.match(r'^\t\.def\t(\w+);\t\.val\t(\S+);\t\.scl\t(\d+);', l)
        if m and m.group(3) in ('1', '4', '9', '17'):
            print('   ' + '  ' * depth + m.group(1) + {'1': ' (auto)', '4': ' (reg)', '9': ' (arg)', '17': ' (regparm)'}[m.group(3)])
    if re.match(r'^\t\.end\t', l):
        fn = None
