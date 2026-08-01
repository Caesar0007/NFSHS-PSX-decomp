#!/usr/bin/env python3
"""atsyms.py CPP -- list globals our build stores to via the assembler's $at store macro
(`lui $at,%hi(S); sw r,%lo(S)($at)`).  Retail pre-splits into a normal register instead, so each
site is a 1-insn/1-reg divergence; the cure is the unsized-array declaration shape (3.12 #5)."""
import re,sys,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parent.parent
OBJD=r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
sys.path.insert(0,str(ROOT/'tools'))
import importlib.util
spec=importlib.util.spec_from_file_location('bld',ROOT/'tools'/'build.py')
bld=importlib.util.module_from_spec(spec); spec.loader.exec_module(bld); bld.OUT=bld.BUILD
obj=bld.compile_cpp(ROOT/sys.argv[1])
dis=subprocess.run([OBJD,'-d','-r','-z',str(obj)],capture_output=True,text=True).stdout.splitlines()
cur=None; hits={}
for i,l in enumerate(dis):
    m=re.match(r'^([0-9a-f]{8}) <(.+)>:',l)
    if m: cur=m.group(2)
    if 'lui' in l and '$at' in l:
        for j in range(i,min(i+6,len(dis))):
            r=re.search(r'R_MIPS_(HI16|LO16)\s+(\S+)',dis[j])
            if r: hits.setdefault(r.group(2),[]).append(cur); break
for s,fns in sorted(hits.items(), key=lambda kv:-len(kv[1])):
    print('%-34s %2d sites  %s'%(s,len(fns),', '.join(sorted(set(fns)))[:110]))
