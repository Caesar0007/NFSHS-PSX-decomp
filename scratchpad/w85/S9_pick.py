import pathlib,sys,subprocess
BASE=pathlib.Path('scratchpad/w85/S9_bak/sp0.keep')
TGT=pathlib.Path('recon/eaclib/psx/spchpsxz/spchpick.c')
OLD="""extern int iSPCH_ChooseSamples(short *choice, int maxToPick, volatile int phraseTemplate, volatile int unused)"""
BODY="""        do {
            int r;
            r = iSPCH_UnPackSample(bank, sampleIdx, tmp);
            if (r != 0 &&
                iSPCH_MatchSample(bankIdx, (int)tmp, phraseTemplate, unused) != 0) {"""
V={
'A':(("extern int iSPCH_ChooseSamples(short *choice, int maxToPick, int phraseTemplate, int unused)"),BODY),
'B':(("extern int iSPCH_ChooseSamples(short *choice, int maxToPick, int phraseTemplate, int unused)"),
"""        do {
            int r;
            int *ptSlot = &phraseTemplate;
            int *unusedSlot = &unused;
            r = iSPCH_UnPackSample(bank, sampleIdx, tmp);
            if (r != 0 &&
                iSPCH_MatchSample(bankIdx, (int)tmp, *ptSlot, *unusedSlot) != 0) {"""),
'C':(("extern int iSPCH_ChooseSamples(short *choice, int maxToPick, int phraseTemplate, int unused)"),
"""        do {
            int r;
            r = iSPCH_UnPackSample(bank, sampleIdx, tmp);
            if (r != 0 &&
                iSPCH_MatchSample(bankIdx, (int)tmp, *&phraseTemplate, *&unused) != 0) {"""),
}
s=BASE.read_text(); assert OLD in s and BODY in s
h,b=V[sys.argv[1]]
s=s.replace(OLD,h,1).replace(BODY,b,1)
TGT.write_text(s)
r=subprocess.run([sys.executable,'tools/verify_asm.py',str(TGT),'iSPCH_ChooseSamples'],capture_output=True,text=True)
print((r.stdout or r.stderr)[:400])
