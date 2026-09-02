import sys,json
sys.path.insert(0,'C:/Temp/nfs4-decomp/scratchpad/w84')
import R02_dev as D
D.PURE=sys.argv[1] if len(sys.argv)>1 else 'scratchpad/w84/R02_best.cpp'
hosts=[int(x) for x in open('C:/Temp/nfs4-decomp/scratchpad/w84/R02_hosts.txt').read().split()]
cur=[]
D.build(cur); best=D.gate(); print("start",best,flush=True)
for rnd in range(6):
    cands=[]
    for h in hosts[::2]:
        if any(p==h for p,_ in cur): continue
        D.build(cur+[(h,1)])
        d,n=D.gate()
        if d is None: continue
        cands.append((d,n,h))
    cands.sort()
    print("round",rnd,"best5",cands[:5],flush=True)
    if not cands or cands[0][0]>=best[0]:
        print("no improvement; stop"); break
    cur.append((cands[0][2],1)); best=(cands[0][0],cands[0][1])
    print("accept",cur,best,flush=True)
json.dump(cur,open('C:/Temp/nfs4-decomp/scratchpad/w84/R02_greedy.json','w'))
D.build(cur); print("final",D.gate())
