import pathlib,sys,subprocess
BASE=pathlib.Path('scratchpad/w85/S9_bak/se3.keep')
TGT=pathlib.Path('recon/eaclib/psx/spchpsxz/spchevnt.c')
OLD="""    base = addr;
    __asm__("" : : "r"(addr));
    slot = base;
    __asm__("" : "=r"(slot) : "0"(slot));
    end  = slot + 0x3c0;"""
V={
'a':"""    do { do { base = addr; } while (0); } while (0);
    do { do { slot = base; } while (0); } while (0);
    end  = slot + 0x3c0;""",
'b':"""    do { do { do { base = addr; } while (0); } while (0); } while (0);
    do { do { do { slot = base; } while (0); } while (0); } while (0);
    end  = slot + 0x3c0;""",
'c':"""    base = addr;
    do { do { slot = base; } while (0); } while (0);
    end  = slot + 0x3c0;""",
'd':"""    base = (int)gVoxEventQueue;
    slot = (int)gVoxQueue;
    end  = slot + 0x3c0;""",
'e':"""    do { do { addr = (int)gVoxEvents; } while (0); } while (0);
    base = addr;
    slot = base;
    end  = slot + 0x3c0;""",
}
s=BASE.read_text(); assert OLD in s
TGT.write_text(s.replace(OLD,V[sys.argv[1]],1))
r=subprocess.run([sys.executable,'tools/verify_asm.py',str(TGT),'iSPCH_InitEventQueue'],capture_output=True,text=True)
print((r.stdout or r.stderr)[:200])
