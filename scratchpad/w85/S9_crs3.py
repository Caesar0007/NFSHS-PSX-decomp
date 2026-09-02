import pathlib,sys,subprocess
BASE=pathlib.Path('scratchpad/w85/S9_bak/sp2.keep')
TGT=pathlib.Path('recon/eaclib/psx/spchpsxz/spchpick.c')
OLD="""                            sentenceArg =
                                (int)(unsigned int)*(volatile unsigned short *)sentence;"""
V={
'9':"""                            sentenceArg = (int)(unsigned int)(unsigned short)sentence[0];""",
'10':"""                            sentenceArg = (int)*(unsigned short *)sentence;""",
'11':"""                            { unsigned short sh = *(unsigned short *)sentence;
                              sentenceArg = (int)(unsigned int)sh; }""",
}
s=BASE.read_text(); assert OLD in s
TGT.write_text(s.replace(OLD,V[sys.argv[1]],1))
r=subprocess.run([sys.executable,'tools/verify_asm.py',str(TGT),'iSPCH_ConstantRuleSet'],capture_output=True,text=True)
print((r.stdout or r.stderr)[:250])
