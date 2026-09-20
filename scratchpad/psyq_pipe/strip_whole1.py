"""strip_whole1.py -- library members retail LINKED (SYM FILE records) and then stripped WHOLE: every function in them was
unreferenced once libapi PAD.obj's InitPAD/StartPAD/StopPAD/PAD_init were removed (A18..A21), or nobody called them
(libgpu P26 SetTile, P20 SetSprt8).  Each becomes its own file holding only LINK_STRIPPED code."""
import json

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)


def wr(p, s):
    open(R + p, 'w', encoding='utf-8', newline='').write(s)
    print('ok', p)


jf = json.load(open(R + 'linkers/link_stripped.json'))
for mem, fn, idx in (('A18', 'InitPAD2', 0x12), ('A19', 'StartPAD2', 0x13), ('A20', 'StopPAD2', 0x14), ('A21', 'PAD_init2', 0x15)):
    wr('recon/syslib/psx/libapi/%s.c' % mem,
       '/* syslib/psx/libapi/%s.c -- RECONSTRUCTED.  obj libapi.lib(%s.OBJ): %s -- BIOS 0xB0:0x%02X tail-call thunk.' % (mem, mem, fn, idx) + NL +
       ' *   Retail LINKED this member (SYM FILE record, tail of the link order: libapi PAD.obj references it) and its final' + NL +
       ' *   link then REMOVED it: PAD.obj\'s InitPAD / StartPAD / StopPAD / PAD_init were unreferenced, so nothing called this' + NL +
       ' *   any more.  No B0:0x%02X trampoline exists anywhere in the image.  Bytes: PsyQ 4.3 libapi %s.obj. */' % (idx, mem) + NL +
       '#include "../../../lib/bios_thunk.h"' + NL + NL + 'BIOS_THUNK_LINK_STRIPPED(%s, 0xB0, 0x%X);' % (fn, idx) + NL)
    jf['functions'].append({'object': 'build/recon/syslib/psx/libapi/%s.c.o' % mem, 'function': fn, 'sdk': 'LIBAPI/' + fn,
                            'evidence': 'libapi.lib(%s.obj) is in the retail SYM FILE list; no B0:0x%02X trampoline exists in the image (full `jr t2` enumeration)' % (mem, idx)})
for mem, fn, code in (('P26', 'SetTile', 0x60), ('P20', 'SetSprt8', 0x74)):
    wr('recon/syslib/psx/libgpu/%s.c' % mem,
       '/* syslib/psx/libgpu/%s.c -- RECONSTRUCTED.  obj libgpu.lib(%s.OBJ): %s -- initialise a primitive (len 3, code 0x%02X).' % (mem, mem, fn, code) + NL +
       ' *   Retail LINKED this member (SYM FILE record, between libmath ADDMANT.obj and libgpu P09.obj) and its final link then' + NL +
       ' *   REMOVED the function as unreferenced: that slot holds a 4-byte pad only.  Bytes: PsyQ 4.3 libgpu %s.obj. */' % mem + NL +
       '#include "../../../link_stripped.h"' + NL + NL + 'extern void %s(void *p) LINK_STRIPPED;' % fn + NL +
       'extern void %s(void *p)' % fn + NL + '{' + NL + '    ((unsigned char *)p)[3] = 3;        /* setlen  */' + NL +
       '    ((unsigned char *)p)[7] = 0x%02x;     /* setcode */' % code + NL + '}' + NL)
    jf['functions'].append({'object': 'build/recon/syslib/psx/libgpu/%s.c.o' % mem, 'function': fn, 'sdk': 'LIBGPU/' + fn,
                            'evidence': 'libgpu.lib(%s.obj) is in the retail SYM FILE list; its link-order text slot (0x8010701C..0x80107020) is a 4-byte pad and the function bytes are nowhere in the image' % mem})
open(R + 'linkers/link_stripped.json', 'w', encoding='utf-8', newline='').write(json.dumps(jf, indent=1) + NL)
