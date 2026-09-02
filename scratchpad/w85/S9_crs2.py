import pathlib,sys,subprocess
BASE=pathlib.Path('scratchpad/w85/S9_bak/sp2.keep')
TGT=pathlib.Path('recon/eaclib/psx/spchpsxz/spchpick.c')
OLD="""                            one = 1;
                            do {
                                setRule = gSentenceRuleSet;
                            } while (0);
                            sentenceArg =
                                (int)(unsigned int)*(volatile unsigned short *)sentence;
                            bit = one << cycle[0x1c];
                            do {
                                callee = *setRule;
                            } while (0);"""
P="""                                (int)(unsigned int)*(unsigned short *)sentence;"""
V={
'5':"""                            one = 1;
                            sentenceArg =
"""+P+"""
                            do {
                                setRule = gSentenceRuleSet;
                            } while (0);
                            bit = one << cycle[0x1c];
                            do {
                                callee = *setRule;
                            } while (0);""",
'6':"""                            one = 1;
                            do {
                                setRule = gSentenceRuleSet;
                            } while (0);
                            do {
                                sentenceArg =
"""+P+"""
                            } while (0);
                            do {
                                bit = one << cycle[0x1c];
                            } while (0);
                            do {
                                callee = *setRule;
                            } while (0);""",
'7':"""                            one = 1;
                            do {
                                setRule = gSentenceRuleSet;
                            } while (0);
                            sentenceArg =
"""+P+"""
                            do {
                                callee = *setRule;
                            } while (0);
                            bit = one << cycle[0x1c];""",
'8':"""                            one = 1;
                            do {
                                setRule = gSentenceRuleSet;
                            } while (0);
                            sentenceArg =
"""+P+"""
                            bit = one << cycle[0x1c];
                            callee = *setRule;""",
}
s=BASE.read_text(); assert OLD in s
TGT.write_text(s.replace(OLD,V[sys.argv[1]],1))
r=subprocess.run([sys.executable,'tools/verify_asm.py',str(TGT),'iSPCH_ConstantRuleSet'],capture_output=True,text=True)
print((r.stdout or r.stderr)[:300])
