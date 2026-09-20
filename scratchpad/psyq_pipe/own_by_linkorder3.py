"""own_by_linkorder3.py -- .bss owners proven by retail link order (linkorder_outliers.py):
  spchdata.obj (376) owns ONE contiguous .bss run 0x80148044..0x8014843C: gPreLoadTicks, gEventDats, gVoxInGame, gRepeatCount,
      gVoxEvents (were an __asm__ .bss block in spchevnt.c) + gGameNum, gFilterSetting, gLastSubTick, gDataRate, gLastTick (were
      an __asm__ .bss block in spchinit.c).  In the data module they are PLAIN C definitions in retail order.
  window.obj (404) owns windowbuf[312] + currentwindow[156] 0x801485AC..0x80148780 (were an __asm__ .bss block in movf.c)."""
import re

R = 'C:/Temp/nfs4-decomp/recon/eaclib/psx/'
NL = chr(10)


def rd(p):
    return open(R + p, encoding='utf-8').read()


def wr(p, s):
    open(R + p, 'w', encoding='utf-8', newline='').write(s)
    print('ok', p)


def cut_asm(text, first_label):
    m = re.search(r'__asm__\("\\t\.globl\\t' + first_label + r'.*?\\t\.text"\);\n', text, re.S)
    assert m, first_label
    return text[:m.start()], text[m.end():]


e = rd('spchpsxz/spchevnt.c')
a, b = cut_asm(e, 'gPreLoadTicks')
wr('spchpsxz/spchevnt.c', a + '/* storage: spchdata.obj (spchdata.c) owns gPreLoadTicks / gEventDats / gVoxInGame / gRepeatCount / gVoxEvents (link-order proof 2026-09-20) */' + NL + b)
i = rd('spchpsxz/spchinit.c')
a, b = cut_asm(i, 'gGameNum')
wr('spchpsxz/spchinit.c', a + '/* storage: spchdata.obj (spchdata.c) owns gGameNum / gFilterSetting / gLastSubTick / gDataRate / gLastTick (link-order proof 2026-09-20) */' + NL + b)
m = rd('eacpsxz/movf.c')
a, b = cut_asm(m, 'windowbuf')
wr('eacpsxz/movf.c', a + '/* storage: window.obj (window.c) owns windowbuf / currentwindow (link-order proof 2026-09-20) */' + NL + b)

d = rd('spchpsxz/spchdata.c')
d = d.rstrip() + NL + NL + (
    '/* .bss 0x80148044..0x8014843C -- one contiguous run in spchdata.obj\'s link-order slot, retail names and order.' + NL +
    ' * The users keep their own extern views (spchevnt.h spells gVoxInGame as int[2]: [1] is gRepeatCount). */' + NL +
    'int gPreLoadTicks;              /* @0x80148044 */' + NL +
    'VoxEventDat *gEventDats[4];     /* @0x80148048 the 4 bound event-data blobs */' + NL +
    'int gVoxInGame;                 /* @0x80148058 */' + NL +
    'int gRepeatCount;               /* @0x8014805C */' + NL +
    'VoxSlotsStruct gVoxEvents;      /* @0x80148060 the 16-slot queue + its header (968 B) */' + NL +
    'int gGameNum;                   /* @0x80148428 */' + NL +
    'int gFilterSetting;             /* @0x8014842C */' + NL +
    'int gLastSubTick;               /* @0x80148430 */' + NL +
    'int gDataRate;                  /* @0x80148434 */' + NL +
    'int gLastTick;                  /* @0x80148438 */' + NL)
wr('spchpsxz/spchdata.c', d)
w = rd('eacpsxz/window.c')
w = w.rstrip() + NL + NL + ('/* .bss 0x801485AC..0x80148780, in window.obj\'s link-order slot (sizes from the label spacing; element types unknown) */' + NL +
                            'int windowbuf[78];       /* @0x801485AC 312 B */' + NL + 'int currentwindow[39];   /* @0x801486E4 156 B : GPU window block */' + NL)
wr('eacpsxz/window.c', w)
