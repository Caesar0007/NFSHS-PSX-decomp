import subprocess
P='recon/eaclib/psx/eacpsxz/nfile.c'
BASE=open('scratchpad/a5/nfile_base.c',encoding='utf-8').read()
def t(name,s):
    open(P,'w',encoding='utf-8').write(s)
    r=subprocess.run(['python','tools/verify_asm.py',P,'reserveop'],capture_output=True,text=True)
    ln=[l.strip() for l in r.stdout.splitlines() if 'FAIL' in l or 'PASS' in l]
    print("%-28s %s" % (name, ln[0] if ln else 'ERR '+(r.stdout+r.stderr)[-200:]))
LOCALS="""        unsigned int clearType = 0xFF0FFFFFu;
        unsigned int setType = 0x100000u;
        unsigned int seqMask = 0xFFFFFu;
        unsigned int keepType = 0xFFF00000u;
"""
# T: all literals
s=BASE.replace(LOCALS,"")
s=s.replace("clearType) | setType","0xFF0FFFFFu) | 0x100000u").replace("& keepType)","& 0xFFF00000u)").replace("(gFileOpSeq & seqMask)","(gFileOpSeq & 0xFFFFFu)").replace("(int)seqMask)","0xFFFFF)")
t("T  all-literals", s)
# S: literals except seqMask local, dialled in-loop
s=BASE.replace(LOCALS,"        unsigned int seqMask;\n")
s=s.replace("""        do {
            FileOp *op = (FileOp *)(off + (int)gFileMgr.oparray);""","""        do {
            FileOp *op = (FileOp *)(off + (int)gFileMgr.oparray);
            seqMask = 0xFFFFFu;""")
s=s.replace("clearType) | setType","0xFF0FFFFFu) | 0x100000u").replace("& keepType)","& 0xFFF00000u)")
t("S  literals+seqMask-dial", s)
