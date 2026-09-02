import pathlib,sys,subprocess
BASE=pathlib.Path('scratchpad/w85/S9_bak/se2.keep')
TGT=pathlib.Path('recon/eaclib/psx/spchpsxz/spchevnt.c')
OLD="""    base = addr;
    __asm__("" : : "r"(addr));
    slot = base;
    __asm__("" : "=r"(slot) : "0"(slot));
    end  = slot + 0x3c0;
    gVoxEvents[0]   = 0;
    *(int *)(base + 4) = 0;   /* DAT_80148064: stored via base+4 (oracle sw 0,4(a3)) */"""
VAR={
'5':"""    base = addr;
    slot = base;
    end  = addr + 0x3c0;
    gVoxEvents[0]   = 0;
    *(int *)(base + 4) = 0;""",
'6':"""    base = addr;
    slot = base;
    end  = base + 0x3c0;
    gVoxEvents[0]   = 0;
    *(int *)(base + 4) = 0;""",
'7':"""    base = addr;
    *(int *)(base + 4) = 0;
    slot = base;
    end  = slot + 0x3c0;
    gVoxEvents[0]   = 0;""",
'8':"""    base = addr;
    slot = base;
    end  = slot + 0x3c0;
    *(int *)addr = 0;
    *(int *)(base + 4) = 0;""",
'9':"""    base = addr;
    gVoxEvents[0]   = 0;
    slot = base;
    end  = slot + 0x3c0;
    *(int *)(base + 4) = 0;""",
'10':"""    base = addr;
    slot = base;
    gVoxEvents[0]   = 0;
    *(int *)(base + 4) = 0;
    end  = slot + 0x3c0;""",
}
s=BASE.read_text(); assert OLD in s
v=sys.argv[1]
TGT.write_text(s.replace(OLD,VAR[v],1))
r=subprocess.run([sys.executable,'tools/verify_asm.py',str(TGT),'iSPCH_InitEventQueue'],capture_output=True,text=True)
print((r.stdout or r.stderr)[:300])
