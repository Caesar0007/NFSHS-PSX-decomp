import re,sys
sys.path.insert(0,'scratchpad/w84')
from R02_norm import load
def callblocks(p):
    ins=load(p)
    blocks=[]; cur=[]
    for t in ins:
        cur.append(t)
        if t.startswith('jal '):
            pass
    # split: block i = instructions from after previous jal's delay slot up to and incl this jal's delay slot
    idx=[i for i,t in enumerate(ins) if t.startswith('jal ')]
    prev=0
    for i in idx:
        blocks.append(ins[prev:i+2])
        prev=i+2
    blocks.append(ins[prev:])
    return blocks
def consts(bl):
    out=[]
    for t in bl:
        m=re.match(r'^li (\w+),(-?\d+)$',t)
        if m: out.append((m.group(1),int(m.group(2))))
    return out
if __name__=='__main__':
    A=callblocks(sys.argv[1]); B=callblocks(sys.argv[2])
    print(len(A),len(B))
    for i,(x,y) in enumerate(zip(A,B)):
        cx=consts(x); cy=consts(y)
        vx=sorted(v for _,v in cx); vy=sorted(v for _,v in cy)
        if vx!=vy:
            print(f"call#{i}: {cx}  ->  {cy}")
