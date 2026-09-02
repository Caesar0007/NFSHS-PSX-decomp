"""Compile a FONT.c variant (cc1 only) and print the .s region matching a regex."""
import json, re, subprocess, sys
from pathlib import Path
ROOT = Path('C:/Temp/nfs4-decomp')
P = ROOT/'recon/syslib/psx/libgpu/FONT.c'
BASE = (ROOT/'scratchpad/w85/M1_nodev.c').read_bytes()
S = BASE.decode('utf-8')
variants = json.loads(Path(sys.argv[1]).read_text(encoding='utf-8'))
pat = re.compile(sys.argv[2])
ctx = int(sys.argv[3]) if len(sys.argv)>3 else 6
for name, subs in variants:
    s=S; ok=True
    for old,new in subs:
        old=old.replace('\n','\r\n'); new=new.replace('\n','\r\n')
        if old not in s: print('---',name,'NOTFOUND',repr(old[:60])); ok=False; break
        s=s.replace(old,new,1)
    if not ok: continue
    P.write_bytes(s.encode('utf-8'))
    r = subprocess.run([sys.executable,'tools/rtl_dump_c.py','recon/syslib/psx/libgpu/FONT.c','-dg'],
                       cwd=ROOT, capture_output=True, text=True)
    lines=[l for l in (ROOT/'scratch/rtl_a5/FONT.s').read_text(errors='replace').splitlines()
           if not l.startswith('\t.def') and not l.startswith('\t.val')]
    print('---',name)
    for i,l in enumerate(lines):
        if pat.search(l):
            print('\n'.join(lines[max(0,i-2):i+ctx])); print('   ...')
P.write_bytes(BASE)
print('[reverted]')
