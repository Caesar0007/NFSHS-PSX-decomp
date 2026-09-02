"""Probe: delete one __asm__ statement (whole statement, incl. multi-line) and re-gate the file."""
import re,subprocess,sys,os,shutil
ROOT=r'C:/Temp/nfs4-decomp'
def stmts(path):
    s=open(os.path.join(ROOT,path),newline='').read()
    # mask comments so we only find live asm
    masked=re.sub(r'/\*.*?\*/',lambda m:' '*len(m.group(0)),s,flags=re.S)
    out=[]
    for m in re.finditer(r'__asm__(?:\s+(?:volatile|__volatile__))?\s*\(',masked):
        i=m.start()
        # find matching close paren then the ';'
        j=masked.index('(',i); depth=0; k=j
        while True:
            c=masked[k]
            if c=='(':depth+=1
            elif c==')':
                depth-=1
                if depth==0: break
            k+=1
        e=masked.index(';',k)+1
        # extend to include leading whitespace on the line and the trailing newline
        ls=s.rfind('\n',0,i)+1
        le=e
        if s[e:e+2]=='\r\n': le=e+2
        elif s[e:e+1]=='\n': le=e+1
        out.append((ls,le,s[ls:le]))
    return s,out
def tugate(path):
    r=subprocess.run([sys.executable,'tools/tugate.py',path],capture_output=True,text=True,cwd=ROOT)
    lines=[l.strip() for l in (r.stdout+r.stderr).splitlines() if l.strip() and '__none__' not in l]
    return lines
def probe(path,backup):
    s,sts=stmts(path)
    print('#',path,len(sts),'asm statements')
    for idx,(a,b,txt) in enumerate(sts):
        new=s[:a]+s[b:]
        open(os.path.join(ROOT,path),'w',newline='').write(new)
        res=tugate(path)
        print('  [%d] %s' % (idx, txt.strip().replace('\r\n',' ')[:90]))
        print('      ->', res[0] if res else 'ERR', ('| '+'; '.join(res[1:3])) if len(res)>1 else '')
        shutil.copy(os.path.join(ROOT,backup),os.path.join(ROOT,path))
