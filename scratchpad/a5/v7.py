import subprocess
P='recon/eaclib/psx/eacpsxz/nfile.c'
BASE=open('scratchpad/a5/nfile_base.c',encoding='utf-8').read()
DIAL=open('scratchpad/a5/nfile_varA.c',encoding='utf-8').read()
def t(name,s):
    open(P,'w',encoding='utf-8').write(s)
    r=subprocess.run(['python','tools/verify_asm.py',P,'reserveop'],capture_output=True,text=True)
    ln=[l.strip() for l in r.stdout.splitlines() if 'FAIL' in l or 'PASS' in l]
    print("%-30s %s" % (name, ln[0] if ln else 'ERR '+(r.stdout+r.stderr)[-200:]))
G0="""            if (((op->id >> 0x14) & 0xF) == 0) {
                op->id = (op->id & clearType) | setType; /* set type nibble = 1 */"""
G1="""            if (((op->id >> 0x14) & 0xF) == 0) {
                unsigned int seq = gFileOpSeq;
                op->id = (op->id & clearType) | setType; /* set type nibble = 1 */"""
C0="""                    (gFileOpSeq & seqMask); /* bits 0-19 = request seq */
                if (++gFileOpSeq > (int)seqMask)             /* 20-bit wrap */
                    gFileOpSeq = 0;"""
C1="""                    (seq & seqMask); /* bits 0-19 = request seq */
                if (++gFileOpSeq > (int)seqMask)             /* 20-bit wrap */
                    gFileOpSeq = 0;"""
C2="""                    (seq & seqMask); /* bits 0-19 = request seq */
                gFileOpSeq = seq + 1;
                if (gFileOpSeq > (int)seqMask)             /* 20-bit wrap */
                    gFileOpSeq = 0;"""
for nm,b in (("base",BASE),("dial",DIAL)):
    t("U seq-local %s"%nm, b.replace(G0,G1).replace(C0,C1))
    t("V seq-local+split %s"%nm, b.replace(G0,G1).replace(C0,C2))
