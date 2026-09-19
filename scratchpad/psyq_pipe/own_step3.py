"""Blob ownership step 3 (2026-09-19), owners CONFIRMED by the runtime trace (tools/duckstation/blob_trace.py):
  libetc INTR_DMA.c  .data 0x8013BD20..0x8013BD50  (zeroed by _bzero_w from startIntrDMA)
  eacpsxz textcode.c .data 0x8013BD50..0x8013BE10  (ASCII 0x20..0x7f -> full-width Shift-JIS, 96 x u16)"""
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


def row(rows, obj, sec, base, size):
    rows[:] = [r for r in rows if not (r['obj'] == obj and r['section'] == sec)]
    rows.append({'obj': obj, 'section': sec, 'base': base, 'end': base + size, 'size': size, 'ok': True,
                 'unresolved': 0, 'words': size // 4, 'q': 0})


edit('recon/syslib/psx/libetc/INTR_DMA.c', [
    ('extern volatile unsigned int *g_dicr_ptr __asm__("D_8013BD20");   /* @0x8013BD20 : = 0x1F8010F4 */\n',
     '/* INTR_DMA.obj .data 0x8013BD20..0x8013BD50, owned here since 2026-09-19 (runtime trace: startIntrDMA\'s\n'
     ' * _bzero_w clears it; was the retail dump data_8010CCD4_r18). */\n'
     'volatile unsigned int *g_dicr_ptr __asm__("D_8013BD20") = (volatile unsigned int *)0x1F8010F4;   /* DICR */\n'),
    ('extern Callback dma_cb[8] __asm__("D_8013BD24");  /* @0x8013BD24 : per-channel DMA callbacks */\n'
     'extern volatile unsigned int *g_madr_ptr __asm__("D_8013BD44");   /* @0x8013BD44 : = 0x1F801080 */\n',
     'Callback dma_cb[8] __asm__("D_8013BD24") = { 0 };  /* @0x8013BD24 : per-channel DMA callbacks */\n'
     'volatile unsigned int *g_madr_ptr __asm__("D_8013BD44") = (volatile unsigned int *)0x1F801080;   /* MADR base */\n'
     '/* SYM-GLOBAL-CARRIER: two zero words close INTR_DMA.obj .data (retail bytes; names not retained) */\n'
     'int dma_reserved[2] __asm__("D_8013BD48") = { 0, 0 };\n'),
])

sjis, _ = initializer(0x8013BD50, 0xC0, 'u16')
edit('recon/eaclib/psx/eacpsxz/textcode.c', [
    ('extern unsigned short D_8013BD50[];     /* ASCII(0x20..0x7f) -> full-width SJIS */',
     '/* ASCII(0x20..0x7f) -> full-width SJIS; textcode.obj .data 0x8013BD50..0x8013BE10, owned here since 2026-09-19 */\n'
     'unsigned short D_8013BD50[96] = ' + sjis + ';'),
])

p = R + 'linkers/nfs4_recon.data_extra.json'
rows = json.load(open(p))
row(rows, 'build/recon/syslib/psx/libetc/INTR_DMA.c.o', '.data', 0x8013BD20, 0x30)
row(rows, 'build/recon/eaclib/psx/eacpsxz/textcode.c.o', '.data', 0x8013BD50, 0xC0)
json.dump(rows, open(p, 'w'), indent=1)
