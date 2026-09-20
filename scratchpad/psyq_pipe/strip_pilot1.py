"""strip_pilot1.py -- pilot of the LINK_STRIPPED model on libcd SYS.obj (recon/syslib/psx/libcd/cdcont.c).
Retail's final link removed the four functions nobody calls; PsyQ 4.3's SYS.obj gives their bytes:
  CdLastCom @32+16, CdComstr @220+52, CdIntstr @272+52, CdMix @1384+32.
They come back as natural C in their SDK positions, tagged LINK_STRIPPED (own input section, discarded at link);
the unused-inline "none" carrier goes away because CdComstr / CdIntstr own that literal again."""
R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
open(R + 'recon/link_stripped.h', 'w', encoding='utf-8', newline='').write(
    '/* recon/link_stripped.h -- retail\'s final link removed UNREFERENCED FUNCTIONS from the objects it linked and kept their' + NL +
    ' * data (proof: libcd SYS.obj is PsyQ 4.3\'s object minus CdLastCom/CdComstr/CdIntstr/CdMix, every other function at its' + NL +
    ' * exact size; libapi PAD.obj keeps 16 of its 768 text bytes and all of its data).  A function the link removed is written' + NL +
    ' * in full, in its original place, and tagged on its PROTOTYPE:' + NL +
    ' *     extern int CdLastCom(void) LINK_STRIPPED;' + NL +
    ' * The tag only names the input section; the recon linker script discards that section, so the rest of the object closes' + NL +
    ' * up exactly like retail.  Every tagged function must be listed, with its evidence, in linkers/link_stripped.json' + NL +
    ' * (checked by tools/gen_ld.py); a call from kept code to a tagged function fails the link. */' + NL +
    '#ifndef NFS4_LINK_STRIPPED_H' + NL + '#define NFS4_LINK_STRIPPED_H' + NL +
    '#define LINK_STRIPPED __attribute__((section(".text.strip")))' + NL + '#endif' + NL)

p = R + 'recon/syslib/psx/libcd/cdcont.c'
s = open(p, encoding='utf-8').read()
a = s.index('/* SYS.obj .rdata (retail 0x80057100): "none".')
b = s.index('}', s.index('static __inline__ const char *CdComstr')) + 1
s = s[:a].rstrip() + NL + s[b:]

x = 'extern CdlLOC        CD_pos;      /* @0x8013BF60 */' + NL
assert s.count(x) == 1
s = s.replace(x, x + 'extern unsigned char CD_com;      /* @0x8013BF65 */' + NL +
              'extern char         *CD_comstr[];  /* @0x8013BF6C */' + NL + 'extern char         *CD_intstr[];  /* @0x8013BFEC */' + NL)
x = '/* ---- driver state globals'
assert s.count(x) == 1
s = s.replace(x, '#include "../../../link_stripped.h"' + NL +
              '/* SYS.obj functions nobody calls: removed by retail\'s final link, bytes known from PsyQ 4.3 SYS.obj */' + NL +
              'extern int   CdLastCom(void) LINK_STRIPPED;' + NL + 'extern char *CdComstr(unsigned char com) LINK_STRIPPED;' + NL +
              'extern char *CdIntstr(unsigned char intr) LINK_STRIPPED;' + NL + 'extern int   CdMix(void *vol) LINK_STRIPPED;' + NL +
              'extern int   CD_vol(void *vol);   /* libcd BIOS.obj -- itself link-stripped in retail */' + NL + NL + x)
x = '/* @0x800F77A0 : CdLastPos */'
assert s.count(x) == 1
s = s.replace(x, '/* SYS.obj +32 (LINK-STRIPPED) : CdLastCom */' + NL + 'extern int CdLastCom(void) { return (unsigned)CD_com; }' + NL + NL + x)
x = '/* @0x800F784C : CdSync'
assert s.count(x) == 1, 'CdSync marker'
s = s.replace(x, '/* SYS.obj +220 (LINK-STRIPPED) : CdComstr -- name of a primary command */' + NL +
              'extern char *CdComstr(unsigned char com)' + NL + '{' + NL + '    if (com > 0x1b) {' + NL + '        return "none";' + NL + '    }' + NL +
              '    return CD_comstr[com];' + NL + '}' + NL + NL +
              '/* SYS.obj +272 (LINK-STRIPPED) : CdIntstr -- name of an interrupt result */' + NL +
              'extern char *CdIntstr(unsigned char intr)' + NL + '{' + NL + '    if (intr > 6) {' + NL + '        return "none";' + NL + '    }' + NL +
              '    return CD_intstr[intr];' + NL + '}' + NL + NL + x)
x = '/* @0x800F7C70 : CdGetSector'
assert s.count(x) == 1, 'CdGetSector marker'
s = s.replace(x, '/* SYS.obj +1384 (LINK-STRIPPED) : CdMix */' + NL + 'extern int CdMix(void *vol)' + NL + '{' + NL + '    CD_vol(vol);' + NL +
              '    return 1;' + NL + '}' + NL + NL + x)
open(p, 'w', encoding='utf-8', newline='').write(s)
print('ok')
