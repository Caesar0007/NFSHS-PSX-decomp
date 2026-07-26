import subprocess
P='recon/eaclib/psx/eacpsxz/stream.c'
BASE=open('scratchpad/a5/stream_Q.c',encoding='utf-8').read()
def t(name, s, keep=False):
    open(P,'w',encoding='utf-8').write(s)
    if keep: print(name,'written'); return
    r=subprocess.run(['python','tools/verify_asm.py',P,'restartstream'],capture_output=True,text=True)
    ln=[l.strip() for l in r.stdout.splitlines() if 'FAIL' in l or 'PASS' in l]
    print("%-26s %s" % (name, ln[0] if ln else 'ERR '+(r.stdout+r.stderr)[-250:]))
A="""        unsigned int uVar3 = MU(s, 0x40);        /* readptr */
        unsigned int uVar5 = MU(s, 0x48);        /* fillptr */"""
assert A in BASE
t("Q base", BASE)
t("R swap-load-order", BASE.replace(A,"""        unsigned int uVar5 = MU(s, 0x48);        /* fillptr */
        unsigned int uVar3 = MU(s, 0x40);        /* readptr */"""))
t("S yoda-compare", BASE.replace("        if (uVar3 > uVar5) {","        if (uVar5 < uVar3) {"))
t("T decl-split", BASE.replace(A,"""        unsigned int uVar3;
        unsigned int uVar5;
        uVar3 = MU(s, 0x40);                     /* readptr */
        uVar5 = MU(s, 0x48);                     /* fillptr */"""))
