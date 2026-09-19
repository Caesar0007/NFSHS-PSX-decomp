"""Blob ownership step 4 (2026-09-19) -- owners confirmed by the runtime trace and by retail link order:
  libetc INTR_VB.c   .data 0x80137CF0..0x80137D20  vsync_cb[8], Vcount, RCnt pointer, two zero words
  libpad PADPORTD.c  .data 0x80136CD8..0x80136CE8  the SIO0 base pointer _pad_failall loads + three zero words
  libcd C_008/C_004/C_010 (stream group, right after DRV in link order)
                     .data 0x8013C260 / C270 / C280  each the 4 static CD register pointers C_003 already has
  libcd cdread.c     .data 0x8013C290..0x8013C2D0  _cdr environment (0x38) + two zero words
  libcd event.c      .data 0x8013C2D0..0x8013C2E0  CD_cbread, CD_read_dma_mode + two zero words"""
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


def row(rows, obj, base, size):
    rows[:] = [r for r in rows if not (r['obj'] == obj and r['section'] == '.data')]
    rows.append({'obj': obj, 'section': '.data', 'base': base, 'end': base + size, 'size': size, 'ok': True,
                 'unresolved': 0, 'words': size // 4, 'q': 0})


edit('recon/syslib/psx/libetc/INTR_VB.c', [
    ('extern int Vcount;            /* @0x80137D10 */\n'
     'extern Callback vsync_cb[8] __asm__("D_80137CF0");  /* @0x80137CF0 : 8 vblank callbacks (storage\n'
     '                                                     * owned by the splat blob -- W65-A6 note above) */\n'
     'extern volatile unsigned int *g_rcnt_ptr __asm__("D_80137D14");   /* @0x80137D14 : = 0x1F801114 (RCnt vblank-timing mode reg) */\n',
     '/* INTR_VB.obj .data 0x80137CF0..0x80137D20, owned here since 2026-09-19 (runtime trace: startIntrVSync\'s\n'
     ' * helpers and the vblank handler are the only code touching it; was the retail dump data_8010CCD4_r18). */\n'
     'Callback vsync_cb[8] __asm__("D_80137CF0") = { 0 };  /* @0x80137CF0 : 8 vblank callbacks */\n'
     'int Vcount = 0;               /* @0x80137D10 */\n'
     'volatile unsigned int *g_rcnt_ptr __asm__("D_80137D14") = (volatile unsigned int *)0x1F801114;   /* RCnt vblank-timing mode reg */\n'
     '/* SYM-GLOBAL-CARRIER: two zero words close INTR_VB.obj .data (retail bytes; names not retained) */\n'
     'int vb_reserved[2] __asm__("D_80137D18") = { 0, 0 };\n'),
])

edit('recon/syslib/psx/libpad/PADPORTD.c', [
    ('extern unsigned char     *D_80136CD8;                 /* private spelling not retained */\n',
     '/* PADPORTD.obj .data 0x80136CD8..0x80136CE8, owned here since 2026-09-19 (runtime trace: _pad_failall is the\n'
     ' * only reader; was the retail dump data_8010CCD4_r17). */\n'
     'unsigned char     *D_80136CD8 ' + D + ' = (unsigned char *)0x1F801040;   /* SIO0 block; private spelling not retained */\n'
     '/* SYM-GLOBAL-CARRIER: three zero words close PADPORTD.obj .data (retail bytes; names not retained) */\n'
     'int D_80136CDC[3] ' + D + ' = { 0, 0, 0 };\n'),
])

REGS = ('/* %s.obj .data @%s: the stream group\'s four static CD register pointers (same block C_003.obj carries at\n'
        ' * 0x80136C48; unreferenced here).  Owned since 2026-09-19 -- retail link order DRV, C_008, C_004, C_010. */\n'
        'static volatile unsigned char *_cd_reg0 ' + D + ' = (volatile unsigned char *)0x1F801800;\n'
        'static volatile unsigned char *_cd_reg1 ' + D + ' = (volatile unsigned char *)0x1F801801;\n'
        'static volatile unsigned char *_cd_reg2 ' + D + ' = (volatile unsigned char *)0x1F801802;\n'
        'static volatile unsigned char *_cd_reg3 ' + D + ' = (volatile unsigned char *)0x1F801803;\n')
for name, va in (('C_008', '0x8013C260'), ('C_004', '0x8013C270'), ('C_010', '0x8013C280')):
    edit('recon/syslib/psx/libcd/%s.c' % name, [
        ('#include "stream_internal.h"\n', '#include "stream_internal.h"\n\n' + REGS % (name, va)),
    ])

edit('recon/syslib/psx/libcd/cdread.c', [
    ('extern volatile CdrEnv _cdr;   /* @0x8013C290 -- zero-initialised .bss */\n',
     '/* cdread.obj .data 0x8013C290..0x8013C2D0, owned here since 2026-09-19: zero but INITIALIZED (in-file data). */\n'
     'volatile CdrEnv _cdr = { 0 };   /* @0x8013C290 */\n'
     '/* SYM-GLOBAL-CARRIER: two zero words close cdread.obj .data (retail bytes; names not retained) */\n'
     'int D_8013C2C8[2] = { 0, 0 };\n'),
])

edit('recon/syslib/psx/libcd/event.c', [
    ('extern int CD_cbread;             /* @0x8013C2D0 : user CdReadCallback  (blob-owned) */\n'
     'extern int CD_read_dma_mode;      /* @0x8013C2D4 : bit0 = DMA copy      (blob-owned) */\n',
     '/* event.obj .data 0x8013C2D0..0x8013C2E0, owned here since 2026-09-19 (runtime trace: CdInit). */\n'
     'int CD_cbread = 0;                /* @0x8013C2D0 : user CdReadCallback */\n'
     'int CD_read_dma_mode = 0;         /* @0x8013C2D4 : bit0 = DMA copy */\n'
     '/* SYM-GLOBAL-CARRIER: two zero words close event.obj .data (retail bytes; names not retained) */\n'
     'int D_8013C2D8[2] = { 0, 0 };\n'),
])

p = R + 'linkers/nfs4_recon.data_extra.json'
rows = json.load(open(p))
B = 'build/recon/syslib/psx/'
row(rows, B + 'libetc/INTR_VB.c.o', 0x80137CF0, 0x30)
row(rows, B + 'libpad/PADPORTD.c.o', 0x80136CD8, 0x10)
row(rows, B + 'libcd/C_008.c.o', 0x8013C260, 0x10)
row(rows, B + 'libcd/C_004.c.o', 0x8013C270, 0x10)
row(rows, B + 'libcd/C_010.c.o', 0x8013C280, 0x10)
row(rows, B + 'libcd/cdread.c.o', 0x8013C290, 0x40)
row(rows, B + 'libcd/event.c.o', 0x8013C2D0, 0x10)
json.dump(rows, open(p, 'w'), indent=1)
