import pathlib,sys,subprocess
BASE=pathlib.Path('scratchpad/w85/S9_bak/se2.keep')
TGT=pathlib.Path('recon/eaclib/psx/spchpsxz/spchevnt.c')
OLD="""                baseTmp = (int)gVoxEvents;
                base = baseTmp;
                __asm__("" : : "r"(baseTmp));
                p    = table;
                offTmp = slot * 0x3c;
                __asm__("" : "=r"(offTmp) : "0"(offTmp));
                off  = offTmp;"""
V={
'A':"""                baseTmp = (int)gVoxEvents;
                base = baseTmp;
                __asm__("" : : "r"(baseTmp));
                p    = table;
                offTmp = slot * 0x3c;
                off  = offTmp;""",
'B':"""                baseTmp = (int)gVoxEvents;
                base = baseTmp;
                __asm__("" : : "r"(baseTmp));
                p    = table;
                offTmp = slot * 0x3c;
                off  = slot * 0x3c;""",
'C':"""                baseTmp = (int)gVoxEvents;
                base = baseTmp;
                p    = table;
                offTmp = slot * 0x3c;
                __asm__("" : "=r"(offTmp) : "0"(offTmp));
                off  = offTmp;""",
'D':"""                baseTmp = (int)gVoxEvents;
                base = baseTmp;
                p    = table;
                offTmp = slot * 0x3c;
                off  = slot * 0x3c;""",
'E':"""                baseTmp = (int)gVoxEvents;
                base = baseTmp;
                __asm__("" : : "r"(baseTmp));
                p    = table;
                off  = slot * 0x3c;
                offTmp = off;""",
}
s=BASE.read_text(); assert OLD in s
TGT.write_text(s.replace(OLD,V[sys.argv[1]],1))
r=subprocess.run([sys.executable,'tools/verify_asm.py',str(TGT),'SPCH_AddEvent'],capture_output=True,text=True)
print((r.stdout or r.stderr)[:400])
