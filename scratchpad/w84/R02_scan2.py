import sys,json,os
sys.path.insert(0,'C:/Temp/nfs4-decomp/scratchpad/w84')
import R02_dev as D
D.PURE=os.environ.get('PUREF','scratchpad/w84/R02_base.cpp')
hosts=[int(x) for x in open('C:/Temp/nfs4-decomp/scratchpad/w84/R02_hosts.txt').read().split()]
res=[]
for pi in range(0,len(hosts),3):
    for k in (1,2,3,4,5,6,7,8,10,12):
        devs=[(h,1) for h in hosts[pi:pi+k]]
        if len(devs)<k: continue
        D.build(devs)
        d,n,fr=D.gate()
        res.append((d if d is not None else 99999,n,fr,hosts[pi],k))
    print('.',end='',flush=True)
res.sort(); print()
print("BEST BY DIFF"); [print(r) for r in res[:12]]
fr632=[r for r in res if r[2]==632]
print("FRAME-632 hits:",len(fr632)); [print(r) for r in fr632[:12]]
import collections
print("frames:",collections.Counter(r[2] for r in res))
print("insn counts:",collections.Counter(r[1] for r in res))
json.dump(res,open('C:/Temp/nfs4-decomp/scratchpad/w84/R02_scan2.json','w'))
