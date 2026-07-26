import subprocess
P='recon/eaclib/psx/eacpsxz/stream.c'
BASE0=open('scratchpad/a5/stream_v2.c',encoding='utf-8').read()
DECL="""    int *p;
    int *q;
    int  sr;"""
OLD="""                int moveSize = uVar5 - (int)*(unsigned char **)(s + 0x44);
                if ((int)(uVar3 - (int)*(unsigned char **)(s + 0x20)) < moveSize + 1)
                    goto stall;
                memcpy(*(unsigned char **)(s + 0x20), *(unsigned char **)(s + 0x44), moveSize);
                q = *(int **)(s + 0x44);
                q[0] = -1;                       /* leave a wrap marker behind */
                q[1] = 8;
                uVar5 = MI(s, 0x20) + moveSize;
                room = MI(s, 0x40) - uVar5;
                MI(s, 0x44) = MI(s, 0x20);
                MI(s, 0x48) = uVar5;"""
assert OLD in BASE0
def t(name, decl, body, keep=False):
    open(P,'w',encoding='utf-8').write(BASE0.replace(DECL,decl).replace(OLD, body))
    if keep: print(name,'written'); return
    r=subprocess.run(['python','tools/verify_asm.py',P,'restartstream'],capture_output=True,text=True)
    ln=[l.strip() for l in r.stdout.splitlines() if 'FAIL' in l or 'PASS' in l]
    print("%-26s %s" % (name, ln[0] if ln else 'ERR '+(r.stdout+r.stderr)[-250:]))
D2="    int *p;\n    int *q;\n    int  sr;\n    unsigned char *bb;"
B2="""                int moveSize = uVar5 - (int)*(unsigned char **)(s + 0x44);
                bb = *(unsigned char **)(s + 0x20);
                if ((int)(uVar3 - (int)bb) < moveSize + 1)
                    goto stall;
                memcpy(bb, *(unsigned char **)(s + 0x44), moveSize);
                q = *(int **)(s + 0x44);
                q[0] = -1;                       /* leave a wrap marker behind */
                q[1] = 8;
                bb = *(unsigned char **)(s + 0x20);
                uVar5 = (unsigned int)bb + moveSize;
                room = MI(s, 0x40) - uVar5;
                MI(s, 0x44) = (int)bb;
                MI(s, 0x48) = uVar5;"""
t("O bb-both-reads", D2, B2)
B3=B2.replace("""                bb = *(unsigned char **)(s + 0x20);
                if ((int)(uVar3 - (int)bb) < moveSize + 1)
                    goto stall;
                memcpy(bb,""","""                if ((int)(uVar3 - (int)*(unsigned char **)(s + 0x20)) < moveSize + 1)
                    goto stall;
                bb = *(unsigned char **)(s + 0x20);
                memcpy(bb,""")
t("P bb-memcpy-only", D2, B3)
