"""Whole-TU probe: apply subs, run tugate, restore."""
import subprocess, re, traceback
CR=chr(13); LF=chr(10); CRLF=CR+LF
def read(p): return open(p,'rb').read().decode('latin-1')
def write(p,t): open(p,'wb').write(t.encode('latin-1'))
def tugate(p):
    r=subprocess.run(['python','tools/tugate.py',p],capture_output=True,text=True)
    ls=[l for l in r.stdout.splitlines() if 'NO ORACLE' not in l]
    return ' | '.join(x.strip() for x in ls) or ('ERR '+(r.stdout+r.stderr)[-300:].replace(LF,'/'))
def norm(s,crlf):
    s=s.replace(CRLF,LF)
    return s.replace(LF,CRLF) if crlf else s
def run(path, tests):
    orig=read(path); crlf=CRLF in orig
    try:
        for name,subs in tests:
            t=orig; ok=True
            for a,b in subs:
                a=norm(a,crlf); b=norm(b,crlf)
                if a not in t: print("%-34s -> SKIP"%name); ok=False; break
                t=t.replace(a,b,1)
            if not ok: continue
            write(path,t); print("%-34s -> %s"%(name,tugate(path)))
    except Exception: traceback.print_exc()
    finally:
        write(path,orig); print("%-34s -> %s"%('RESTORED',tugate(path)))
