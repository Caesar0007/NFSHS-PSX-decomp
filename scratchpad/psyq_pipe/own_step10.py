"""Blob ownership step 10 (2026-09-19):
  eacpsxz textset.c  .data 0x80135BA0..0x80135C58  `currentfont` (SYM name), one 184-byte zero-initialized structure:
        gprefs.py shows font.cpp addressing +0x88 (0x80135C28) and textpsx.c +0x94 (0x80135C34) inside it; textset is the
        first EA text object after libetc INTR in retail link order and its main user.
  libetc INTR.c      .data tail 0x80135B94..0x80135BA0  three zero words after trapMissedCount -- they round INTR.obj .data
        to exactly 0x1100 bytes (0x80134AA0..0x80135BA0); no retail code references them."""
import json

R = 'C:/Temp/nfs4-decomp/'


def edit(f, pairs):
    s = open(R + f, encoding='utf-8').read()
    for a, b in pairs:
        assert s.count(a) == 1, (f, a[:70], s.count(a))
        s = s.replace(a, b)
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


edit('recon/syslib/psx/libetc/INTR.c', [
    ('int trapMissedCount __asm__("D_80135B90") = 0;\n',
     'int trapMissedCount __asm__("D_80135B90") = 0;\n'
     '/* SYM-GLOBAL-CARRIER: three zero words close INTR.obj .data at a round 0x1100 bytes (names not retained) */\n'
     'int intr_reserved[3] __asm__("D_80135B94") = { 0, 0, 0 };\n'),
])
s = open(R + 'recon/eaclib/psx/eacpsxz/textset.c', encoding='utf-8').read()
assert 'unsigned char currentfont[184]' not in s
s = s.rstrip('\n') + ('\n\n/* textset.obj .data 0x80135BA0..0x80135C58, owned here since 2026-09-19: the current-font state block (SYM name\n'
                      ' * `currentfont`; zero but INITIALIZED in the retail image).  Defined after its uses so the unsized extern above keeps\n'
                      ' * the retail addressing.  font.cpp reaches +0x88 and textpsx.c the text-draw hook at +0x94 of this same block. */\n'
                      'unsigned char currentfont[184] = { 0 };\n')
open(R + 'recon/eaclib/psx/eacpsxz/textset.c', 'w', encoding='utf-8', newline='').write(s)
print('ok textset.c')

p = R + 'linkers/nfs4_recon.data_extra.json'
rows = json.load(open(p))
for r in rows:
    if r['obj'].endswith('libetc/INTR.c.o') and r['section'] == '.data':
        r['size'] = 0x1100
        r['end'] = r['base'] + 0x1100
        r['words'] = 0x1100 // 4
rows = [r for r in rows if not (r['obj'].endswith('eacpsxz/textset.c.o') and r['section'] == '.data')]
rows.append({'obj': 'build/recon/eaclib/psx/eacpsxz/textset.c.o', 'section': '.data', 'base': 0x80135BA0,
             'end': 0x80135C58, 'size': 0xB8, 'ok': True, 'unresolved': 0, 'words': 0xB8 // 4, 'q': 0})
json.dump(rows, open(p, 'w'), indent=1)
