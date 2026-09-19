"""Blob ownership step 9 (2026-09-19):
  game/psx trackspec.cpp  .data 0x8012327C..0x80123384  CTrackSpec TrackSpec_gSpec (0x108 bytes; an uninitialized
        C++ public = .data space at the end of the file).  Retail link order textureprocess, trackspec, trsproj, weather
        matches the data address; hrzsku's "0x801232A4 table" is just the member at +40.
  sndpsxz ssysinit.c      .data 0x80134A68  the output-caps init-once flag SNDSYS_getopts tests (was defined in snddata.c,
        the wrong object, and only bound to the address by a linker-script assignment)
  sndpsxz ssysreal.c      .data 0x80134A6C  the "task installed" flag SNDSYS_vectortoreal tests
        (retail link order ssysinit, ssysreal, MSC00 = data order A68, A6C, A70)"""
import json

R = 'C:/Temp/nfs4-decomp/'
D = '__attribute__((section(".data")))'


def edit(f, pairs):
    s = open(R + f, encoding='utf-8').read()
    for a, b in pairs:
        assert s.count(a) == 1, (f, a[:70], s.count(a))
        s = s.replace(a, b)
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


def append(f, text):
    s = open(R + f, encoding='utf-8').read()
    open(R + f, 'w', encoding='utf-8', newline='').write(s.rstrip('\n') + '\n\n' + text)
    print('ok', f)


def row(rows, obj, base, size):
    rows[:] = [r for r in rows if not (r['obj'] == obj and r['section'] == '.data')]
    rows.append({'obj': obj, 'section': '.data', 'base': base, 'end': base + size, 'size': size, 'ok': True,
                 'unresolved': 0, 'words': size // 4, 'q': 0})


edit('recon/game/psx/trackspec.cpp', [
    ('int TrackSpec_gCurrentSpec;\n',
     '/* trackspec.obj .data 0x8012327C..0x80123384, owned here since 2026-09-19 (was the retail dump data_8010CCD4_r16) */\n'
     'CTrackSpec TrackSpec_gSpec;\n'
     'int TrackSpec_gCurrentSpec;\n'),
])
edit('recon/eaclib/psx/sndpsxz/snddata.c', [
    ('extern int  DAT_80134a68 = 0;   /* @0x80134A68 : output-caps init-once flag (ssysinit)          */\n',
     '/* (2026-09-19) the output-caps init-once flag @0x80134A68 is ssysinit.obj data and is defined there */\n'),
])
append('recon/eaclib/psx/sndpsxz/ssysinit.c',
       '/* ssysinit.obj .data 0x80134A68, owned here since 2026-09-19 (gprefs.py: SNDSYS_getopts is the only user; retail\n'
       ' * link order ssysinit, ssysreal, MSC00 = data order 0x80134A68, A6C, A70).  Defined after its use so the unsized\n'
       ' * extern keeps the retail absolute addressing. */\n'
       'int DAT_80134a68[1] ' + D + ' = { 0 };\n')
edit('recon/eaclib/psx/sndpsxz/ssysreal.c', [
    ('extern int  D_80134A6C[2];     /* @0x80134A6C : element 0 is the "task installed" flag */',
     'extern int  D_80134A6C[];      /* @0x80134A6C : element 0 is the "task installed" flag (defined at the end of this file) */'),
])
append('recon/eaclib/psx/sndpsxz/ssysreal.c',
       '/* ssysreal.obj .data 0x80134A6C, owned here since 2026-09-19 (gprefs.py: SNDSYS_vectortoreal is the only user). */\n'
       'int D_80134A6C[1] ' + D + ' = { 0 };\n')

p = R + 'linkers/nfs4_recon.data_extra.json'
rows = json.load(open(p))
row(rows, 'build/recon/game/psx/trackspec.cpp.o', 0x8012327C, 0x108)
row(rows, 'build/recon/eaclib/psx/sndpsxz/ssysinit.c.o', 0x80134A68, 4)
row(rows, 'build/recon/eaclib/psx/sndpsxz/ssysreal.c.o', 0x80134A6C, 4)
json.dump(rows, open(p, 'w'), indent=1)
