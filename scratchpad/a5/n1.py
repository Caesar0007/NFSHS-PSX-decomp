import subprocess
P='recon/eaclib/psx/eacpsxz/nsync.c'
BASE=open('scratchpad/a5/nsync_base.c',encoding='utf-8').read()
FN_OLD="""extern void *loadfileadratomic(int retry, LoadArgs *a)   /* @0x800E56B0 */
{
    int handle;"""
def t(name,s,keep=False):
    open(P,'w',encoding='utf-8').write(s)
    if keep: print(name,'written'); return
    r=subprocess.run(['python','tools/verify_asm.py',P,'loadfileadratomic'],capture_output=True,text=True)
    ln=[l.strip() for l in r.stdout.splitlines() if 'FAIL' in l or 'PASS' in l]
    print("%-26s %s" % (name, ln[0] if ln else 'ERR '+(r.stdout+r.stderr)[-250:]))
t("base", BASE)
# param-copy dial: local copy of `a`, used at every deref
body=BASE
start=body.index(FN_OLD); end=body.index("\n}", start)
fn=body[start:end]
fn2=fn.replace(FN_OLD, FN_OLD+"\n    LoadArgs *aa = a;   /* param-copy priority dial */")
fn2=fn2.replace("a->name","aa->name").replace("a->memclass","aa->memclass")
t("A param-copy-dial", body[:start]+fn2+body[end:])
