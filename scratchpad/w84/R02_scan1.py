import sys,json
sys.path.insert(0,'C:/Temp/nfs4-decomp/scratchpad/w84')
import R02_dev as D
hosts=[int(x) for x in open('C:/Temp/nfs4-decomp/scratchpad/w84/R02_hosts.txt').read().split()]
res=[]
for pi in range(0,len(hosts),4):
    for k in (1,2,3,4,5,6,8):
        devs=[(h,1) for h in hosts[pi:pi+k]]
        if len(devs)<k: continue
        D.build(devs)
        d,n=D.gate()
        res.append((d if d is not None else 99999,n,hosts[pi],k))
    print('.',end='',flush=True)
res.sort()
print()
for r in res[:25]: print(r)
json.dump(res,open('C:/Temp/nfs4-decomp/scratchpad/w84/R02_scan1.json','w'))
