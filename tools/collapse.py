"""collapse_a5.py CPP FN REG... -- diff ours vs oracle with the listed registers
collapsed to a single token, to measure how much of a residual is purely
'which of these interchangeable scratch registers was picked'."""
import sys,re,difflib,importlib.util
from pathlib import Path
ROOT=Path(__file__).resolve().parent.parent; sys.path.insert(0,str(ROOT/'tools'))
cpp,fn=sys.argv[1],sys.argv[2]; regs=sys.argv[3:]
sys.argv=[sys.argv[0],cpp,fn]
sp=importlib.util.spec_from_file_location('va',ROOT/'tools'/'verify_asm.py')
m=importlib.util.module_from_spec(sp)
try: sp.loader.exec_module(m)
except SystemExit: pass
o=m.ours(fn); e=m.oracle(fn)
pat=re.compile(r'\b('+'|'.join(regs)+r')\b')
c=lambda L:[pat.sub('rX',l) for l in L]
for tag,(a,b) in (('raw',(o,e)),('collapsed',(c(o),c(e)))):
    d=[l for l in difflib.unified_diff(a,b,lineterm='') if l[0] in '+-' and not l.startswith(('+++','---'))]
    print(tag,len(d))
    if tag=='collapsed':
        for l in d[:40]: print('   ',l)
