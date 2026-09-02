#!/usr/bin/env python3
"""data_seal.py -- seal the 36 workable regional DATA rows (post item-10 wiring).
Seeds missing candidates (never overwrites), applies the audited per-symbol
initializer edits, gates each with verify_data, and regression-gates the
unit's SEALED code rows in that region."""
import io, re, shutil, subprocess, sys
from pathlib import Path

ROOT = Path(r'C:/Temp/nfs4-decomp')
RD = ROOT / 'regiondiff'
PAL = ['NFS4-R-AU', 'NFS4-R-FR-DE', 'NFS4-R-UK-ES-IT', 'NFS4-R-UK-SW']
ALL = PAL + ['NFS4-R-JPN', 'NFS4-R-USA']

def seed(region, unit):
    dst = RD / 'recon' / region / unit
    if not dst.exists():
        dst.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(ROOT / 'recon' / unit, dst)
        return 'seeded'
    return 'exists'

def edit(path, old, new, must=True):
    s = io.open(path, encoding='latin-1').read()
    if old not in s:
        if must:
            raise SystemExit(f'EDIT ANCHOR MISSING in {path}: {old[:60]}')
        return False
    if s.count(old) != 1 and must:
        raise SystemExit(f'EDIT ANCHOR AMBIGUOUS in {path}: {old[:60]}')
    io.open(path, 'w', encoding='latin-1', newline='').write(s.replace(old, new, 1))
    return True

def gate(region, unit, syms):
    r = subprocess.run([sys.executable, str(RD/'tools'/'verify_data.py'),
                        region, f'regiondiff/recon/{region}/{unit}', syms,
                        f'--lane-as=recon/{unit}'],
                       capture_output=True, text=True, cwd=ROOT)
    return r.stdout + r.stderr

def code_regress(region, unit):
    """re-gate this unit's SEALED code rows in this region."""
    fns = []
    for ln in (RD / 'REGION_PROGRESS.txt').read_text().splitlines():
        m = re.match(r'^SEALED\s+\d+\s+(\S+)\s+(\S+)\s+(\S+)$', ln)
        if m and m.group(1) == region.replace('NFS4-R-','') and \
           unit.startswith(m.group(2)):
            fns.append(m.group(3))
    if not fns:
        return 'no sealed code rows'
    r = subprocess.run([sys.executable, str(RD/'tools'/'verify_region.py'),
                        region, f'regiondiff/recon/{region}/{unit}',
                        ','.join(fns), f'--lane-as=recon/{unit}'],
                       capture_output=True, text=True, cwd=ROOT)
    out = r.stdout + r.stderr
    bad = [l for l in out.splitlines() if 'FAIL' in l or 'NOT IN' in l]
    return 'CODE OK (%d fns)' % len(fns) if not bad else 'CODE REGRESSION!\n' + '\n'.join(bad)

REPORT = []
def do(region, unit, syms, edits):
    st = seed(region, unit)
    p = RD / 'recon' / region / unit
    for old, new in edits:
        edit(p, old, new)
    g = gate(region, unit, syms)
    REPORT.append(f'[{region}] {unit} ({st})\n{g.rstrip()}\n  {code_regress(region, unit)}')

# ---- 1. SelectLists (femenudefs) : 5 remaining regions, same +1 shift ----
SL_EDITS = [
    ("SelectListOffOn[3] = { 103, 102, 0 };",
     "SelectListOffOn[3] = { 104, 103, 0 };"),
    ("SelectListTrackDirection[3] = { 228, 229, 0 };",
     "SelectListTrackDirection[3] = { 229, 230, 0 };"),
]
for R in PAL + ['NFS4-R-JPN']:
    do(R, 'frontend/common/femenudefs.cpp',
       'SelectListOffOn,SelectListTrackDirection', SL_EDITS)

