import sys,re,subprocess,json
sys.path.insert(0,'C:/Temp/nfs4-decomp/scratchpad/w84')
import R02_probe as P
ROOT='C:/Temp/nfs4-decomp/'
def build_depths(dv):
    s=open(ROOT+'scratchpad/w84/R02_pure.cpp',encoding='utf-8').read()
    for i,(n,on,off) in enumerate(P.SITES):
        d=dv[i]
        if d==0: continue
        # ON text uses '({ X; })' once; build depth-d by nesting
        assert s.count(off)>=1, n
        inner=on
        for _ in range(d-1):
            # nest: replace the innermost body
            inner=inner.replace('({ ','({ ({ ',1).replace('; })','; }); })',1)
        s=s.replace(off,inner,1)
    open(ROOT+P.CAND,'w',encoding='utf-8',newline='').write(s)
def ev(dv):
    build_depths(dv); return P.gate()
if __name__=='__main__':
    best=[int(c) for c in sys.argv[1]]
    cur=ev(best); print("start",best,cur,flush=True)
    improved=True; rounds=0
    while improved and rounds<6:
        improved=False; rounds+=1
        for i in range(len(P.SITES)):
            for d in (0,1,2,3):
                if d==best[i]: continue
                t=list(best); t[i]=d
                r=ev(t)
                if r[0] is not None and r[0]<cur[0]:
                    best=t; cur=r; improved=True
                    print("accept",best,cur,flush=True)
    print("FINAL",best,cur)
    json.dump({'depths':best,'gate':cur},open(ROOT+'scratchpad/w84/R02_depth.json','w'))
