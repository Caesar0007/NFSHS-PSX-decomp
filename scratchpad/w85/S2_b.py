import subprocess, re
P='recon/game/common/stats.cpp'; F='Stats_TrackEndGame__Fv'
ORIG=open(P,'rb').read().decode('latin-1')
i=ORIG.index('__asm__("lw %2,%3')
S=ORIG.rindex('              {',0,i)
E_=ORIG.index('              }', ORIG.index('trackSlices));',i))+len('              }')
EXPR='Cars_gRaceCarList[j]->stats.sliceTotal'
NL='\r\n'
def mk(b): return NL.join('              '+l if l else '' for l in b.split('\n'))
def base(minbody=None):
    mb = minbody if minbody is not None else f'DesiredSlice = trackSlices < {EXPR}\n                             ? trackSlices : {EXPR};'
    return ORIG[:S]+mk(mb)+ORIG[E_:]
PIN1=('register int PlayerPosition asm("$21");','int PlayerPosition;')
PIN2=('register int raceIndex asm("$22");','int raceIndex;')
DS  =('        __asm__("" : : "r"(DesiredSlice));','')
RI  =('                __asm__("" : : "r"(raceIndex));','')
MF  =('''              __asm__("" : "+r"(raceIndex)
                      : "m"(*(Car_tObj **)((char *)Cars_gRaceCarList +
                                           raceIndex)));
''','')
def gate(full=False):
    r=subprocess.run(['python','tools/verify_asm.py',P,F],capture_output=True,text=True)
    if full: return r.stdout
    m=re.search(r'(PASS \(\d+ insns\)|FAIL \d+ diffs \(ours \d+ / oracle \d+\))', r.stdout)
    return m.group(0) if m else 'ERR '+(r.stdout+r.stderr)[-200:].replace('\n','|')
def apply(t,subs):
    for a,b in subs:
        if a not in t: return None
        t=t.replace(a,b,1)
    return t
def run(tests, minbody=None, full=False):
    try:
        for n,subs in tests:
            t=apply(base(minbody),subs)
            if t is None: print(f'{n:34s} SKIP'); continue
            open(P,'wb').write(t.encode('latin-1'))
            print(f"{n:34s} -> {gate(full)}")
    finally:
        open(P,'wb').write(ORIG.encode('latin-1'))
