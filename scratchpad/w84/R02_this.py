import re,sys
sys.path.insert(0,'scratchpad/w84')
from R02_norm import load
def thisoffs(p, framespill):
    ins=load(p)
    thisregs=set()
    out=[]
    for i,t in enumerate(ins):
        m=re.match(r'^lw (\w+),(\d+)\(sp\)$',t)
        if m:
            if int(m.group(2))==framespill: thisregs.add(m.group(1))
            else: thisregs.discard(m.group(1))
            continue
        m=re.match(r'^addiu (\w+),(\w+),(-?\d+)$',t)
        if m:
            d,s,k=m.group(1),m.group(2),int(m.group(3))
            if s in thisregs:
                out.append((i,d,s,k))
                if d!=s: thisregs.discard(d)   # derived pointer, not this
                else: thisregs.discard(d)
            else:
                thisregs.discard(d)
            continue
        m=re.match(r'^lui (\w+),',t)
        if m: thisregs.discard(m.group(1)); continue
        m=re.match(r'^(?:addu|li|lw|lbu|lhu|lh|lb|move) (\w+)',t)
        if m: 
            if m.group(1)!='sp': thisregs.discard(m.group(1))
    return out
u=thisoffs('regiondiff/oracles/NFS4-R-USA/__15tGlobalMenuDefs.s',640)
j=thisoffs('regiondiff/oracles/NFS4-R-JPN/__15tGlobalMenuDefs.s',632)
print("USA this-offsets",len(u),"JPN",len(j))
su=sorted(set(x[3] for x in u)); sj=sorted(set(x[3] for x in j))
print("USA distinct",len(su),"JPN distinct",len(sj))
print("equal sets:",su==sj)
if su!=sj:
    print("in USA not JPN:",[x for x in su if x not in sj][:40])
    print("in JPN not USA:",[x for x in sj if x not in su][:40])
