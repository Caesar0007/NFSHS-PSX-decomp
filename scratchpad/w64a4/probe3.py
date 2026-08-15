import subprocess,pathlib
P=pathlib.Path('recon/syslib/psx/libmcrd/LIBMCRD.c')
base=pathlib.Path('scratchpad/w64a4/LIBMCRD.c.step3').read_bytes()
hs=base.find(b'static __inline__ long MemCardSyncAt(')
he=base.find(b'__inline__ long MemCardSync(long mode, int *cmds, int *result)')
H=base[hs:he]
SNAP=b'    cmd = base[0];\r\n    rslt = base[1];\r\n'
assert H.count(SNAP)==1
PC_OLD=b'    p = base;\r\n    _mc_present |= 1 << (p[3]);\r\n'
assert base.count(PC_OLD)==1
def mk(h=None, whole=None):
    d = base[:hs]+ (h if h is not None else H) + base[he:]
    if whole: d = d.replace(PC_OLD, whole)
    return d
def run(tag,d):
    P.write_bytes(d); o=[]
    for f in ('MemCardSync','MemCardCreateFile','MemCardDeleteFile'):
        r=subprocess.run(['python','tools/verify_asm.py',str(P),f],capture_output=True,text=True).stdout
        for ln in r.splitlines():
            if ln.strip().startswith('MemCard'): o.append(ln.strip().split(': ',1)[1].replace(' diffs',''))
    print(f"{tag:30s} {' | '.join(o)}")
run('ctrl', mk())
run('fence cmd,rslt', mk(h=H.replace(SNAP, SNAP+b'    __asm__("" : : "r"(cmd), "r"(rslt));\r\n')))
run('fence cmd only',  mk(h=H.replace(SNAP, SNAP+b'    __asm__("" : : "r"(cmd));\r\n')))
run('pc block-local fenced', mk(whole=b'    p = base;\r\n    {\r\n        int *pc = p;\r\n        __asm__("" : "=r"(pc) : "0"(pc));\r\n        _mc_present |= 1 << (pc[3]);\r\n    }\r\n'))
