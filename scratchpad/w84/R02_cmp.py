import re,sys,difflib,collections
sys.path.insert(0,'scratchpad/w84')
from R02_norm import load
def skel(t): return re.sub(r'-?\b\d+\b','N',t)
a=load(sys.argv[1]); b=load(sys.argv[2])
print("A",len(a),"B",len(b))
sm=difflib.SequenceMatcher(None,[skel(x) for x in a],[skel(x) for x in b],autojunk=False)
cls=collections.Counter(); ex=collections.defaultdict(list)
struct=[]
for tag,i1,i2,j1,j2 in sm.get_opcodes():
    if tag=='equal':
        for k in range(i2-i1):
            x,y=a[i1+k],b[j1+k]
            if x==y: continue
            na=[int(v) for v in re.findall(r'-?\d+',x)]; nb=[int(v) for v in re.findall(r'-?\d+',y)]
            d=tuple(q-p for p,q in zip(na,nb))
            key=('SP' if x.endswith('(sp)') else 'IMM')+str(d)
            cls[key]+=1; ex[key].append((i1+k,x,y))
    else:
        struct.append((tag,i1,i2,j1,j2))
print("--- aligned value diffs ---")
for k,v in cls.most_common(30): print(f"{k:24s} {v:5d}", ex[k][:2])
print("--- structural hunks:",len(struct))
for tag,i1,i2,j1,j2 in struct:
    print(f"@@ A[{i1}:{i2}] B[{j1}:{j2}] {tag}")
    for i in range(i1,i2): print("   -",a[i])
    for j in range(j1,j2): print("   +",b[j])
