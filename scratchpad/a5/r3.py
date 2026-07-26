import subprocess
P='recon/eaclib/psx/eacpsxz/stream.c'
BASE=open('scratchpad/a5/stream_v2.c',encoding='utf-8').read()
BLOCK="""                memcpy(*(unsigned char **)(s + 0x20), *(unsigned char **)(s + 0x44), moveSize);
                q = *(int **)(s + 0x44);
                q[0] = -1;                       /* leave a wrap marker behind */
                q[1] = 8;
                uVar5 = MI(s, 0x20) + moveSize;
                room = MI(s, 0x40) - uVar5;
                MI(s, 0x44) = MI(s, 0x20);
                MI(s, 0x48) = uVar5;"""
assert BLOCK in BASE
def t(name, body, keep=False):
    open(P,'w',encoding='utf-8').write(BASE.replace(BLOCK, body))
    if keep: print(name,'written'); return
    r=subprocess.run(['python','tools/verify_asm.py',P,'restartstream'],capture_output=True,text=True)
    ln=[l.strip() for l in r.stdout.splitlines() if 'FAIL' in l or 'PASS' in l]
    print("%-26s %s" % (name, ln[0] if ln else 'ERR '+(r.stdout+r.stderr)[-250:]))
HD="""                memcpy(*(unsigned char **)(s + 0x20), *(unsigned char **)(s + 0x44), moveSize);
                q = *(int **)(s + 0x44);
"""
t("E q-live-across-bb", HD+"""                uVar5 = MI(s, 0x20) + moveSize;
                q[0] = -1;
                q[1] = 8;
                room = MI(s, 0x40) - uVar5;
                MI(s, 0x44) = MI(s, 0x20);
                MI(s, 0x48) = uVar5;""")
t("F A+q-live", HD+"""                room = MI(s, 0x20);
                q[0] = -1;
                q[1] = 8;
                uVar5 = room + moveSize;
                MI(s, 0x44) = room;
                room = MI(s, 0x40) - uVar5;
                MI(s, 0x48) = uVar5;""")
t("G A+store-order-swap", HD+"""                q[0] = -1;
                q[1] = 8;
                room = MI(s, 0x20);
                uVar5 = room + moveSize;
                room = MI(s, 0x40) - uVar5;
                MI(s, 0x44) = MI(s, 0x20);
                MI(s, 0x48) = uVar5;""")
t("H A+bb-store-last", HD+"""                q[0] = -1;
                q[1] = 8;
                room = MI(s, 0x20);
                uVar5 = room + moveSize;
                room = MI(s, 0x40) - uVar5;
                MI(s, 0x48) = uVar5;
                MI(s, 0x44) = MI(s, 0x20);""")
