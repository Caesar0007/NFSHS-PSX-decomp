import re,sys
sys.path.insert(0,'scratchpad/w84')
from R02_norm import load
def trace(p, framespill):
    ins=load(p)
    val={}   # reg -> this-offset (int) if known
    out=[]   # per jal: a0 offset
    consts={}  # reg -> const value
    pend=None
    for i,t in enumerate(ins):
        m=re.match(r'^lw (\w+),(\d+)\(sp\)$',t)
        if m:
            r,o=m.group(1),int(m.group(2))
            val[r]= 0 if o==framespill else None
            consts.pop(r,None); continue
        m=re.match(r'^addiu (\w+),(\w+),(-?\d+)$',t)
        if m:
            d,s,k=m.group(1),m.group(2),int(m.group(3))
            base=val.get(s)
            val[d]= (base+k) if base is not None else None
            consts.pop(d,None); continue
        m=re.match(r'^addu (\w+),(\w+),zero$',t)
        if m:
            d,s=m.group(1),m.group(2)
            val[d]=val.get(s); 
            if s in consts: consts[d]=consts[s]
            else: consts.pop(d,None)
            continue
        m=re.match(r'^li (\w+),(-?\d+)$',t)
        if m: val[m.group(1)]=None; consts[m.group(1)]=int(m.group(2)); continue
        m=re.match(r'^jal ',t)
        if m:
            out.append(val.get('a0'))
            continue
        m=re.match(r'^\w+ (\w+),',t)
        if m and m.group(1)!='sp': val[m.group(1)]=None; consts.pop(m.group(1),None)
    return out
if __name__=='__main__':
    b=trace('asm/nonmatchings/front/__15tGlobalMenuDefs.s',640)
    print(len(b), b[:20])
    print("unknown:",sum(1 for x in b if x is None))
