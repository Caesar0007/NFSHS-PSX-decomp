import pathlib,sys,subprocess
BASE=pathlib.Path('scratchpad/w85/S9_bak/se2.keep')
TGT=pathlib.Path('recon/eaclib/psx/spchpsxz/spchevnt.c')
OLD="""    base = addr;
    __asm__("" : : "r"(addr));
    slot = base;
    __asm__("" : "=r"(slot) : "0"(slot));
    end  = slot + 0x3c0;"""
VAR={
'1':"""    base = (int)gVoxEvents;
    slot = (int)gVoxEvents;
    end  = slot + 0x3c0;""",
'2':"""    base = addr;
    slot = (int)gVoxEvents;
    end  = slot + 0x3c0;""",
'3':"""    base = (int)gVoxEvents;
    slot = base;
    end  = slot + 0x3c0;""",
'4':"""    base = addr;
    slot = base;
    end  = (int)gVoxEvents + 0x3c0;""",
}
s=BASE.read_text()
assert OLD in s
v=sys.argv[1]
TGT.write_text(s.replace(OLD,VAR[v],1))
print(subprocess.run([sys.executable,'tools/verify_asm.py',str(TGT),'iSPCH_InitEventQueue'],capture_output=True,text=True).stdout[:400])
