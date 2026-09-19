"""Blob ownership step 7 (2026-09-19) -- owners from gprefs.py static cross-references:
  libetc VMODE.c  .data 0x80134838..0x8013485C  the 9-word block whose word 0 is the video mode (SetVideoMode /
                                                GetVideoMode are its only users)
  libgte MSC02.c  .data 0x8013485C..0x801349E8  the 192-entry reciprocal-sqrt table _VectorNormalSS_kernel indexes
                                                + three zero words"""
import json
import sys

sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/psyq_pipe')
from gen_cdata import initializer  # noqa: E402

R = 'C:/Temp/nfs4-decomp/'


def edit(f, pairs):
    s = open(R + f, encoding='utf-8').read()
    for a, b in pairs:
        assert s.count(a) == 1, (f, a[:70], s.count(a))
        s = s.replace(a, b)
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


def row(rows, obj, base, size):
    rows[:] = [r for r in rows if not (r['obj'] == obj and r['section'] == '.data')]
    rows.append({'obj': obj, 'section': '.data', 'base': base, 'end': base + size, 'size': size, 'ok': True,
                 'unresolved': 0, 'words': size // 4, 'q': 0})


edit('recon/syslib/psx/libetc/VMODE.c', [
    ('extern int g_videomode __asm__("D_80134838");  /* @0x80134838 (offset 0 of a 9-word block) */\n',
     '/* VMODE.obj .data 0x80134838..0x8013485C, owned here since 2026-09-19 (gprefs.py: SetVideoMode/GetVideoMode are\n'
     ' * the only retail code addressing it): word 0 is the mode, the other eight words are zero in the image. */\n'
     'int g_videomode __asm__("D_80134838") = 0;\n'
     '/* SYM-GLOBAL-CARRIER: the remaining eight words of the block (retail bytes; names not retained) */\n'
     'int vmode_reserved[8] __asm__("D_8013483C") = { 0 };\n'),
])

tbl, n = initializer(0x8013485C, 0x801349DC - 0x8013485C, 'u16')
s = open(R + 'recon/syslib/psx/libgte/MSC02.c', encoding='utf-8').read()
assert 'short D_8013485C[' not in s
s = s.rstrip('\n') + ('\n\n/* MSC02.obj .data 0x8013485C..0x801349E8, owned here since 2026-09-19 (gprefs.py: _VectorNormalSS_kernel is the only\n'
                      ' * retail user): the %d-entry reciprocal-sqrt table the kernel indexes as `lh scale, tbl[idx]`.  Defined AFTER the\n'
                      ' * handwritten blocks so they stay in .text. */\n'
                      'unsigned short D_8013485C[%d] = ' % (n, n) + tbl + ';\n'
                      '/* SYM-GLOBAL-CARRIER: three zero words close MSC02.obj .data (retail bytes; names not retained) */\n'
                      'int D_801349DC[3] = { 0, 0, 0 };\n')
open(R + 'recon/syslib/psx/libgte/MSC02.c', 'w', encoding='utf-8', newline='').write(s)
print('ok MSC02.c', n, 'entries')

p = R + 'linkers/nfs4_recon.data_extra.json'
rows = json.load(open(p))
row(rows, 'build/recon/syslib/psx/libetc/VMODE.c.o', 0x80134838, 0x24)
row(rows, 'build/recon/syslib/psx/libgte/MSC02.c.o', 0x8013485C, 0x801349E8 - 0x8013485C)
json.dump(rows, open(p, 'w'), indent=1)
