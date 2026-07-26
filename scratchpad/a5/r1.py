import subprocess
P='recon/eaclib/psx/eacpsxz/stream.c'
BASE=open('scratchpad/a5/stream_v2.c',encoding='utf-8').read()
WRAP="""                uVar5 = MI(s, 0x20) + moveSize;
                room = MI(s, 0x40) - uVar5;
                MI(s, 0x44) = MI(s, 0x20);
                MI(s, 0x48) = uVar5;"""
assert WRAP in BASE
def t(name, body, keep=False):
    open(P,'w',encoding='utf-8').write(BASE.replace(WRAP, body))
    if keep: print(name,'written'); return
    r=subprocess.run(['python','tools/verify_asm.py',P,'restartstream'],capture_output=True,text=True)
    ln=[l.strip() for l in r.stdout.splitlines() if 'FAIL' in l or 'PASS' in l]
    print("%-26s %s" % (name, ln[0] if ln else 'ERR '+(r.stdout+r.stderr)[-250:]))
t("base", WRAP)
t("A stage-in-room", """                room = MI(s, 0x20);
                uVar5 = room + moveSize;
                MI(s, 0x44) = room;
                room = MI(s, 0x40) - uVar5;
                MI(s, 0x48) = uVar5;""")
t("B store-first", """                MI(s, 0x44) = MI(s, 0x20);
                uVar5 = MI(s, 0x20) + moveSize;
                room = MI(s, 0x40) - uVar5;
                MI(s, 0x48) = uVar5;""")
t("C merge-into-fillptr", """                uVar5 = MU(s, 0x20);
                MI(s, 0x44) = uVar5;
                uVar5 = uVar5 + moveSize;
                room = MI(s, 0x40) - uVar5;
                MI(s, 0x48) = uVar5;""")
t("D stage-in-q", """                q = *(int **)(s + 0x20);
                uVar5 = (unsigned int)q + moveSize;
                room = MI(s, 0x40) - uVar5;
                MI(s, 0x44) = (int)q;
                MI(s, 0x48) = uVar5;""")
