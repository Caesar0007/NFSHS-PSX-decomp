"""permblind_a5.py CPP FN REG1 REG2 -- how many diffs survive swapping REG1<->REG2 in OURS."""
import subprocess,sys,re,difflib
from pathlib import Path
ROOT=Path(__file__).resolve().parent.parent; sys.path.insert(0,str(ROOT/'tools'))
OBJD=r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
import importlib.util
spec=importlib.util.spec_from_file_location('bld',ROOT/'tools'/'build.py')
bld=importlib.util.module_from_spec(spec);spec.loader.exec_module(bld);bld.OUT=bld.BUILD
cpp,fn,r1,r2=sys.argv[1],sys.argv[2],sys.argv[3],sys.argv[4]
sys.argv=[sys.argv[0],cpp,fn]
va=importlib.util.spec_from_file_location('va',ROOT/'tools'/'verify_asm.py')
mod=importlib.util.module_from_spec(va)
try: va.loader.exec_module(mod)
except SystemExit: pass
o=mod.ours(fn); e=mod.oracle(fn)
def sw(l):
    return re.sub(r'\b('+r1+r'|'+r2+r')\b', lambda m: r2 if m.group(1)==r1 else r1, l)
for tag,oo in (('raw',o),('swapped',[sw(l) for l in o])):
    d=[l for l in difflib.unified_diff(oo,e,lineterm='') if l[0] in '+-' and not l.startswith(('+++','---'))]
    print(tag,len(d),'diffs')
    if tag=='swapped':
        for l in d[:30]: print('   ',l)
