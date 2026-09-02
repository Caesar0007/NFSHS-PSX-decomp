import re,sys,json
SRC='regiondiff/recon/NFS4-R-JPN/frontend/common/femenudefs.cpp'
rows=json.load(open('scratchpad/w84/R02_map.json'))
lines=open(SRC,encoding='utf-8',errors='replace').read().splitlines(True)
# init-list entry lines: from ctor open to '{'
start=None; end=None
for i,l in enumerate(lines):
    if l.startswith('tGlobalMenuDefs::tGlobalMenuDefs()'): start=i
    if start is not None and l.rstrip()=='{': end=i; break
print("ctor init list lines",start,end)
NUM=re.compile(r'\b(0[xX][0-9a-fA-F]+|\d+)\b')
def litvals(s):
    # ignore numbers inside comments
    s=re.sub(r'/\*.*?\*/','',s)
    return [(m.start(),m.end(),int(m.group(1),0)) for m in NUM.finditer(s)]
entries=[]  # (lineidx, name)
for i in range(start,end):
    m=re.match(r'^\s*[,:]\s*(\w+)\(',lines[i])
    if m: entries.append((i,m.group(1)))
print("entries",len(entries))
ptr=0
plan=[]   # (lineidx, oldval, newval)
problems=[]
for r in rows:
    base=list(r['base']); jpn=list(r['jpn'])
    # value mapping: remove common
    from collections import Counter
    cb=Counter(base); cj=Counter(jpn)
    rem=list((cb-cj).elements()); add=list((cj-cb).elements())
    rem.sort(); add.sort()
    if len(rem)!=len(add):
        problems.append((r,'card mismatch',rem,add)); continue
    pairs=list(zip(rem,add))
    # locate entry
    idx=None
    if r['line'] is not None:
        for k,(li,nm) in enumerate(entries):
            if li==r['line']-1: idx=k; break
    if idx is None:
        for k in range(ptr,len(entries)):
            li,nm=entries[k]
            vals=set(v for _,_,v in litvals(lines[li]))
            if all(o in vals for o,_ in pairs): idx=k; break
    if idx is None:
        problems.append((r,'no entry',pairs,None)); continue
    ptr=idx
    li,nm=entries[idx]
    for o,n in pairs:
        occ=[t for t in litvals(lines[li]) if t[2]==o]
        if len(occ)!=1:
            problems.append((r,'ambiguous %d occ for %d'%(len(occ),o),nm,lines[li].strip()[:90])); continue
        plan.append((li,nm,occ[0],o,n))
print("plan entries:",len(plan),"problems:",len(problems))
for p in problems: print("  !",p)
json.dump([[li,nm,list(occ),o,n] for li,nm,occ,o,n in plan],open('scratchpad/w84/R02_plan.json','w'))
