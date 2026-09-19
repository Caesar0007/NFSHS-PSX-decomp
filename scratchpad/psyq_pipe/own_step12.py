"""Blob ownership step 12 (2026-09-19) -- aiinit.cpp emits its own read-only data (runtime trace: sprintf reads the
format at 0x8005522C on behalf of AIInit_LoadConfigs):
  aiinit.obj .rodata 0x80055210..0x80055304 = "SimpleMem", "%sTr%02d.trf", "%strafcfg.dat", then the 50-int initializer of
  AIInit_IsNonStandardCarFile's local list (28 ones, 22 zeros) -- all were dump labels (D_8005521C / 2C / 3C)."""
import json

R = 'C:/Temp/nfs4-decomp/'


def edit(f, pairs):
    s = open(R + f, encoding='utf-8').read()
    for a, b in pairs:
        assert s.count(a) == 1, (f, a[:70], s.count(a))
        s = s.replace(a, b)
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


ones = ', '.join(['1'] * 28)
edit('recon/game/common/aiinit.cpp', [
    ('extern int D_8005523C[];   /* nonstandard-car table @0x8005523C (shared rodata) */\n', ''),
    ('extern char  D_8005521C[];   /* "%sTr%02d.trf" format @0x8005521C */\n', ''),
    ('  char filename[100];\n\n  if (GameSetup_gData.trafficDensity != 0) {\n',
     '  char filename[100];\n\n'
     '  /* retail aiinit.obj .rodata opens with the unreferenced "SimpleMem" tag (0x80055210), ahead of this function\'s format */\n'
     '  if (0) sprintf((char *)0,"SimpleMem");\n'
     '  if (GameSetup_gData.trafficDensity != 0) {\n'),
    ('    sprintf(filename,D_8005521C,D_801164B0[0],GameSetup_gData.track);\n',
     '    sprintf(filename,"%sTr%02d.trf",D_801164B0[0],GameSetup_gData.track);   /* literal @0x8005521C */\n'),
    ('extern char  D_8005522C[];   /* sprintf format string @0x8005522C (shared rodata) */\n', ''),
    ('  sprintf(pathname,D_8005522C,D_80116470[0]);\n',
     '  sprintf(pathname,"%strafcfg.dat",D_80116470[0]);   /* literal @0x8005522C */\n'),
    ('  int nonStandardList [50];\n\n  __builtin_memcpy(nonStandardList,D_8005523C,sizeof nonStandardList);\n',
     '  /* local aggregate initializer: its 200-byte constant is retail .rodata 0x8005523C (28 ones, then zeros) */\n'
     '  int nonStandardList [50] = { ' + ones + ' };\n\n'),
])

p = R + 'linkers/nfs4_recon.rodata_placement.json'
rows = json.load(open(p))
rows = [r for r in rows if not r['obj'].endswith('game/common/aiinit.cpp.o')]
rows.append({'obj': 'build/recon/game/common/aiinit.cpp.o', 'base': 0x80055210, 'end': 0x80055304, 'size': 0xF4,
             'ok': False, 'regions': []})
json.dump(rows, open(p, 'w'), indent=1)
