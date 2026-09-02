import re, sys, difflib
ours=[l.rstrip() for l in open(sys.argv[1]) if l.strip()]
orc=[l.rstrip() for l in open(sys.argv[2]) if l.strip()]
def n(t):
    t=re.sub(r'\s+',' ',t.strip()).replace('$','')
    t=re.sub(r',\s+',',',t)
    t=re.sub(r'0x([0-9a-fA-F]+)',lambda m:str(int(m.group(1),16)),t)
    t=re.sub(r'%hi\([^)]*\)','0',t); t=re.sub(r'%lo\([^)]*\)','0',t); t=re.sub(r'%gp_rel\([^)]*\)','0',t)
    t=re.sub(r'^move (\w+),(\w+)$',r'addu \1,\2,zero',t)
    t=re.sub(r'^(?:addiu|ori) (\w+),zero,(-?\d+)$',r'li \1,\2',t)
    m=re.match(r'(beq|bne)\s+(\w+,\w+),',t)
    if m: return f"{m.group(1)} {m.group(2)},T"
    m=re.match(r'(b\w+z|bgez|blez|bgtz|bltz)\s+(\w+),',t)
    if m: return f"{m.group(1)} {m.group(2)},T"
    m=re.match(r'(j|jal|b)\s+',t)
    if m: return f"{m.group(1)} T"
    return t
A=[n(x) for x in ours]; B=[n(x) for x in orc]
def sk(t): return re.sub(r'-?\b\d+\b','N',t)
sm=difflib.SequenceMatcher(None,[sk(x) for x in A],[sk(x) for x in B],autojunk=False)
for tag,i1,i2,j1,j2 in sm.get_opcodes():
    if tag=='equal': continue
    print('---',tag,'ours[%d:%d] oracle[%d:%d]'%(i1,i2,j1,j2))
    for k in range(max(0,i1-5),min(len(A),i2+5)):
        print('   O%3d %s%s'%(k,'* ' if i1<=k<i2 else '  ',A[k]))
    print('   ~~~')
    for k in range(max(0,j1-5),min(len(B),j2+5)):
        print('   R%3d %s%s'%(k,'* ' if j1<=k<j2 else '  ',B[k]))
