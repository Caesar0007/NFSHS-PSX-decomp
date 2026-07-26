import sys,subprocess
P='recon/eaclib/psx/eacpsxz/nfile.c'
BASE=open('scratchpad/a5/nfile_varA.c',encoding='utf-8').read()
COMBINE="""                ((FileOp *)(off + (int)gFileMgr.oparray))->id =
                    (((FileOp *)(off + (int)gFileMgr.oparray))->id & keepType) |
                    (gFileOpSeq & seqMask); /* bits 0-19 = request seq */
                if (++gFileOpSeq > (int)seqMask)             /* 20-bit wrap */
                    gFileOpSeq = 0;"""
DECL="""            FileOp *op = (FileOp *)(off + (int)gFileMgr.oparray);
            seqMask = 0xFFFFFu;"""
GUARD="""            if (((op->id >> 0x14) & 0xF) == 0) {
                op->id = (op->id & clearType) | setType; /* set type nibble = 1 */"""
def build(name, decl_extra, guard_pre, combine, write_only=False):
    s=BASE
    if decl_extra: s=s.replace(DECL, "            FileOp *op = (FileOp *)(off + (int)gFileMgr.oparray);\n"+decl_extra+"            seqMask = 0xFFFFFu;")
    if guard_pre: s=s.replace(GUARD, GUARD.split('\n')[0]+"\n"+guard_pre+GUARD.split('\n')[1])
    if combine: s=s.replace(COMBINE, combine)
    open(P,'w',encoding='utf-8').write(s)
    if write_only: print(name,'written'); return
    r=subprocess.run(['python','tools/verify_asm.py',P,'reserveop'],capture_output=True,text=True)
    ln=[l.strip() for l in r.stdout.splitlines() if 'FAIL' in l or 'PASS' in l]
    print("%-30s %s" % (name, ln[0] if ln else 'ERR '+(r.stdout+r.stderr)[-300:]))
