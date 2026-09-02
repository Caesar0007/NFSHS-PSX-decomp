"""R15 scratch: compile a regional candidate through build.py on a chosen lane
and print one function's disassembly.  Read-only w.r.t. tools/ and the base tree
(uses the same temp-copy trick verify_region.py does, and deletes it)."""
import sys, os, re, shutil, subprocess, importlib.util
from pathlib import Path

ROOT = Path(r'C:/Temp/nfs4-decomp')
MIPS = Path(r'C:/Tools/mips-ps1/mips/bin')
OBJD = str(MIPS / 'mipsel-none-elf-objdump.exe')

cand    = ROOT / sys.argv[1]
fn      = sys.argv[2]
lane_as = sys.argv[3]

sys.path.insert(0, str(ROOT / 'tools'))
spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
bld = importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)
bld.OUT = bld.BUILD

base = ROOT / lane_as
tmp = base.parent / (base.stem + '__r15dump' + cand.suffix)
shutil.copyfile(cand, tmp)
try:
    base_rel = base.relative_to(ROOT).as_posix()
    tmp_rel = tmp.relative_to(ROOT).as_posix()
    for _n, _t in vars(bld).items():
        if isinstance(_t, dict) and base_rel in _t:
            _t[tmp_rel] = _t[base_rel]
    obj = bld.compile_c(tmp, skip_asm=False) if tmp.suffix == '.c' else bld.compile_cpp(tmp)
    dis = subprocess.run([OBJD, '-d', '-r', '-z', str(obj)],
                         capture_output=True, text=True).stdout
finally:
    if tmp.exists():
        tmp.unlink()

inb = False
for ln in dis.splitlines():
    m = re.match(r'^[0-9a-f]{8} <(.+)>:', ln)
    if m:
        if inb and re.fullmatch(r'LM\d+', m.group(1)):
            continue
        if inb:
            break
        inb = (fn in m.group(1))
        if inb:
            print(ln)
        continue
    if inb:
        print(ln)
