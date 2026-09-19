"""Blob ownership step 18 (2026-09-19) -- libcd streaming objects, from PsyQ 4.3 LIBCD object data (sdk_data_match.py):
  stcdint.c (SDK C_011.obj, StCdInterrupt)  .data is 80 bytes, byte-exact with retail 0x80136A98..0x80136AE8: the source
        declared only the 13 register pointers its code uses; the table continues with D3_MADR, D6_CHCR(0x1F8010D8),
        D6_MADR(0x1F8010D0), I_STAT, I_MASK, then the public `debug_cause` (+72) and one closing zero word.
  C_002 / C_005 / CDROM / C_009 / C_007: every SDK ring helper object owns a private copy of the four CD register
        pointers (16 bytes .data).  Retail has them at 0x80136AE8 / C58 / C78 / C88 / C9C -- assigned by LINK ORDER
        (stcdint, C_002, LIBPRESS, C_003, cdread2, C_005, iso9660, CDROM, C_009, cdfs, C_007, scdvol, LIBMCRD)."""
import json
import re

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
REGS = ('/* %s.obj .data (retail %#010x, 16 bytes): this object\'s private CD register pointers (PsyQ 4.3 LIBCD, byte-exact). */' + NL +
        'static volatile unsigned char *_cd_reg0 __attribute__((section(".data"))) = (volatile unsigned char *)0x1F801800;' + NL +
        'static volatile unsigned char *_cd_reg1 __attribute__((section(".data"))) = (volatile unsigned char *)0x1F801801;' + NL +
        'static volatile unsigned char *_cd_reg2 __attribute__((section(".data"))) = (volatile unsigned char *)0x1F801802;' + NL +
        'static volatile unsigned char *_cd_reg3 __attribute__((section(".data"))) = (volatile unsigned char *)0x1F801803;' + NL)
BASES = {'C_002': 0x80136AE8, 'C_005': 0x80136C58, 'CDROM': 0x80136C78, 'C_009': 0x80136C88, 'C_007': 0x80136C9C}

for name, base in BASES.items():
    f = R + 'recon/syslib/psx/libcd/%s.c' % name
    s = open(f, encoding='utf-8').read()
    assert '0x1F801800' not in s, name
    # after the leading comment block / includes: before the first line that is not comment, blank or preprocessor
    m = re.search(r'^(?!\s*$)(?!\s*/\*)(?!\s*\*)(?!#)(?!\s*//)', s, re.M)
    # make sure we are not inside a block comment
    while s[:m.start()].count('/*') != s[:m.start()].count('*/'):
        m = re.compile(r'^(?!\s*$)(?!\s*/\*)(?!\s*\*)(?!#)(?!\s*//)', re.M).search(s, m.end() + 1)
    s = s[:m.start()] + REGS % (name, base) + NL + s[m.start():]
    open(f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', name)

f = R + 'recon/syslib/psx/libcd/stcdint.c'
s = open(f, encoding='utf-8').read()
a = ('/* (+0x34 0x1F8010B0 _d3_madr and beyond continue the retail table but are' + NL +
     ' * past every slot this TU\'s code references -- left undeclared.) */' + NL)
assert s.count(a) == 1
s = s.replace(a,
              '/* The table continues past the slots this TU\'s code uses; PsyQ 4.3 C_011.obj .data (80 bytes) is byte-exact with' + NL +
              ' * retail 0x80136A98..0x80136AE8, so the rest is declared too (owned here since 2026-09-19). */' + NL +
              'static volatile int    *_d3_madr     ST_DATA = (volatile int   *)0x1F8010B0;  /* @0x80136ACC CD MADR      */' + NL +
              'static volatile int    *_d6_chcr     ST_DATA = (volatile int   *)0x1F8010D8;  /* @0x80136AD0              */' + NL +
              'static volatile int    *_d6_madr     ST_DATA = (volatile int   *)0x1F8010D0;  /* @0x80136AD4              */' + NL +
              'static volatile int    *_i_stat      ST_DATA = (volatile int   *)0x1F801070;  /* @0x80136AD8 I_STAT       */' + NL +
              'static volatile int    *_i_mask      ST_DATA = (volatile int   *)0x1F801074;  /* @0x80136ADC I_MASK       */' + NL +
              'int debug_cause ST_DATA = 0;                 /* @0x80136AE0 : last interrupt stage/abort code (public in C_011.obj) */' + NL +
              'static int _st_data_end ST_DATA = 0;         /* @0x80136AE4 : closing zero word of C_011.obj .data */' + NL)
b = 'extern int debug_cause;   /* @0x80136AE0 : last interrupt stage/abort code (debug) */' + NL
assert s.count(b) == 1
s = s.replace(b, '/* debug_cause (@0x80136AE0) is defined with this object\'s data table above. */' + NL)
open(f, 'w', encoding='utf-8', newline='').write(s)
print('ok stcdint')

p = R + 'linkers/nfs4_recon.data_extra.json'
rows = json.load(open(p))


def row(obj, base, size):
    rows[:] = [r for r in rows if not (r['obj'] == obj and r['section'] == '.data')]
    rows.append({'obj': obj, 'section': '.data', 'base': base, 'end': base + size, 'size': size, 'ok': True,
                 'unresolved': 0, 'words': size // 4, 'q': 0})


row('build/recon/syslib/psx/libcd/stcdint.c.o', 0x80136A98, 80)
for name, base in BASES.items():
    row('build/recon/syslib/psx/libcd/%s.c.o' % name, base, 16)
json.dump(rows, open(p, 'w'), indent=1)
