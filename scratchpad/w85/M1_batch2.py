import json, subprocess, sys
from pathlib import Path
ROOT = Path('C:/Temp/nfs4-decomp')
P = ROOT/'recon/syslib/psx/libgpu/FONT.c'
BASE = (ROOT/'scratchpad/w85/M1_nodev.c').read_bytes()
S = BASE.decode('utf-8')
variants = json.loads(Path(sys.argv[1]).read_text(encoding='utf-8'))
fns = sys.argv[2] if len(sys.argv)>2 else 'FntPrint'
for name, subs in variants:
    s = S
    ok=True
    for old,new in subs:
        old=old.replace('\n','\r\n'); new=new.replace('\n','\r\n')
        if old not in s:
            print('---',name); print('  NOT FOUND', repr(old[:80])); ok=False; break
        s = s.replace(old,new,1)
    if not ok: continue
    P.write_bytes(s.encode('utf-8'))
    r = subprocess.run([sys.executable,'tools/verify_asm.py','recon/syslib/psx/libgpu/FONT.c',fns],
                       cwd=ROOT, capture_output=True, text=True)
    print('---', name)
    print((r.stdout+r.stderr).strip())
P.write_bytes(BASE)
print('[reverted]')
