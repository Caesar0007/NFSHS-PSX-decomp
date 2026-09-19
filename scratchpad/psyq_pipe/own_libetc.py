"""Blob ownership pilot (2026-09-19): libetc VSYNC.c and INTR.c DEFINE their initialized data instead of
referencing the retail dump through `extern ... __asm__("D_...")`.
  VSYNC .data 0x80134A88..0x80134AA0: gp1 pointer, timer-1 pointer, Hcount, last count, two zero words
  INTR  .data 0x80134AA0..0x80135B94: Sony library copyright string (88 B), intrEnv (0x1068 B, all zero but
        initialized -> .data), the Callbacks table, pCallbacks, the three hardware pointers, trapMissedCount
  INTR  .rodata now opens with the "$Id: intr.c,v 1.75 ..." string (the table's first initializer) at 0x80056F4C."""
import json
import re

R = 'C:/Temp/nfs4-decomp/'


def edit(f, pairs):
    s = open(R + f, encoding='utf-8').read()
    for a, b in pairs:
        assert s.count(a) == 1, (f, a[:70], s.count(a))
        s = s.replace(a, b)
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


edit('recon/syslib/psx/libetc/VSYNC.c', [
    ('extern volatile unsigned int *g_vsync_gp1_ptr __asm__("D_80134A88"); /* @0x80134A88 : = 0x1F801814 */\n'
     'extern volatile unsigned int *g_vsync_t1_ptr __asm__("D_80134A8C");  /* @0x80134A8C : = 0x1F801110 */\n'
     'extern volatile int Hcount;',
     '/* VSYNC.obj .data @0x80134A88 (owned here since 2026-09-19; was the retail dump data_8010CCD4_r17). */\n'
     'volatile unsigned int *g_vsync_gp1_ptr __asm__("D_80134A88") = (volatile unsigned int *)0x1F801814; /* GPU status */\n'
     'volatile unsigned int *g_vsync_t1_ptr __asm__("D_80134A8C") = (volatile unsigned int *)0x1F801110;  /* root counter 1 */\n'
     'volatile int Hcount = 0;'),
    ('extern int vsync_lastcount __asm__("D_80134A94");       /* @0x80134A94 : Vcount at the previous VSync */\n',
     'int vsync_lastcount __asm__("D_80134A94") = 0;          /* @0x80134A94 : Vcount at the previous VSync */\n'
     '/* SYM-GLOBAL-CARRIER: two zero words 0x80134A98/9C close VSYNC.obj .data (retail bytes; names not retained) */\n'
     'int vsync_reserved[2] __asm__("D_80134A98") = { 0, 0 };\n'),
])

edit('recon/syslib/psx/libetc/INTR.c', [
    ('extern intrEnv_t intrEnv __asm__("D_80134AF8"); /* @0x80134AF8 -- storage owned by the\n'
     '                                                  * splat data blob; see W65-A6 at EOF */\n'
     'extern intrEnv_t *startIntr(void) __asm__("_initIntr");\n',
     'extern intrEnv_t *startIntr(void) __asm__("_initIntr");\n'
     'extern intrEnv_t *stopIntr(void) __asm__("StopCallback");\n'
     'extern intrEnv_t *restartIntr(void) __asm__("RestartCallback");\n'
     '\n'
     '/* INTR.obj .data @0x80134AA0 (owned here since 2026-09-19; was the retail dump data_8010CCD4_r17):\n'
     ' * the library copyright string, then the interrupt environment -- all zero but INITIALIZED, so it is\n'
     ' * in-file .data (0x80134AF8..0x80135B60), not bss. */\n'
     'char intr_copyright[] __asm__("D_80134AA0") =\n'
     '    "Library Programs (c) 1993-1997 Sony Computer Entertainment Inc., All Rights Reserved.";\n'
     'intrEnv_t intrEnv __asm__("D_80134AF8") = { 0 };\n'),
    ('extern Callbacks callbacks __asm__("D_80135B60");\n'
     'extern Callbacks *pCallbacks __asm__("D_80135B80");\n'
     'extern volatile unsigned short *i_stat __asm__("D_80135B84");\n'
     'extern volatile unsigned short *g_InterruptMask __asm__("D_80135B88");\n'
     'extern volatile unsigned int *d_pcr __asm__("D_80135B8C");\n'
     'extern int trapMissedCount __asm__("D_80135B90");\n',
     '/* retail table bytes: {rcsid, 0, _set_intr_callback, _initIntr, StopCallback, 0, RestartCallback, &intrEnv} */\n'
     'Callbacks callbacks __asm__("D_80135B60") = {\n'
     '    "$Id: intr.c,v 1.75 1997/02/07 09:00:36 makoto Exp $",\n'
     '    0, setIntr, startIntr, stopIntr, 0, restartIntr, &intrEnv\n'
     '};\n'
     'Callbacks *pCallbacks __asm__("D_80135B80") = &callbacks;\n'
     'volatile unsigned short *i_stat __asm__("D_80135B84") = (volatile unsigned short *)0x1F801070;\n'
     'volatile unsigned short *g_InterruptMask __asm__("D_80135B88") = (volatile unsigned short *)0x1F801074;\n'
     'volatile unsigned int *d_pcr __asm__("D_80135B8C") = (volatile unsigned int *)0x1F8010F0;\n'
     'int trapMissedCount __asm__("D_80135B90") = 0;\n'),
])

p = R + 'linkers/nfs4_recon.data_extra.json'
rows = json.load(open(p))
rows = [r for r in rows if not (r['section'] == '.data' and re.search(r'libetc/(VSYNC|INTR)\.c\.o$', r['obj']))]
rows.append({'obj': 'build/recon/syslib/psx/libetc/VSYNC.c.o', 'section': '.data', 'base': 0x80134A88, 'end': 0x80134AA0, 'size': 24, 'ok': True, 'unresolved': 0, 'words': 6, 'q': 0})
rows.append({'obj': 'build/recon/syslib/psx/libetc/INTR.c.o', 'section': '.data', 'base': 0x80134AA0, 'end': 0x80135B94, 'size': 0x10F4, 'ok': True, 'unresolved': 0, 'words': 0x10F4 // 4, 'q': 0})
json.dump(rows, open(p, 'w'), indent=1)
p = R + 'linkers/nfs4_recon.rodata_placement.json'
rows = json.load(open(p))
for r in rows:
    if r['obj'].endswith('libetc/INTR.c.o'):
        r['base'] = 0x80056F4C
        r['size'] = 0x34 + 0x35
        r['end'] = r['base'] + r['size']
        print('rodata row', r)
json.dump(rows, open(p, 'w'), indent=1)
