import re,subprocess,difflib,sys
src,fn=sys.argv[1],sys.argv[2]
out=subprocess.run(['python','tools/sbs.py',src,fn],capture_output=True,text=True).stdout
lines=out.splitlines()
try: start=next(i for i,l in enumerate(lines) if l.startswith('ours='))+1
except StopIteration: sys.exit(out)
o,r=[],[]
for ln in lines[start:]:
    if '|' not in ln: continue
    L,R=ln.split('|',1)
    L=re.sub(r'^\s*\d+\s','',L).strip().rstrip('X').strip()
    R=re.sub(r'^\s*\d+\s','',R).strip()
    if L: o.append(L)
    if R: r.append(R)
def blind(s):
    return re.sub(r'(\b[sl]w \w+,)\d+\(sp\)',r'\1X(sp)',s)
ob=[blind(x) for x in o]; rb=[blind(x) for x in r]
sm=difflib.SequenceMatcher(None,ob,rb)
d=sum(max(i2-i1,j2-j1) for t,i1,i2,j1,j2 in sm.get_opcodes() if t!='equal')
print(f"{fn}: sp-BLIND diff {d}   (ours {len(o)} / oracle {len(r)})")
for t,i1,i2,j1,j2 in sm.get_opcodes():
    if t!='equal':
        print('  ',t,ob[i1:i2],'->',rb[j1:j2])
