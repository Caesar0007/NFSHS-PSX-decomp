"""Blob ownership step 17 (2026-09-19) -- the Sony LIBRARY-INFORMATION STAMPS.
The first data object of a Sony library opens its .data with 8 bytes `50 73 <lib id> 25 9B 5x 43 00` ("Ps", id, version);
PsyQ 4.3's own objects carry them byte-exact (scratchpad/psyq_pipe/sdk_data_match.py, ps_stamps.py):
  libgpu  SYS.obj      0x8012364C  50 73 07 25 9B 53 43 00
  libetc  VSYNC.obj    0x80134A80  50 73 06 25 9B 52 43 00
  libmcrd LIBMCRD.obj  0x80136CB0  50 73 18 25 9B 53 43 00   (+ 8 zero bytes closing its 32-byte .data, 0x80136CC8)
  libpad  PADMAIN.obj  0x80137C70  50 73 0C 25 9B 53 43 00   (+ 12 zero bytes closing its 128-byte .data, 0x80137CE4)
  libmath FERR.obj     0x8013BF10  50 73 0B 25 9B 53 43 00
(libcard INIT.obj's was step 16.  libc / libgte / libapi keep theirs in .text: the three 8-byte 'sn_lnk' pieces.)
Non-const statics are always output by gcc 2.x, referenced or not, in definition order -- so the stamp is simply the
first data definition of the file."""
import json

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
SEC = ' __attribute__((section(".data")))'


def stamp(lib, ver):
    return ('/* Sony library-information stamp: the first 8 bytes of this object\'s .data (byte-exact in PsyQ 4.3). */' + NL +
            'static unsigned char _lib_stamp[8]' + SEC + ' = { 0x50, 0x73, 0x%02X, 0x25, 0x9B, 0x%02X, 0x43, 0x00 };' % (lib, ver) + NL)


def edit(f, pairs):
    s = open(R + f, encoding='utf-8').read()
    for a, b in pairs:
        assert s.count(a) == 1, (f, a[:70], s.count(a))
        s = s.replace(a, b)
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


def row(rows, obj, base, end):
    old = [r for r in rows if r['obj'] == obj and r['section'] == '.data']
    assert len(old) == 1, obj
    old[0].update({'base': base, 'end': end, 'size': end - base, 'words': (end - base) // 4})


edit('recon/syslib/psx/libgpu/SYS.c', [
    ('static GpuTbl _gpu_tbl SYS_DATA = {', stamp(0x07, 0x53) + 'static GpuTbl _gpu_tbl SYS_DATA = {'),
])
edit('recon/syslib/psx/libetc/VSYNC.c', [
    ('volatile unsigned int *g_vsync_gp1_ptr __asm__("D_80134A88")',
     stamp(0x06, 0x52) + 'volatile unsigned int *g_vsync_gp1_ptr __asm__("D_80134A88")'),
])
edit('recon/syslib/psx/libmcrd/LIBMCRD.c', [
    ('static int   _mc_rd_retry __attribute__((section(".data"))) = 0;', stamp(0x18, 0x53) +
     'static int   _mc_rd_retry __attribute__((section(".data"))) = 0;'),
    ('static int   _mc_wf_retry __attribute__((section(".data"))) = 0;  /* @0x80136CC4 : MemCardWriteFile retry counter */' + NL,
     'static int   _mc_wf_retry __attribute__((section(".data"))) = 0;  /* @0x80136CC4 : MemCardWriteFile retry counter */' + NL +
     'static int   _mc_reserved[2] __attribute__((section(".data"))) = { 0, 0 };  /* @0x80136CC8 : closes the 32-byte .data of LIBMCRD.obj */' + NL),
])
edit('recon/syslib/psx/libpad/PADMAIN.c', [
    ('int   (*_padFuncNextPort)(int flag) PADMAIN_DATA = 0;', stamp(0x0C, 0x53).replace(SEC, ' PADMAIN_DATA') +
     'int   (*_padFuncNextPort)(int flag) PADMAIN_DATA = 0;'),
    ('int D_80137CE0 PADMAIN_DATA = 0;' + NL,
     'int D_80137CE0 PADMAIN_DATA = 0;' + NL +
     'static int _pad_reserved[3] PADMAIN_DATA = { 0, 0, 0 };   /* @0x80137CE4 : closes the 128-byte .data of PADMAIN.obj */' + NL),
])
edit('recon/syslib/psx/libmath/FERR.c', [
    ('extern int math_errno __attribute__((section(".data"))) = 0;', stamp(0x0B, 0x53) +
     'extern int math_errno __attribute__((section(".data"))) = 0;'),
])
edit('recon/syslib/psx/libcard/INIT.c', [
    ('unsigned char _card_stamp[16] = {', 'static unsigned char _lib_stamp[16] = {'),
])

p = R + 'linkers/nfs4_recon.data_extra.json'
rows = json.load(open(p))
row(rows, 'build/recon/syslib/psx/libgpu/SYS.c.o', 0x8012364C, 0x801237EC)
row(rows, 'build/recon/syslib/psx/libetc/VSYNC.c.o', 0x80134A80, 0x80134AA0)
row(rows, 'build/recon/syslib/psx/libmcrd/LIBMCRD.c.o', 0x80136CB0, 0x80136CD0)
row(rows, 'build/recon/syslib/psx/libpad/PADMAIN.c.o', 0x80137C70, 0x80137CF0)
row(rows, 'build/recon/syslib/psx/libmath/FERR.c.o', 0x8013BF10, 0x8013BF20)
json.dump(rows, open(p, 'w'), indent=1)
