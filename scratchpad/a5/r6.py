import subprocess
P='recon/eaclib/psx/eacpsxz/stream.c'
BASE0=open('scratchpad/a5/stream_v2.c',encoding='utf-8').read()
DECL="""    int *p;
    int *q;
    int  sr;"""
assert DECL in BASE0
BLOCK="""                uVar5 = MI(s, 0x20) + moveSize;
                room = MI(s, 0x40) - uVar5;
                MI(s, 0x44) = MI(s, 0x20);
                MI(s, 0x48) = uVar5;"""
def t(name, decl, body, keep=False):
    open(P,'w',encoding='utf-8').write(BASE0.replace(DECL,decl).replace(BLOCK, body))
    if keep: print(name,'written'); return
    r=subprocess.run(['python','tools/verify_asm.py',P,'restartstream'],capture_output=True,text=True)
    ln=[l.strip() for l in r.stdout.splitlines() if 'FAIL' in l or 'PASS' in l]
    print("%-26s %s" % (name, ln[0] if ln else 'ERR '+(r.stdout+r.stderr)[-250:]))
BB="""                bb = *(int **)(s + 0x20);
                uVar5 = (unsigned int)bb + moveSize;
                room = MI(s, 0x40) - uVar5;
                MI(s, 0x44) = (int)bb;
                MI(s, 0x48) = uVar5;"""
t("L bb-after-p", "    int *p;\n    int *bb;\n    int *q;\n    int  sr;", BB)
t("M bb-first",  "    int *bb;\n    int *p;\n    int *q;\n    int  sr;", BB)
t("N bb-last",   "    int *p;\n    int *q;\n    int  sr;\n    int *bb;", BB)
