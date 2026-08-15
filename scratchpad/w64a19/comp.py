import importlib.util, sys, subprocess, re, time
from pathlib import Path
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT/'tools'))
spec = importlib.util.spec_from_file_location('bld', ROOT/'tools'/'build.py')
bld = importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)
bld.OUT = bld.BUILD
NM = "C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-nm"
def compile_one(rel):
    p = ROOT/rel
    return bld.compile_c(p, skip_asm=False) if p.suffix=='.c' else bld.compile_cpp(p)
def undef(obj):
    out = subprocess.run([NM,'-u',str(obj)],capture_output=True,text=True).stdout
    return set(l.split()[-1] for l in out.splitlines() if l.strip())
if __name__ == '__main__':
    t=time.time(); o=compile_one(sys.argv[1]); print(o, f"{time.time()-t:.1f}s")
    print(len(undef(o)))
