"""Blob ownership step 8 (2026-09-19) -- owners from gprefs.py static cross-references + SYM names:
  spchpsxz spchinit.c .data 0x80137094..0x801370B4  gSampleRequest, gSentenceRuleTest, gSentenceRuleSet, gReparm,
                                                    gTrace, gMemAlloc, gMemFree, gSPCH_Initialized (SPCH_Init/Deinit)
  spchpsxz spchbank.c .data 0x801370B4..0x801370C4  gVoxBanks, gNumBanks, gClearCycle (= 1), gCDErrors
  libgte COR_01.c     .data 0x8013BF20..0x8013BF40  H_cor_tbl, the CORDIC arctan steps csincos walks"""
import json

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


edit('recon/eaclib/psx/spchpsxz/spchinit.c', [
    ('#include "spchpick.h"\n',
     '#include "spchpick.h"\n\n'
     '/* spchinit.obj .data 0x80137094..0x801370B4, owned here since 2026-09-19 (gprefs.py: SPCH_Init / SPCH_Deinit;\n'
     ' * SYM names; zero but INITIALIZED in the retail image). */\n'
     'SPCHSampleRequestFn gSampleRequest = 0;                                   /* @0x80137094 */\n'
     'int  (*gSentenceRuleTest)(unsigned int, unsigned int, int) = 0;           /* @0x80137098 */\n'
     'void (*gSentenceRuleSet)(unsigned int, unsigned int, int, int) = 0;       /* @0x8013709C */\n'
     'int gReparm = 0;                                                          /* @0x801370A0 */\n'
     'int gTrace = 0;                                                           /* @0x801370A4 */\n'
     'SPCHAllocFn gMemAlloc = 0;                                                /* @0x801370A8 */\n'
     'SPCHFreeFn  gMemFree = 0;                                                 /* @0x801370AC */\n'
     'int gSPCH_Initialized = 0;                                                /* @0x801370B0 */\n'),
])
s = open(R + 'recon/eaclib/psx/spchpsxz/spchbank.c', encoding='utf-8').read()
inc = [i for i in range(len(s)) if s.startswith('#include', i)]
last = s.index('\n', inc[-1]) + 1
s = (s[:last] + '\n/* spchbank.obj .data 0x801370B4..0x801370C4, owned here since 2026-09-19 (SYM names, bank allocator state). */\n'
     'VoxBank **gVoxBanks = 0;   /* @0x801370B4 */\n'
     'int gNumBanks = 0;         /* @0x801370B8 */\n'
     'int gClearCycle = 1;       /* @0x801370BC */\n'
     'int gCDErrors = 0;         /* @0x801370C0 */\n' + s[last:])
open(R + 'recon/eaclib/psx/spchpsxz/spchbank.c', 'w', encoding='utf-8', newline='').write(s)
print('ok spchbank.c')
edit('recon/syslib/psx/libgte/COR_01.c', [
    ('extern int H_cor_tbl[];   /* @0x8013BF20 : CORDIC arctan steps {511,302,159,81,41,20} */\n',
     '/* COR_01.obj .data 0x8013BF20..0x8013BF40, owned here since 2026-09-19 (gprefs.py: csincos is the only user). */\n'
     'int H_cor_tbl[8] = { 511, 302, 159, 81, 41, 20, 0, 0 };   /* @0x8013BF20 : CORDIC arctan steps */\n'),
])

p = R + 'linkers/nfs4_recon.data_extra.json'
rows = json.load(open(p))
row(rows, 'build/recon/eaclib/psx/spchpsxz/spchinit.c.o', 0x80137094, 0x20)
row(rows, 'build/recon/eaclib/psx/spchpsxz/spchbank.c.o', 0x801370B4, 0x10)
row(rows, 'build/recon/syslib/psx/libgte/COR_01.c.o', 0x8013BF20, 0x20)
json.dump(rows, open(p, 'w'), indent=1)
