import subprocess,pathlib
P=pathlib.Path('recon/syslib/psx/libmcrd/LIBMCRD.c')
base=pathlib.Path('scratchpad/w64a4/LIBMCRD.c.step3').read_bytes()
PRES=b'    _mc_present |= 1 << (base[3]);\r\n'
assert base.count(PRES)==1
OPEN=b'    fd = open(devname, 1);  '
assert base.count(OPEN)==1
def run(tag,d):
    P.write_bytes(d); o=[]
    for f in ('MemCardSync','MemCardCreateFile','MemCardDeleteFile'):
        r=subprocess.run(['python','tools/verify_asm.py',str(P),f],capture_output=True,text=True).stdout
        for ln in r.splitlines():
            if ln.strip().startswith('MemCard'): o.append(ln.strip().split(': ',1)[1].replace(' diffs',''))
    print(f"{tag:34s} {' | '.join(o)}")
run('ctrl', base)
run('named oflag before present',
    base.replace(PRES, b'    oflag = 1;\r\n'+PRES).replace(OPEN, b'    fd = open(devname, oflag);  ')
        .replace(b'    int  retry;\r\n', b'    int  retry;\r\n    int  oflag;\r\n',1))
run('fenced oflag before present',
    base.replace(PRES, b'    oflag = 1;\r\n    __asm__("" : "=r"(oflag) : "0"(oflag));\r\n'+PRES).replace(OPEN, b'    fd = open(devname, oflag);  ')
        .replace(b'    int  retry;\r\n', b'    int  retry;\r\n    int  oflag;\r\n',1))
run('oflag after present',
    base.replace(PRES, PRES+b'    oflag = 1;\r\n').replace(OPEN, b'    fd = open(devname, oflag);  ')
        .replace(b'    int  retry;\r\n', b'    int  retry;\r\n    int  oflag;\r\n',1))
