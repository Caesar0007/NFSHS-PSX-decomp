import pathlib,sys,subprocess
BASE=pathlib.Path('scratchpad/w85/S9_bak/sp1.keep')
TGT=pathlib.Path('recon/eaclib/psx/spchpsxz/spchpick.c')
OLD="""    int chBase = (int)ispch_gChoice;
    short *choice;
    __asm__("" : "=r"(chBase) : "0"(chBase));
    __asm__("" : "=r"(chBase) : "0"(chBase));
    __asm__("" : "=r"(chBase) : "0"(chBase));
    choice = (short *)(n * 12 + chBase);"""
V={
'1':"""    int chBase;
    short *choice;
    do { do { chBase = (int)ispch_gChoice; } while (0); } while (0);
    choice = (short *)(n * 12 + chBase);""",
'2':"""    int chBase;
    short *choice;
    do { do { do { chBase = (int)ispch_gChoice; } while (0); } while (0); } while (0);
    choice = (short *)(n * 12 + chBase);""",
'3':"""    int chBase;
    short *choice;
    do { chBase = (int)ispch_gChoice; } while (0);
    choice = (short *)(n * 12 + chBase);""",
'4':"""    int chBase = (int)ispch_gChoice;
    short *choice;
    choice = (short *)(n * 12 + chBase);""",
}
s=BASE.read_text(); assert OLD in s
TGT.write_text(s.replace(OLD,V[sys.argv[1]],1))
r=subprocess.run([sys.executable,'tools/verify_asm.py',str(TGT),'iSPCH_IterateChoice'],capture_output=True,text=True)
print((r.stdout or r.stderr)[:300])
