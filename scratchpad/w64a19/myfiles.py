import json
import pathlib

ROOT = pathlib.Path('.')
mine = set()
for n in ('apply_result.json', 'apply_result2.json', 'apply_result3.json',
          'apply_result4.json', 'apply_result5.json'):
    p = pathlib.Path('scratchpad/w64a19') / n
    if p.exists():
        for row in json.loads(p.read_text())['fixed']:
            mine.add(row[2])
mine |= {
    'recon/game/common/cars.cpp',
    'recon/game/common/aispeeds.cpp',
    'recon/game/common/audiocmn.cpp',
    'recon/game/common/vtables_tmenu.cpp',
    'recon/frontend/common/screentrackinfo_externs.h',
    'recon/frontend/common/screenpinkslips_externs.h',
    'recon/game/common/mpause_externs.h',
}
mine = sorted(mine)
json.dump(mine, open('scratchpad/w64a19/myfiles.json', 'w'), indent=1)
print(len(mine), 'files edited by w64-a19')
for m in mine:
    print(' ', m)
