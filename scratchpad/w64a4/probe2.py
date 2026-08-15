import subprocess,pathlib,itertools
P=pathlib.Path('recon/syslib/psx/libmcrd/LIBMCRD.c')
base=pathlib.Path('scratchpad/w64a4/LIBMCRD.c.split_ok').read_bytes()
hs=base.find(b'static __inline__ long MemCardSyncAt(')
he=base.find(b'__inline__ long MemCardSync(long mode, int *cmds, int *result)')
assert 0<hs<he
H=base[hs:he]
SNAP_OLD=b'    cmd = base[0];\r\n    rslt = base[1];\r\n'
assert H.count(SNAP_OLD)==1, H.count(SNAP_OLD)
SNAP_VOL=b'    cmd = *(volatile int *)&base[0];\r\n    rslt = *(volatile int *)&base[1];\r\n'
LAUND_S=H.find(b'        {   /* CROSS-JUMP DE-MERGER:'); LAUND_E=H.find(b'    }\r\n\r\n    /* non-blocking */')
LAUND=H[LAUND_S:LAUND_E]
PLAIN=b'        return 1;\r\n'
def run(tag,h):
    P.write_bytes(base[:hs]+h+base[he:])
    o=[]
    for f in ('MemCardSync','MemCardCreateFile','MemCardDeleteFile'):
        r=subprocess.run(['python','tools/verify_asm.py',str(P),f],capture_output=True,text=True).stdout
        for ln in r.splitlines():
            if ln.strip().startswith('MemCard'): o.append(ln.strip().split(': ',1)[1].replace(' diffs','').replace('(ours ','').replace(' / oracle',''))
    print(f"{tag:26s} {' | '.join(o)}")
run('ctrl',H)
run('snap volatile',H.replace(SNAP_OLD,SNAP_VOL))
run('plain return 1',H.replace(LAUND,PLAIN))
run('both',H.replace(SNAP_OLD,SNAP_VOL).replace(LAUND,PLAIN))
