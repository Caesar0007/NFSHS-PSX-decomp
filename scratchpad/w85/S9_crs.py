import pathlib,sys,subprocess
BASE=pathlib.Path('scratchpad/w85/S9_bak/sp2.keep')
TGT=pathlib.Path('recon/eaclib/psx/spchpsxz/spchpick.c')
OLD="""                            sentenceArg =
                                (int)(unsigned int)*(volatile unsigned short *)sentence;
                            bit = one << cycle[0x1c];"""
V={
'1':"""                            sentenceArg =
                                (int)(unsigned int)*(unsigned short *)sentence;
                            bit = one << cycle[0x1c];""",
'2':"""                            do {
                                sentenceArg =
                                    (int)(unsigned int)*(unsigned short *)sentence;
                            } while (0);
                            bit = one << cycle[0x1c];""",
'3':"""                            do { do {
                                sentenceArg =
                                    (int)(unsigned int)*(unsigned short *)sentence;
                            } while (0); } while (0);
                            bit = one << cycle[0x1c];""",
'4':"""                            sentenceArg =
                                (int)(unsigned int)*(unsigned short *)sentence;
                            do { } while (0);
                            bit = one << cycle[0x1c];""",
}
s=BASE.read_text(); assert OLD in s
TGT.write_text(s.replace(OLD,V[sys.argv[1]],1))
r=subprocess.run([sys.executable,'tools/verify_asm.py',str(TGT),'iSPCH_ConstantRuleSet'],capture_output=True,text=True)
print((r.stdout or r.stderr)[:300])
