import subprocess
P='recon/eaclib/psx/eacpsxz/stream.c'
BASE=open('scratchpad/a5/stream_base.c',encoding='utf-8').read()
ORIG="""    cur  = MI(s, 0x50);
    done = 1;
    if (cur != 0) {
        done = 0;
        if (MI(cur, 4) != 1) {                  /* current no longer queued */
            int nx = MI(cur, 0xc);              /* advance to next */
            if (nx == 0)
                done = 1;
            else
                MI(s, 0x50) = nx;
        }
    }"""
def t(name, body, keep=False):
    open(P,'w',encoding='utf-8').write(BASE.replace(ORIG, body))
    if keep: print(name,'written'); return
    r=subprocess.run(['python','tools/verify_asm.py',P,'startnextrequest'],capture_output=True,text=True)
    ln=[l.strip() for l in r.stdout.splitlines() if 'FAIL' in l or 'PASS' in l]
    print("%-26s %s" % (name, ln[0] if ln else 'ERR '+(r.stdout+r.stderr)[-250:]))
t("shipped", ORIG)
MERGED="""    cur  = MI(s, 0x50);
    done = 1;
    if (cur != 0) {
        done = MI(cur, 4);                      /* merged: state temp IS done */
        if (done != 1) {                        /* current no longer queued */
            int nx = MI(cur, 0xc);              /* advance to next */
            if (nx == 0)
                done = 1;
            else {
                MI(s, 0x50) = nx;
                done = 0;
            }
        } else {
            done = 0;
        }
    }"""
t("merged", MERGED)
