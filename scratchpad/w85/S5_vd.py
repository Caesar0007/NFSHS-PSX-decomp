"""S5_vd.py <rel> <fn> <dels-comma-linenos>  -- delete lines, vdiff one fn, restore."""
import sys,subprocess
from pathlib import Path
ROOT=Path('C:/Temp/nfs4-decomp')
rel,fn=sys.argv[1],sys.argv[2]
dels={int(x) for x in sys.argv[3].split(',')} if len(sys.argv)>3 and sys.argv[3] else set()
p=ROOT/rel; orig=p.read_text(encoding='utf-8',errors='surrogateescape'); L=orig.split('\n')
p.write_text('\n'.join(l for i,l in enumerate(L) if i+1 not in dels),encoding='utf-8',errors='surrogateescape')
try:
    r=subprocess.run([sys.executable,str(ROOT/'tools'/'vdiff.py'),rel,fn],capture_output=True,text=True,cwd=str(ROOT))
    print(r.stdout[-4000:]); print(r.stderr[-500:])
finally:
    p.write_text(orig,encoding='utf-8',errors='surrogateescape')
