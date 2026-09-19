"""Blob ownership step 16 (2026-09-19) -- 0x8013C328..0x8013C348 and 0x80136DEC, identified from the SDK objects:
  libcard INIT.c  .data 0x8013C328/16  = PsyQ 4.3 LIBCARD INIT.obj .data, byte-exact (50 73 03 25 9B 52 43 00 + 8 zero);
        nothing references it (the object has no relocation into .data): a stamp.
  libapi PAD.c    .data 0x8013C338/16  = the pad object's data: the init flag ReadInitPadFlag returns, a spare word and the
        two pad MMIO pointers (JOY_DATA 0x1F801040, I_STAT 0x1F801070).  The SDK object reaches the flag section-relative,
        i.e. it is a file-scope definition of this object, not an extern.  Sony library object => -G0 (build.py g_value 0),
        which is what keeps the access absolute.
  sndpsxz salloc.c .data 0x80136DEC/4  = the rolling allocation id; salloc.obj's only initialized data (was parked in snddata.c)"""
import json

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)


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


edit('recon/syslib/psx/libcard/INIT.c', [
    ('/* @0x8010C784 : InitCARD(val)',
     '/* INIT.obj .data (retail 0x8013C328, 16 bytes; identical in PsyQ 4.3 LIBCARD INIT.obj).  No code references it. */' + NL +
     'unsigned char _card_stamp[16] = { 0x50, 0x73, 0x03, 0x25, 0x9B, 0x52, 0x43, 0x00 };' + NL + NL +
     '/* @0x8010C784 : InitCARD(val)'),
])
edit('recon/syslib/psx/libapi/PAD.c', [
    ('extern int _init_pad_flag __asm__("D_8013C338");   /* @0x8013C338 : set by the BIOS pad init */' + NL,
     '/* 2026-09-19: the pad object OWNS its data (retail .data 0x8013C338, 16 bytes) -- the SDK object reaches the flag' + NL +
     ' * section-relative, which is a file-scope definition.  Sony library object => -G0, so the access stays absolute. */' + NL +
     'int _init_pad_flag = 0;                                       /* @0x8013C338 : set by the BIOS pad init */' + NL +
     'int _pad_spare = 0;                                           /* @0x8013C33C */' + NL +
     'unsigned char *_pad_joy_data = (unsigned char *)0x1F801040;   /* @0x8013C340 */' + NL +
     'unsigned long *_pad_i_stat = (unsigned long *)0x1F801070;     /* @0x8013C344 */' + NL),
])
edit('recon/eaclib/psx/sndpsxz/snddata.c', [
    ('extern int  DAT_80136dec = 0;   /* @0x80136DEC : rolling allocation id counter (salloc, +=0x20) */' + NL,
     '/* (2026-09-19) the rolling allocation id @0x80136DEC is salloc.obj data and is defined there */' + NL),
])
f = R + 'recon/eaclib/psx/sndpsxz/salloc.c'
s = open(f, encoding='utf-8').read().rstrip(NL)
s += (NL + NL + '/* salloc.obj .data (retail 0x80136DEC), owned here since 2026-09-19.  Defined at the END of the file and in an' + NL +
      ' * explicit section so every use above still sees the pure array extern (absolute lui/%lo addressing). */' + NL +
      'int DAT_80136dec[1] __attribute__((section(".data"))) = { 0 };' + NL)
open(f, 'w', encoding='utf-8', newline='').write(s)
print('ok salloc.c')

f = R + 'tools/build.py'
s = open(f, encoding='utf-8').read()
a = '    "recon/syslib/psx/libgte/MSC00.c":     {"g_value": "0"},'
assert s.count(a) == 1
s = s.replace(a, '    "recon/syslib/psx/libapi/PAD.c":       {"g_value": "0"},   # Sony libapi: owns _init_pad_flag + pad MMIO pointers, .data @0x8013c338 (2026-09-19)' + NL + a)
open(f, 'w', encoding='utf-8', newline='').write(s)

p = R + 'linkers/nfs4_recon.data_extra.json'
rows = json.load(open(p))
row(rows, 'build/recon/syslib/psx/libcard/INIT.c.o', 0x8013C328, 16)
row(rows, 'build/recon/syslib/psx/libapi/PAD.c.o', 0x8013C338, 16)
row(rows, 'build/recon/eaclib/psx/sndpsxz/salloc.c.o', 0x80136DEC, 4)
json.dump(rows, open(p, 'w'), indent=1)
