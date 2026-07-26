import subprocess
P='recon/eaclib/psx/eacpsxz/nfile.c'
BASE=open('scratchpad/a5/nfile_base.c',encoding='utf-8').read()   # original, seqMask def OUTSIDE loop
COMBINE="""                ((FileOp *)(off + (int)gFileMgr.oparray))->id =
                    (((FileOp *)(off + (int)gFileMgr.oparray))->id & keepType) |
                    (gFileOpSeq & seqMask); /* bits 0-19 = request seq */"""
NEW="""                ((FileOp *)(off + (int)gFileMgr.oparray))->id =
                    (((FileOp *)(off + (int)gFileMgr.oparray))->id & keepType) | seqv;"""
DECL="""        do {
            FileOp *op = (FileOp *)(off + (int)gFileMgr.oparray);"""
def t(name, s):
    open(P,'w',encoding='utf-8').write(s)
    r=subprocess.run(['python','tools/verify_asm.py',P,'reserveop'],capture_output=True,text=True)
    ln=[l.strip() for l in r.stdout.splitlines() if 'FAIL' in l or 'PASS' in l]
    print("%-28s %s" % (name, ln[0] if ln else 'ERR '+(r.stdout+r.stderr)[-200:]))
s=BASE.replace(DECL, DECL+"\n            unsigned int seqv;\n            seqv = gFileOpSeq & 0xFFFFFu;").replace(COMBINE,NEW)
t("R  head-hoist NO dial", s)
