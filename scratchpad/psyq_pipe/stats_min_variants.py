import re, subprocess, difflib, sys
s = open('../../recon/game/common/stats.cpp.i', encoding='utf-8', errors='replace').read()
a = s.index('Car_tObj *sliceCar;'); b = s.index('"r"(trackSlices));', a) + len('"r"(trackSlices));')
V = {
 'A': 'DesiredSlice = trackSlices;\n if (!(trackSlices < Cars_gRaceCarList[j]->stats.sliceTotal)) DesiredSlice = Cars_gRaceCarList[j]->stats.sliceTotal;',
 'B': 'Car_tObj *sliceCar = Cars_gRaceCarList[j]; int sliceTotal = sliceCar->stats.sliceTotal;\n DesiredSlice = trackSlices; if (trackSlices >= sliceTotal) DesiredSlice = sliceTotal;',
 'C': 'int sliceTotal = Cars_gRaceCarList[j]->stats.sliceTotal;\n DesiredSlice = trackSlices < sliceTotal ? trackSlices : sliceTotal;',
 'D': 'int sliceTotal = Cars_gRaceCarList[j]->stats.sliceTotal;\n DesiredSlice = sliceTotal; if (trackSlices < sliceTotal) DesiredSlice = trackSlices;',
 'E': 'int sliceTotal = Cars_gRaceCarList[j]->stats.sliceTotal;\n DesiredSlice = trackSlices; if (trackSlices >= sliceTotal) DesiredSlice = sliceTotal;',
 'F': 'DesiredSlice = trackSlices;\n if (trackSlices >= Cars_gRaceCarList[j]->stats.sliceTotal) DesiredSlice = Cars_gRaceCarList[j]->stats.sliceTotal;',
}
CC = 'C:/Temp/psq43/COMPILER/CC1PLPSX.EXE'
G = '4'
skip = re.compile(r'\s*\.(set|loc)|\s*#|\s*$'); lab = re.compile(r'\$L\d+')
def fn(p):
    m = re.search(r'^Stats_TrackEndGame__Fv:.*?\.end\tStats_TrackEndGame__Fv', open(p).read(), re.S | re.M)
    return [lab.sub('$L', l) for l in m.group(0).splitlines() if not skip.match(l)]
subprocess.run([CC, '-quiet', '-O2', '-G' + G, '-mgas', '../../recon/game/common/stats.cpp.i', '-o', 'st_ref.s'], capture_output=True)
ref = fn('st_ref.s')
for k in sys.argv[1:] or V:
    open('stV.i', 'w', encoding='utf-8', newline='').write(s[:a] + V[k] + s[b:])
    r = subprocess.run([CC, '-quiet', '-O2', '-G' + G, '-mgas', 'stV.i', '-o', 'stV.s'], capture_output=True, text=True)
    if 'error' in r.stderr: print(k, 'ERROR', [l for l in r.stderr.splitlines() if 'error' in l][:2]); continue
    f = fn('stV.s'); d = [l for l in difflib.unified_diff(ref, f, n=0, lineterm='') if l[:1] in '+-' and l[:3] not in ('+++', '---')]
    print(f'{k}: insns {len(f)} vs {len(ref)} difflines {len(d)}   ' + ' | '.join(d[:6]))
