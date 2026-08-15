import re, json, sys
from pathlib import Path
ROOT = Path(r'C:\Temp\nfs4-decomp')
txt = (ROOT / 'build/recon/game/common/camera.cpp.s').read_text(errors='replace')
name = 'Camera_UpdateHeliCam__Fii'
m = re.search(r"^\t\.ent\t%s\b[^\n]*\n" % re.escape(name), txt, re.M)
m2 = re.search(r"^\t\.end\t%s[ \t]*$" % re.escape(name), txt[m.end():], re.M)
region = txt[m.start():m.end() + m2.start()]
print('region lines', region.count('\n'))
spec = json.load(open(sys.argv[1]))
moves = spec['recon/game/common/camera.cpp'][name]
for i, mv in enumerate(moves):
    tk = re.search(mv['take'], region)
    print(f"-- move {i}: take {'HIT' if tk else 'MISS'}", repr(tk.group(0)) if tk else '')
    if not tk:
        continue
    line = tk.group(0)
    region2 = region[:tk.start()] + region[tk.end():]
    an = re.search(mv['after'], region2)
    print(f"   after {'HIT' if an else 'MISS'}", repr(an.group(0)) if an else '')
    if not an:
        continue
    ins = an.end()
    print('   next 3 lines after anchor:', repr(region2[ins:ins+120]))
    if mv.get('drop_after'):
        da = re.match(mv['drop_after'], region2[ins:])
        print('   drop_after', 'HIT' if da else 'MISS')
        if da:
            region2 = region2[:ins] + region2[ins+da.end():]
    region = region2[:ins] + line + region2[ins:]
