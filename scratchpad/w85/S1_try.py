import subprocess,sys,shutil,os
ROOT=r'C:/Temp/nfs4-decomp'
def gate(path,fn):
    r=subprocess.run([sys.executable,'tools/verify_asm.py',path,fn],capture_output=True,text=True,cwd=ROOT)
    out=[l.strip() for l in (r.stdout+r.stderr).splitlines() if l.strip()]
    hit=[l for l in out if l.startswith(fn+':')]
    return hit[0] if hit else ('ERR '+(out[-1] if out else ''))
def apply(path,pairs):
    full=os.path.join(ROOT,path)
    s=open(full,newline='').read()
    crlf='\r\n' in s
    for o,n in pairs:
        oo=o.replace('\n','\r\n') if crlf else o
        nn=n.replace('\n','\r\n') if crlf else n
        if oo not in s: return False,'NOMATCH:'+o[:40]
        s=s.replace(oo,nn,1)
    open(full,'w',newline='').write(s)
    return True,''
def trialM(path,fn,base,pairs,label):
    ok,err=apply(path,pairs)
    if not ok:
        print(f'{label}: {err}'); shutil.copy(os.path.join(ROOT,base),os.path.join(ROOT,path)); return
    r=gate(path,fn)
    print(f'{label}: {r}')
    shutil.copy(os.path.join(ROOT,base),os.path.join(ROOT,path))
