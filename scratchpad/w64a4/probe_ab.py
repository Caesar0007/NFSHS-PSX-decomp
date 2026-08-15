import subprocess,sys,pathlib
P=pathlib.Path('recon/syslib/psx/libmcrd/LIBMCRD.c')
base=pathlib.Path('scratchpad/w64a4/LIBMCRD.c.syncat').read_bytes()   # variant A (orig spellings, helper param)
PDONE_A=b'            volatile int *pdone = (volatile int *)&base[2];\r\n'
PDONE_B=b'            volatile int *pdone = (volatile int *)&mc.done;\r\n'
i=base.find(b'        {   /* re-anchor:'); j=base.find(b'        {   /* CROSS-JUMP DE-MERGER:')
STORE_A=base[i:j]
STORE_B=b'        base[2] = 0;                          /* done      */\r\n'
def build(pd,st):
    d=base.replace(PDONE_A,pd)
    return d[:i].replace(PDONE_A,pd)+st+d[j:] if False else (base[:i].replace(PDONE_A,pd)+st+base[j:])
for name,pd,st in (('A pdone=&base[2] store=fresh',PDONE_A,STORE_A),
                   ('B pdone=&mc.done store=base',PDONE_B,STORE_B),
                   ('C pdone=&base[2] store=base',PDONE_A,STORE_B),
                   ('D pdone=&mc.done store=fresh',PDONE_B,STORE_A)):
    P.write_bytes(build(pd,st))
    out=[]
    for f in ('MemCardSync','MemCardCreateFile','MemCardDeleteFile'):
        r=subprocess.run(['python','tools/verify_asm.py',str(P),f],capture_output=True,text=True).stdout
        for ln in r.splitlines():
            if ln.strip().startswith('MemCard'): out.append(ln.strip().split(': ',1)[1])
    print(f"{name:32s} {' | '.join(out)}")
