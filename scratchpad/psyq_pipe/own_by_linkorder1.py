"""own_by_linkorder1.py -- .sdata owners proven by retail LINK ORDER (PSYLINK lays small data out per object in FILE-record
order; data_owner_by_linkorder.py brackets):
  vars.obj (idx 267)     library, disablecd, currentfilesystem, availablefilesystems  0x8013DC54..64 (head of its block)
  textfor.obj (317)      textntabstops, texttabstops, showmissingcharacters          0x8013DD50..5C
  callback.obj (361)     loadfilecallback                                             0x8013DD60
  window.obj (404)       videopages, videopage, windowpage                            0x8013DD64..70   NEW data-only TU
  pageflip.obj (491)     gpusetdispenv, vblsetdispenv, vsdeferred                     0x8013DD70..7C   NEW data-only TU
The residual asm pieces lose those cells (r24 disappears) and the recon .sdata fragment lists the owners instead."""
import os
import re

R = 'C:/Temp/nfs4-decomp/'
E = R + 'recon/eaclib/psx/eacpsxz/'
NL = chr(10)


def rd(p):
    return open(p, encoding='utf-8').read()


def wr(p, s):
    open(p, 'w', encoding='utf-8', newline='').write(s)
    print('ok', p.replace(R, ''))


def drop_cells(path, names):
    s = rd(path)
    for n in names:
        s, k = re.subn(r'nonmatching ' + n + r'\n\s*\n?dlabel ' + n + r'\n[^\n]*\n(?:enddlabel|\.size) ' + n + r'[^\n]*\n\s*\n?', '', s)
        assert k == 1, (path, n)
    wr(path, s)


v = rd(E + 'vars.c')
a = 'int kanjiwidth = 0;'
assert v.count(a) == 1
v = v.replace(a, '/* head of vars.obj\'s .sdata block (owner proven by retail link order, 2026-09-20) */' + NL +
              'int library = 4;               /* @0x8013DC54 */' + NL + 'int disablecd = 1;             /* @0x8013DC58 */' + NL +
              'int currentfilesystem = 0;     /* @0x8013DC5C */' + NL + 'int availablefilesystems = 0;  /* @0x8013DC60 */' + NL + a)
wr(E + 'vars.c', v)

t = rd(E + 'textfor.c')
last = [m for m in re.finditer(r'^#include [^\n]*\n', t, re.M)][-1]
t = (t[:last.end()] + NL + '/* textfor.obj .sdata 0x8013DD50..0x8013DD5C (owner proven by retail link order; no debug records, types are int-sized) */' + NL +
     'int textntabstops = 0;           /* @0x8013DD50 */' + NL + 'int texttabstops = 0;            /* @0x8013DD54 */' + NL +
     'int showmissingcharacters = 0;   /* @0x8013DD58 */' + NL + t[last.end():])
wr(E + 'textfor.c', t)

c = rd(E + 'callback.c')
last = [m for m in re.finditer(r'^#include [^\n]*\n', c, re.M)][-1]
c = (c[:last.end()] + NL + '/* callback.obj .sdata 0x8013DD60 (owner proven by retail link order: the only cell between threads.obj and window.obj) */' + NL +
     'int (*loadfilecallback)(void *dest, char *name, int memclass) = 0;   /* @0x8013DD60 */' + NL + c[last.end():])
wr(E + 'callback.c', c)

wr(E + 'window.c',
   '/* eaclib/psx/eacpsxz/window.c -- RECONSTRUCTED.  eacpsxz.lib(window.obj): retail SYM FILE record, link index 404.' + NL +
   ' *   No function of it is in the image; its contribution is this .sdata block 0x8013DD64..0x8013DD70 (zero, INITIALISED),' + NL +
   ' *   which sits exactly in its link-order slot.  No debug records: the cells are int-sized, types unknown. */' + NL +
   'int videopages = 0;   /* @0x8013DD64 */' + NL + 'int videopage = 0;    /* @0x8013DD68 */' + NL + 'int windowpage = 0;   /* @0x8013DD6C */' + NL)
wr(E + 'pageflip.c',
   '/* eaclib/psx/eacpsxz/pageflip.c -- RECONSTRUCTED.  eacpsxz.lib(pageflip.obj): retail SYM FILE record, link index 491.' + NL +
   ' *   No function of it is in the image; its contribution is this .sdata block 0x8013DD70..0x8013DD7C (zero, INITIALISED),' + NL +
   ' *   the last cells of .sdata.  No debug records: the cells are int-sized, types unknown. */' + NL +
   'int gpusetdispenv = 0;   /* @0x8013DD70 */' + NL + 'int vblsetdispenv = 0;   /* @0x8013DD74 */' + NL + 'int vsdeferred = 0;      /* @0x8013DD78 */' + NL)

D = R + 'asm/data/'
drop_cells(D + 'sdata_8013C54C_r22.sdata.s', ['library', 'disablecd', 'currentfilesystem', 'availablefilesystems'])
drop_cells(D + 'sdata_8013C54C_r23.sdata.s', ['textntabstops', 'texttabstops', 'showmissingcharacters'])
os.remove(D + 'sdata_8013C54C_r24.sdata.s')

f = rd(R + 'linkers/nfs4_recon.sdata_8013C54C.ldfrag')
x = '    build/asm/data/sdata_8013C54C_r24.sdata.s.o(.sdata);'
assert f.count(x) == 1
f = f.replace(x, '    build/recon/eaclib/psx/eacpsxz/callback.c.o(.sdata);   /* 0x8013dd60 loadfilecallback (was r24) */' + NL +
              '    build/recon/eaclib/psx/eacpsxz/window.c.o(.sdata);     /* 0x8013dd64..0x8013dd70 (was r24) */' + NL +
              '    build/recon/eaclib/psx/eacpsxz/pageflip.c.o(.sdata);   /* 0x8013dd70..0x8013dd7c (was r24) */')
y = '    build/recon/eaclib/psx/eacpsxz/threads.c.o(.sbss);'
assert f.count(y) == 1
f = f.replace(y, '    build/recon/eaclib/psx/eacpsxz/textfor.c.o(.sdata);    /* 0x8013dd50..0x8013dd5c (was the r23 tail) */' + NL + y)
wr(R + 'linkers/nfs4_recon.sdata_8013C54C.ldfrag', f)
