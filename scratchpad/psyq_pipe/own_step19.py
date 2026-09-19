"""Blob ownership step 19 (2026-09-19) -- two EA cells pinned by LINK ORDER between SDK-proven libcd/libmcrd data:
  ... C_009 (0x80136C88) | 0x80136C98 pfuncCdReadyCallback | C_007 (0x80136C9C) | 0x80136CAC sndcdvs | LIBMCRD (0x80136CB0)
  text link order there:  C_009, cdfs, C_007, scdvol, LIBMCRD  =>  cdfs.obj owns pfuncCdReadyCallback (a zero word nothing
  references; name from the retail SYM) and scdvol.obj owns sndcdvs.  sndcdvs is TWO shorts {64, 127} -- the old
  'six-short block' view ran into LIBMCRD's library stamp."""
import json

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)


def edit(f, pairs, tail=''):
    s = open(R + f, encoding='utf-8').read()
    for a, b in pairs:
        assert s.count(a) == 1, (f, a[:70], s.count(a))
        s = s.replace(a, b)
    if tail:
        s = s.rstrip(NL) + NL + NL + tail
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


edit('recon/eaclib/psx/sndpsxz/scdvol.c', [
    ('/* Six-short .data block @0x80136CAC; [0]=pan (64), [1]=master-scaled level (127 initially).' + NL +
     ' * The full-sized extern view preserves the oracle\'s absolute addressing and the data owner remains' + NL +
     ' * asm/data/data_8010CCD4.data.s. */' + NL +
     'extern short sndcdvs[6];' + NL,
     '/* scdvol.obj .data @0x80136CAC: [0]=pan (64), [1]=master-scaled level (127 initially).  TWO shorts -- LIBMCRD.obj\'s' + NL +
     ' * data starts right after.  The unsized extern view keeps the oracle\'s absolute addressing; the definition closes' + NL +
     ' * the file. */' + NL +
     'extern short sndcdvs[];' + NL),
], '/* scdvol.obj .data (retail 0x80136CAC), owned here since 2026-09-19 */' + NL +
   'short sndcdvs[2] __attribute__((section(".data"))) = { 0x40, 0x7F };' + NL)
edit('recon/eaclib/psx/eacpsxz/cdfs.c', [],
     '/* cdfs.obj .data (retail 0x80136C98), owned here since 2026-09-19: a ready-callback hook the shipped code never' + NL +
     ' * touches (name from the retail SYM; placed between libcd C_009 and C_007 exactly as cdfs.obj is in link order). */' + NL +
     'void (*pfuncCdReadyCallback)(unsigned char, unsigned char *) __attribute__((section(".data"))) = 0;' + NL)

p = R + 'linkers/nfs4_recon.data_extra.json'
rows = json.load(open(p))
for obj, base in (('build/recon/eaclib/psx/eacpsxz/cdfs.c.o', 0x80136C98), ('build/recon/eaclib/psx/sndpsxz/scdvol.c.o', 0x80136CAC)):
    rows[:] = [r for r in rows if not (r['obj'] == obj and r['section'] == '.data')]
    rows.append({'obj': obj, 'section': '.data', 'base': base, 'end': base + 4, 'size': 4, 'ok': True, 'unresolved': 0,
                 'words': 1, 'q': 0})
json.dump(rows, open(p, 'w'), indent=1)
