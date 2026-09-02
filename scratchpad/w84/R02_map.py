import re,sys
sys.path.insert(0,'scratchpad/w84')
from R02_norm import load
def trace(p, framespill):
    ins=load(p)
    # reorder: move delay-slot insn BEFORE its jal for arg-setup purposes
    seq=[]
    i=0
    while i < len(ins):
        if ins[i].startswith('jal ') and i+1 < len(ins):
            seq.append(ins[i+1]); seq.append(ins[i]); i+=2
        else:
            seq.append(ins[i]); i+=1
    val={'a0':0}
    out=[]
    for t in seq:
        m=re.match(r'^lw (\w+),(\d+)\(sp\)$',t)
        if m:
            r,o=m.group(1),int(m.group(2))
            val[r]= 0 if o==framespill else None; continue
        m=re.match(r'^addiu (\w+),(\w+),(-?\d+)$',t)
        if m:
            d,s,k=m.group(1),m.group(2),int(m.group(3))
            base=val.get(s); val[d]= (base+k) if base is not None else None; continue
        m=re.match(r'^addu (\w+),(\w+),zero$',t)
        if m: val[m.group(1)]=val.get(m.group(2)); continue
        if t.startswith('jal '):
            out.append(val.get('a0'))
            for r in ('v0','v1','a0','a1','a2','a3','t0','t1','t2','t3','t4','t5','t6','t7','t8','t9','at','ra'):
                val[r]=None
            continue
        m=re.match(r'^\w+ (\w+),',t)
        if m and m.group(1)!='sp': val[m.group(1)]=None
    return out
if __name__=='__main__':
    b=trace('asm/nonmatchings/front/__15tGlobalMenuDefs.s',640)
    print(len(b),"unknown:",sum(1 for x in b if x is None))
    print([hex(x) if x is not None else None for x in b[:30]])
