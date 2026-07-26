import subprocess
P='recon/eaclib/psx/eacpsxz/stream.c'
BASE=open(P,encoding='utf-8').read()   # variant O in place
open('scratchpad/a5/stream_O.c','w',encoding='utf-8').write(BASE)
def t(name, s, keep=False):
    open(P,'w',encoding='utf-8').write(s)
    if keep: print(name,'written'); return
    r=subprocess.run(['python','tools/verify_asm.py',P,'restartstream'],capture_output=True,text=True)
    ln=[l.strip() for l in r.stdout.splitlines() if 'FAIL' in l or 'PASS' in l]
    print("%-26s %s" % (name, ln[0] if ln else 'ERR '+(r.stdout+r.stderr)[-250:]))
OLD="""                room = MI(s, 0x40) - uVar5;
                MI(s, 0x44) = (int)bb;
                MI(s, 0x48) = uVar5;
            }
        }
        room = room - 1;"""
assert OLD in BASE
NEW="""                roomRaw = MI(s, 0x40) - uVar5;
                MI(s, 0x44) = (int)bb;
                MI(s, 0x48) = uVar5;
                room = roomRaw - 1;
            }
        }"""
s=BASE.replace("        int room;\n","        int room;\n        int roomRaw;\n").replace(OLD,NEW)
t("Q roomRaw-temp", s)
