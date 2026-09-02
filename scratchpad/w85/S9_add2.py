import pathlib,sys,subprocess
BASE=pathlib.Path('scratchpad/w85/S9_bak/se2.keep')
TGT=pathlib.Path('recon/eaclib/psx/spchpsxz/spchevnt.c')
OLD="""                offTmp = slot * 0x3c;
                __asm__("" : "=r"(offTmp) : "0"(offTmp));
                off  = offTmp;"""
V={
'F':"""                offTmp = slot * 15;
                off  = offTmp * 4;""",
'G':"""                offTmp = slot * 0x3c;
                do { off = offTmp; } while (0);""",
'H':"""                offTmp = slot * 0x3c;
                off  = offTmp;
                offTmp = off;""",
'I':"""                offTmp = slot * 0x3c;
                off  = offTmp;
                if (offTmp != off) off = offTmp;""",
'J':"""                off  = slot * 0x3c;
                offTmp = off;
                off  = offTmp;""",
}
s=BASE.read_text(); assert OLD in s
TGT.write_text(s.replace(OLD,V[sys.argv[1]],1))
r=subprocess.run([sys.executable,'tools/verify_asm.py',str(TGT),'SPCH_AddEvent'],capture_output=True,text=True)
print((r.stdout or r.stderr)[:300])
