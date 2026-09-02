import sys, subprocess, re
sys.path.insert(0,'scratchpad/w85')
P='recon/game/common/stats.cpp'; F='Stats_TrackEndGame__Fv'
def read(): return open(P,'rb').read().decode('latin-1')
def write(t): open(P,'wb').write(t.encode('latin-1'))
def gate():
    r=subprocess.run(['python','tools/verify_asm.py',P,F],capture_output=True,text=True)
    m=re.search(r'(PASS \(\d+ insns\)|FAIL (\d+) diffs \(ours (\d+) / oracle \d+\))', r.stdout)
    return m.group(0) if m else 'ERR '+(r.stdout+r.stderr)[-300:].replace('\n','|')
orig=read()
i=orig.index('__asm__("lw %2,%3')
s=orig.rindex('              {',0,i)
e=orig.index('              }', orig.index('trackSlices));',i))+len('              }')
BLOCK=orig[s:e]
NL='\r\n'
def mk(body):
    return NL.join('              '+l if l else '' for l in body.split('\n'))
E='Cars_gRaceCarList[j]->stats.sliceTotal'
cands={
 'M1 direct ternary': f'DesiredSlice = trackSlices < {E}\n                             ? trackSlices : {E};',
 'M2 override default=trackSlices': f'DesiredSlice = trackSlices;\nif ({E} <= trackSlices) {{\n  DesiredSlice = {E};\n}}',
 'M3 override default=sliceTotal': f'DesiredSlice = {E};\nif (trackSlices < DesiredSlice) {{\n  DesiredSlice = trackSlices;\n}}',
 'M4 if/else both arms': f'if (trackSlices < {E}) {{\n  DesiredSlice = trackSlices;\n}}\nelse {{\n  DesiredSlice = {E};\n}}',
 'M5 if/else reversed test': f'if ({E} <= trackSlices) {{\n  DesiredSlice = {E};\n}}\nelse {{\n  DesiredSlice = trackSlices;\n}}',
 'M6 temp + ternary': f'{{\n  int sliceTotal = {E};\n  DesiredSlice = trackSlices < sliceTotal ? trackSlices : sliceTotal;\n}}',
 'M7 temp + if/else': f'{{\n  int sliceTotal = {E};\n  if (trackSlices < sliceTotal) {{\n    DesiredSlice = trackSlices;\n  }}\n  else {{\n    DesiredSlice = sliceTotal;\n  }}\n}}',
 'M8 volatile-view ternary (W72 V)': f'DesiredSlice = trackSlices < {E}\n                             ? trackSlices : *(volatile int *)&{E};',
}
try:
    for n,b in cands.items():
        write(orig[:s]+mk(b)+orig[e:])
        print(f"{n:36s} -> {gate()}")
finally:
    write(orig); print(f"{'RESTORED':36s} -> {gate()}")
