import sys, subprocess, re, itertools
P='recon/game/common/stats.cpp'; F='Stats_TrackEndGame__Fv'
orig=open(P,'rb').read().decode('latin-1')
i=orig.index('__asm__("lw %2,%3')
s=orig.rindex('              {',0,i)
e=orig.index('              }', orig.index('trackSlices));',i))+len('              }')
E='Cars_gRaceCarList[j]->stats.sliceTotal'
NL='\r\n'
def mk(b): return NL.join('              '+l if l else '' for l in b.split('\n'))
MIN=mk(f'DesiredSlice = trackSlices < {E}\n                             ? trackSlices : {E};')
base=orig[:s]+MIN+orig[e:]
PIN1=('register int PlayerPosition asm("$21");','int PlayerPosition;')
PIN2=('register int raceIndex asm("$22");','int raceIndex;')
DS  =('        __asm__("" : : "r"(DesiredSlice));','')
RI  =('                __asm__("" : : "r"(raceIndex));','')
MF  =('''              __asm__("" : "+r"(raceIndex)
                      : "m"(*(Car_tObj **)((char *)Cars_gRaceCarList +
                                           raceIndex)));''','')
def gate():
    r=subprocess.run(['python','tools/verify_asm.py',P,F],capture_output=True,text=True)
    m=re.search(r'(PASS \(\d+ insns\)|FAIL \d+ diffs \(ours \d+ / oracle \d+\))', r.stdout)
    return m.group(0) if m else 'ERR '+(r.stdout+r.stderr)[-200:].replace('\n','|')
tests=[('N0 C-min only',[]),
       ('N1 +drop pin1',[PIN1]),('N2 +drop pin2',[PIN2]),('N3 +drop both pins',[PIN1,PIN2]),
       ('N4 +drop DS fence',[DS]),('N5 +drop RI fence',[RI]),('N6 +drop m-fence',[MF]),
       ('N7 drop all pins+fences',[PIN1,PIN2,DS,RI,MF]),
       ('N8 drop pins + m-fence',[PIN1,PIN2,MF]),
       ('N9 drop pin1 + DS fence',[PIN1,DS]),
       ]
try:
    for n,subs in tests:
        t=base; ok=True
        for a,b in subs:
            if a not in t: print(f'{n:28s} SKIP {a[:30]}'); ok=False; break
            t=t.replace(a,b,1)
        if not ok: continue
        open(P,'wb').write(t.encode('latin-1'))
        print(f"{n:28s} -> {gate()}")
finally:
    open(P,'wb').write(orig.encode('latin-1')); print(f"{'RESTORED':28s} -> {gate()}")
