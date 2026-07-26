import subprocess,sys,re
import os
from pathlib import Path
sys.path.insert(0,r'C:/Temp/nfs4-wt35-a10/tools')
ROOT=Path(r'C:/Temp/nfs4-wt35-a10')
cpp=sys.argv[1]
import importlib.util
spec=importlib.util.spec_from_file_location('bld', ROOT/'tools'/'build.py'); bld=importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)
bld.OUT=bld.BUILD
obj=bld.compile_cpp(ROOT/cpp)
OBJD=r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
dis=subprocess.run([OBJD,'-t',str(obj)],capture_output=True,text=True).stdout
fns=[]
for ln in dis.splitlines():
    if ' F .text' in ln:
        fns.append(ln.split()[-1])
oracles={p.name[:-2] for d in ('main','front') for p in (ROOT/'asm'/'nonmatchings'/d).glob('*.s')}
fns=[f for f in fns if f in oracles]
r=subprocess.run([sys.executable,str(ROOT/'tools'/'verify_asm.py'),cpp,','.join(fns)],capture_output=True,text=True,cwd=str(ROOT))
tot=0;npass=0
for ln in r.stdout.splitlines():
    m=re.search(r'^\s+(\S+): (PASS|FAIL)(?: (\d+) diffs)?',ln)
    if m:
        if m.group(2)=='PASS': npass+=1; print(f"  PASS   {m.group(1)}")
        else: tot+=int(m.group(3)); print(f"  FAIL {int(m.group(3)):5} {m.group(1)}")
print(f"== {cpp}: pass={npass}/{len(fns)} totaldiffs={tot}")
