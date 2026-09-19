"""Blob ownership step 5 (2026-09-19):
  libc SPRINTF.c  .data 0x8012348C..0x8012349C  the zero printf_info template sprintf block-copies (runtime trace:
                                                 sprintf loads 0x8012348C/90/94) + one zero word
  eacpsxz random.c .data 0x8012349C..0x801234B4  the 6-word PRNG state `seed` (== seedrandom(0))"""
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


edit('recon/syslib/psx/libc/SPRINTF.c', [
    ('extern printf_info D_8012348C;\n',
     '/* SPRINTF.obj .data 0x8012348C..0x8012349C, owned here since 2026-09-19 (runtime trace: sprintf block-copies\n'
     ' * this zero template into its local; retail keeps it in .data, i.e. it is initialized, not const). */\n'
     'printf_info D_8012348C ' + D + ' = { 0 };\n'
     '/* SYM-GLOBAL-CARRIER: one zero word closes SPRINTF.obj .data (retail bytes; name not retained) */\n'
     'int D_80123498 ' + D + ' = 0;\n'),
])

edit('recon/eaclib/psx/eacpsxz/random.c', [
    ('extern unsigned seed[6];\n',
     'unsigned seed[6] = {                         /* random.obj .data 0x8012349C, owned here since 2026-09-19 */\n'
     '    0xF22D0E56u, 0x883126E9u, 0xC624DD2Fu, 0x0702C49Cu, 0x9E353F7Du, 0x6FDF3B64u\n'
     '};\n'),
    ('__asm__(\n    "\\t.set noat\\n"\n    "\\t.set\\tnoreorder\\n"',
     '__asm__(\n    "\\t.text\\n"   /* the seed definition above leaves the assembler in .data */\n'
     '    "\\t.set noat\\n"\n    "\\t.set\\tnoreorder\\n"'),
])

p = R + 'linkers/nfs4_recon.data_extra.json'
rows = json.load(open(p))
row(rows, 'build/recon/syslib/psx/libc/SPRINTF.c.o', 0x8012348C, 0x10)
row(rows, 'build/recon/eaclib/psx/eacpsxz/random.c.o', 0x8012349C, 0x18)
json.dump(rows, open(p, 'w'), indent=1)
