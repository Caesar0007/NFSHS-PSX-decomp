"""spchdata_restore.py -- spchdata.obj is a REAL retail module (SYM FILE record `spchpsxz.lib(spchdata.obj)`, linked right
before spchpick.obj).  It is the speech library's global DATA module: the twelve initialised globals 0x80137094..0x801370C4
are one contiguous block in exactly that link-order slot (right before sclcptch.obj's `sndcents`), in an order no
spchbank-then-spchinit layout could give.  They move out of spchinit.c / spchbank.c (their USERS) into spchdata.c."""
import re

R = 'C:/Temp/nfs4-decomp/recon/eaclib/psx/spchpsxz/'
NL = chr(10)
i_ = open(R + 'spchinit.c', encoding='utf-8').read()
a = i_.index('/* spchinit.obj .data 0x80137094..0x801370B4')
b = i_.index('int gSPCH_Initialized = 0;')
b = i_.index(NL, b) + 1
blk1 = i_[a:b]
defs1 = [l for l in blk1.split(NL) if re.match(r'^[A-Za-z]', l)]
assert len(defs1) == 8, defs1
i_ = i_[:a] + '/* the library globals SPCH_Init / SPCH_Deinit use are owned by spchdata.obj (spchdata.c) */' + NL + i_[b:]
open(R + 'spchinit.c', 'w', encoding='utf-8', newline='').write(i_)

k = open(R + 'spchbank.c', encoding='utf-8').read()
a = k.index('/* spchbank.obj .data 0x801370B4..0x801370C4')
b = k.index('int gCDErrors = 0;')
b = k.index(NL, b) + 1
blk2 = k[a:b]
defs2 = [l for l in blk2.split(NL) if re.match(r'^[A-Za-z]', l)]
assert len(defs2) == 4, defs2
k = k[:a] + '/* the bank allocator state (gVoxBanks, gNumBanks, gClearCycle, gCDErrors) is owned by spchdata.obj (spchdata.c) */' + NL + k[b:]
open(R + 'spchbank.c', 'w', encoding='utf-8', newline='').write(k)

src = ('/* eaclib/psx/spchpsxz/spchdata.c -- RECONSTRUCTED.  spchpsxz.lib(spchdata.obj): the speech library\'s global DATA module.' + NL +
       ' *   Retail SYM lists the module (FILE record, linked right before spchpick.obj) and no function belongs to it: the six' + NL +
       ' *   Vox accessors once kept here are LOCAL labels of spchpick.obj.  Its contribution is this one contiguous .data block' + NL +
       ' *   0x80137094..0x801370C4 (zero but INITIALISED in the image), which sits in spchdata.obj\'s link-order slot, right before' + NL +
       ' *   sclcptch.obj\'s sndcents.  The variables are USED by spchinit / spchbank / spchpick / spchrule (externs in their headers). */' + NL +
       '#include "../eaclib_types.h"' + NL + '#include "spch_types.h"' + NL + '#include "spchinit.h"' + NL + '#include "spchbank.h"' + NL + NL +
       NL.join(defs1) + NL + NL.join(defs2) + NL)
open(R + 'spchdata.c', 'w', encoding='utf-8', newline='').write(src)
print('ok')
