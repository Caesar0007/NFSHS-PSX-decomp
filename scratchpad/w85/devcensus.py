import re,sys,pathlib
FILES="""recon/game/common/newton.cpp recon/game/common/newton.h recon/game/common/physics.cpp
recon/game/common/collide.cpp recon/game/common/camera.cpp recon/game/common/input.cpp
recon/game/common/cars.cpp recon/game/common/bworld.cpp recon/game/common/chunk.cpp
recon/game/common/r3dcar.cpp recon/game/common/replay.cpp recon/game/common/pausemenu.cpp
recon/game/common/sim.cpp recon/game/psx/cario.cpp recon/game/psx/sfx.cpp
recon/game/psx/overlays.cpp recon/game/psx/psxcontroller.cpp recon/game/psx/textureprocess.cpp""".split()
pat=re.compile(r'volatile|__asm__|\basm\b|register\s+\w[\w \*]*asm\s*\(|&&[A-Za-z_]')
for f in FILES:
    p=pathlib.Path(f); src=p.read_text(errors='replace'); lines=src.split('\n')
    # mask comments
    masked=re.sub(r'/\*.*?\*/', lambda m:re.sub(r'[^\n]','.',m.group(0)), src, flags=re.S)
    masked=re.sub(r'//[^\n]*', lambda m:'.'*len(m.group(0)), masked)
    ml=masked.split('\n')
    hits=[(i+1,lines[i].strip()) for i in range(len(ml)) if pat.search(ml[i])]
    print(f"=== {f}  ({len(hits)} code devices)")
    for n,t in hits: print(f"  {n:5}: {t[:170]}")
