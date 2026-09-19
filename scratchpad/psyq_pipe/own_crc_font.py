"""Blob ownership step 2 (2026-09-19): eacpsxz crc.c defines its two 256-byte CRC tables (retail .data
0x80135C58..0x80135E58) and libgpu FONT.c defines its object data (retail .data 0x80135E58..0x801369E8:
the eight zero-initialized font streams, stream count, active id, the 2564-byte debug-font image block and
the pointer to the "0123456789ABCDEF" literal, which also becomes the first item of FONT's .rodata)."""
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


crc, _ = initializer(0x80135C58, 512, 'u8')
edit('recon/eaclib/psx/eacpsxz/crc.c', [
    ('extern const unsigned char D_80135C58[512];   /* @0x80135C58 : CRC-16 tables A[0..255] + B[256..511] (blob-owned: asm/data/data_8010CCD4_r17.data.s) */',
     '/* @0x80135C58 : CRC-16 tables A[0..255] + B[256..511].  Retail keeps them in .data (not const); owned here\n'
     ' * since 2026-09-19 (was the retail dump data_8010CCD4_r17). */\n'
     'unsigned char D_80135C58[512] = ' + crc + ';'),
])

img, nwords = initializer(0x80135FE0, 0x801369E4 - 0x80135FE0, 'u32')
edit('recon/syslib/psx/libgpu/FONT.c', [
    ('extern struct Font _fnt[8] __asm__("Font"); /* @0x80135E58 : open font streams */\n'
     'extern int _fnt_count __asm__("D_80135FD8");          /* @0x80135FD8 : number of open streams */\n'
     'extern int _fnt_active __asm__("D_80135FDC");         /* @0x80135FDC : current active stream id */\n'
     'extern char *D_801369E4;        /* @0x801369E4 : "0123456789ABCDEF" */\n',
     '/* FONT.obj .data 0x80135E58..0x801369E8, owned here since 2026-09-19 (was the retail dump data_8010CCD4_r17).\n'
     ' * The streams and counters are zero but INITIALIZED in retail (in-file .data, not bss). */\n'
     'struct Font _fnt[8] __asm__("Font") = { { 0 } };  /* @0x80135E58 : open font streams */\n'
     'int _fnt_count __asm__("D_80135FD8") = 0;          /* @0x80135FD8 : number of open streams */\n'
     'int _fnt_active __asm__("D_80135FDC") = 0;         /* @0x80135FDC : current active stream id */\n'
     '/* SYM-GLOBAL-CARRIER: the debug-font image block FntLoad uploads (retail bytes; the original identifier is\n'
     ' * not retained -- FntLoad itself is not linked into this image). */\n'
     'u_long _fnt_image[' + str(nwords) + '] __asm__("D_80135FE0") = ' + img + ';\n'
     'char *D_801369E4 = "0123456789ABCDEF";   /* @0x801369E4 -> FONT.obj .rodata 0x80057060 */\n'),
])

p = R + 'linkers/nfs4_recon.data_extra.json'
rows = json.load(open(p))
rows = [r for r in rows if not (r['section'] == '.data' and (r['obj'].endswith('eacpsxz/crc.c.o') or r['obj'].endswith('libgpu/FONT.c.o')))]
rows.append({'obj': 'build/recon/eaclib/psx/eacpsxz/crc.c.o', 'section': '.data', 'base': 0x80135C58, 'end': 0x80135E58, 'size': 512, 'ok': True, 'unresolved': 0, 'words': 128, 'q': 0})
rows.append({'obj': 'build/recon/syslib/psx/libgpu/FONT.c.o', 'section': '.data', 'base': 0x80135E58, 'end': 0x801369E8, 'size': 0x801369E8 - 0x80135E58, 'ok': True, 'unresolved': 0, 'words': (0x801369E8 - 0x80135E58) // 4, 'q': 0})
json.dump(rows, open(p, 'w'), indent=1)
p = R + 'linkers/nfs4_recon.rodata_placement.json'
rows = json.load(open(p))
for r in rows:
    if r['obj'].endswith('libgpu/FONT.c.o'):
        r['base'] = 0x80057060
        r['size'] += 0x18
        r['end'] = r['base'] + r['size']
        print('rodata row', hex(r['base']), hex(r['size']))
json.dump(rows, open(p, 'w'), indent=1)
