import re,sys
_COP0 = {}
def norm_ins(t):
    t = re.sub(r'\s+', ' ', t.strip())
    t = t.replace('$', '')
    t = re.sub(r'\bs8\b', 'fp', t)
    t = re.sub(r',\s+', ',', t)
    t = re.sub(r'0x([0-9a-fA-F]+)', lambda m: str(int(m.group(1),16)), t)
    t = re.sub(r'%hi\([^)]*\)', 'HI', t)
    t = re.sub(r'%lo\([^)]*\)', 'LO', t)
    t = re.sub(r'%gp_rel\([^)]*\)', 'GP', t)
    t = re.sub(r'^move (\w+),(\w+)$', r'addu \1,\2,zero', t)
    t = re.sub(r'^or (\w+),zero,(\w+)$', r'addu \1,\2,zero', t)
    t = re.sub(r'^or (\w+),(\w+),zero$', r'addu \1,\2,zero', t)
    t = re.sub(r'^(?:addiu|ori) (\w+),zero,(\-?\d+)$', r'li \1,\2', t)
    m = re.match(r'(beq|bne)\s+(\w+,\w+),', t)
    if m: return f"{m.group(1)} {m.group(2)},T"
    m = re.match(r'(b\w+z|bgez|blez|bgtz|bltz)\s+(\w+),', t)
    if m: return f"{m.group(1)} {m.group(2)},T"
    m = re.match(r'(j|jal|b)\s+', t)
    if m: return f"{m.group(1)} T"
    return t

def load(p):
    out=[]
    for ln in open(p,encoding='utf-8',errors='replace').read().splitlines():
        s=ln.strip()
        if s.startswith('.section'): break
        s = re.sub(r'/\*.*?\*/','',ln).strip()
        if not s or s.startswith(('.','glabel','nonmatching','dlabel','jlabel','alabel')) or s.endswith(':'):
            continue
        out.append(norm_ins(s))
    return out
if __name__=='__main__':
    a=load(sys.argv[1]); b=load(sys.argv[2])
    print(len(a),len(b))
    import difflib
    sm=difflib.SequenceMatcher(None,a,b,autojunk=False)
    n=0
    for tag,i1,i2,j1,j2 in sm.get_opcodes():
        if tag=='equal': continue
        n+= (i2-i1)+(j2-j1)
        print(f"@@ A[{i1}:{i2}] B[{j1}:{j2}] {tag}")
        for i in range(i1,i2): print("   -",a[i])
        for j in range(j1,j2): print("   +",b[j])
    print("TOTAL DIFF",n)