# ---- 2. Camera_gFlags element 15: shorts[0..1] -> 0,1 (all 6 regions) ----
CAM = [("{0, 18, 18, 18, 18, 18, 18}, {0, 24, 24, 24, 24, 24, 24}",
        "{0, 0, 1, 18, 18, 18, 18}, {0, 24, 24, 24, 24, 24, 24}")]
for R in ALL:
    do(R, 'game/common/camera.cpp', 'Camera_gFlags', CAM)

# ---- 3. R3DCar_ObjectInfo row 37: 40 -> 38 (all 6 regions) ----
R3D = [("40, 2, 3, 0, 0, 3, 40, 2, 3, 0, 0, 3, 38, 2, 4",
        "40, 2, 3, 0, 0, 3, 38, 2, 3, 0, 0, 3, 38, 2, 4")]
for R in ALL:
    do(R, 'game/common/r3dcar.cpp', 'R3DCar_ObjectInfo', R3D)

# ---- 4. Hud_gElementPositions (PAL only): page0 y+16, page1 y+8 on 4,13,14,15 ----
HUD = [("{8, 204}", "{8, 220}"), ("{90, 212}", "{90, 228}"),
       ("{253, 162}", "{253, 178}"), ("{8, 196}", "{8, 212}"),
       ("{8, 101}", "{8, 109}"), ("{90, 105}", "{90, 113}"),
       ("{259, 60}", "{259, 68}"), ("{8, 72}", "{8, 80}")]
for R in PAL:
    do(R, 'game/psx/hud.cpp', 'Hud_gElementPositions', HUD)

# ---- 5. gLargestUnused (tri-language PAL): delta lies BEYOND the [1] symbol;
#         seed + gate only (expected PASS at the 4-byte extent) ----
for R in ['NFS4-R-FR-DE', 'NFS4-R-UK-ES-IT', 'NFS4-R-UK-SW']:
    do(R, 'frontend/common/feapp.cpp', 'gLargestUnused', [])

# ---- 6. TextLocations (screencontroller): +1 on every row's col2 (all 6) ----
def textloc_edit(path):
    s = io.open(path, encoding='latin-1').read()
    m = re.search(r'(short\s+TextLocations\[80\]\[5\] = \{ )(.*?)( \};)', s, re.S)
    assert m, 'TextLocations initializer not found'
    nums = [int(x) for x in m.group(2).replace('\n', ' ').split(',')]
    assert len(nums) == 400
    nums = [v + 1 if i % 5 == 2 else v for i, v in enumerate(nums)]
    body = ', '.join(str(v) for v in nums)
    io.open(path, 'w', encoding='latin-1', newline='').write(
        s[:m.start()] + m.group(1) + body + m.group(3) + s[m.end():])
for R in ALL:
    st = seed(R, 'frontend/common/screencontroller.cpp')
    p = RD / 'recon' / R / 'frontend/common/screencontroller.cpp'
    textloc_edit(p)
    g = gate(R, 'frontend/common/screencontroller.cpp', 'TextLocations')
    REPORT.append(f'[{R}] screencontroller ({st})\n{g.rstrip()}\n'
                  f'  {code_regress(R, "frontend/common/screencontroller.cpp")}')

# ---- 7. GameSetup_gPersonalityNames (JPN): uppercase all 15 names ----
PN = [('"Nemesis", "Bullit", "Frost", "Ranger", "Chump",\n    "Snake", "Razor", "Thunder", "Roadhog", "Clutch",\n    "Scooter", "WndrBoy", "Flash", "KikBut", "Laser"',
       '"NEMESIS", "BULLIT", "FROST", "RANGER", "CHUMP",\n    "SNAKE", "RAZOR", "THUNDER", "ROADHOG", "CLUTCH",\n    "SCOOTER", "WNDRBOY", "FLASH", "KIKBUT", "LASER"')]
do('NFS4-R-JPN', 'game/common/gmesetup.cpp', 'GameSetup_gPersonalityNames', PN)

print('\n\n'.join(REPORT))
