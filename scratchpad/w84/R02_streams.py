import os,re,sys,shutil,subprocess
from pathlib import Path
ROOT=Path('C:/Temp/nfs4-decomp')
MIPS=Path('C:/Tools/mips-ps1/mips/bin'); OBJD=str(MIPS/'mipsel-none-elf-objdump.exe')
sys.path.insert(0,str(ROOT/'tools'))
import importlib.util
spec=importlib.util.spec_from_file_location('bld',ROOT/'tools'/'build.py')
bld=importlib.util.module_from_spec(spec); spec.loader.exec_module(bld); bld.OUT=bld.BUILD
cand=ROOT/sys.argv[1]; lane='recon/frontend/common/femenudefs.cpp'; fn='__15tGlobalMenuDefs'
base=ROOT/lane
tmp=base.parent/(base.stem+'__r02_stream'+cand.suffix)
shutil.copyfile(cand,tmp)
base_rel=base.relative_to(ROOT).as_posix(); tmp_rel=tmp.relative_to(ROOT).as_posix()
for _n,_t in vars(bld).items():
    if isinstance(_t,dict) and base_rel in _t: _t[tmp_rel]=_t[base_rel]
try:
    obj=bld.compile_cpp(tmp)
    dis=subprocess.run([OBJD,'-d','-r','-z',str(obj)],capture_output=True,text=True).stdout
finally:
    if tmp.exists(): tmp.unlink()
sys.path.insert(0,str(ROOT/'scratchpad'/'w84'))
from R02_norm import norm_ins
lines=[];inb=False
for ln in dis.splitlines():
    m=re.match(r'^[0-9a-f]{8} <(.+)>:',ln)
    if m:
        if inb and re.fullmatch(r'LM\d+',m.group(1)): continue
        if inb: break
        inb=(m.group(1)==fn); continue
    if inb: lines.append(ln)
out=[]
for i,ln in enumerate(lines):
    mm=re.match(r'^\s*[0-9a-f]+:\t([0-9a-f]+)\s*\t(.*)',ln)
    if not mm: continue
    nxt=lines[i+1] if i+1<len(lines) else ''
    kind=re.search(r'R_MIPS_\w+',nxt)
    t=norm_ins(mm.group(2))
    if kind: t=re.sub(r'%hi\([^)]*\)','HI',t)
    out.append(t)
open(sys.argv[2],'w').write('\n'.join(out))
print(len(out),'insns ->',sys.argv[2])
