"""Blob ownership step 6 (2026-09-19) -- named EA small-data cells that NO retail code references (so neither
the runtime trace nor gprefs.py can prove an owner); assigned by name + retail position:
  memstd.c   .sdata 0x8013DC10..0x8013DC20  memaborthook, galloccount, lowmemadr, highmemadr (= 0), directly
                                            ahead of memstd's own "%s LOW"/"%s HIGH" literals at 0x8013DC20
  locatbig.c .sdata 0x8013DC30..0x8013DC38  defaultbigext = ".viv" (8 bytes); locatbig is the next EA object with
                                            small data after memstd in retail link order"""
import json

R = 'C:/Temp/nfs4-decomp/'


def edit(f, pairs):
    s = open(R + f, encoding='utf-8').read()
    for a, b in pairs:
        assert s.count(a) == 1, (f, a[:70], s.count(a))
        s = s.replace(a, b)
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


edit('recon/eaclib/psx/eacpsxz/memstd.c', [
    ('#define MAGIC_USED 0x424D   /* \'MB\' */\n',
     '/* memstd.obj initialized small data 0x8013DC10..0x8013DC20 (owned here since 2026-09-19; SYM names, no retail\n'
     ' * code references them -- owner by name and by position right ahead of this object\'s literals). */\n'
     'void *memaborthook = 0;     /* @0x8013DC10 */\n'
     'int   galloccount = 0;      /* @0x8013DC14 */\n'
     'void *lowmemadr = 0;        /* @0x8013DC18 */\n'
     'void *highmemadr = 0;       /* @0x8013DC1C */\n\n'
     '#define MAGIC_USED 0x424D   /* \'MB\' */\n'),
])
edit('recon/eaclib/psx/eacpsxz/locatbig.c', [
    ('#include "stricmp.h"\n',
     '#include "stricmp.h"\n\n'
     '/* locatbig.obj small data 0x8013DC30 (owned here since 2026-09-19): the default big-file extension.  SYM name,\n'
     ' * unreferenced by retail code -- owner by name and retail link order (the next EA object with small data after\n'
     ' * memstd). */\n'
     'char defaultbigext[8] = ".viv";\n'),
])
edit('tools/build.py', [
    ('    "recon/eaclib/psx/eacpsxz/wildcard.c": {"g_value": "8"},',
     '    "recon/eaclib/psx/eacpsxz/locatbig.c": {"g_value": "8"},   # defaultbigext[8] is retail .sdata @0x8013dc30 (2026-09-19)\n'
     '    "recon/eaclib/psx/eacpsxz/wildcard.c": {"g_value": "8"},'),
])

p = R + 'linkers/nfs4_recon.data_extra.json'
rows = json.load(open(p))
for r in rows:
    if r['obj'].endswith('eacpsxz/memstd.c.o') and r['section'] == '.sdata':
        r['base'] = 0x8013DC10
        r['size'] = 0x20
        r['end'] = 0x8013DC30
        r['words'] = 8
rows = [r for r in rows if not (r['obj'].endswith('eacpsxz/locatbig.c.o') and r['section'] == '.sdata')]
rows.append({'obj': 'build/recon/eaclib/psx/eacpsxz/locatbig.c.o', 'section': '.sdata', 'base': 0x8013DC30,
             'end': 0x8013DC38, 'size': 8, 'ok': True, 'unresolved': 0, 'words': 2, 'q': 0})
json.dump(rows, open(p, 'w'), indent=1)
