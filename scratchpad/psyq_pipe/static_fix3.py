"""static_fix3.py -- the six Vox accessors at 0x80100710..0x8010077C are LOCAL labels right before iSPCH_MatchSample and their
only callers are in spchpick: they are spchpick.obj's own static copies (spchrule / spchevnt have theirs too; retail even
has the same names twice).  They move from the invented exporting file spchdata.c to the top of spchpick.c."""
import os
import re

R = 'C:/Temp/nfs4-decomp/recon/eaclib/psx/spchpsxz/'
NL = chr(10)
d = open(R + 'spchdata.c', encoding='utf-8').read()
i = d.index('/* iSPCH_GetMatchValue @0x80100710')
body = d[i:].rstrip() + NL
body, n = re.subn(r'^(int|void \*)(\s*)(iSPCH_GetMatchValue|VoxSentence_GetShortRule|VoxSentence_GetNumPhrases|'
                  r'VoxEvent_GetFilterLengthFlag|iSPCH_GetOffset8|iSPCH_GetOffset16)\(', r'static \1\2\3(', body, flags=re.M)
assert n == 6, n
p = open(R + 'spchpick.c', encoding='utf-8').read()
inc = '#include "spchdata.h"' + NL
assert p.count(inc) == 1
last = [m for m in re.finditer(r'^#include [^\n]*\n', p, re.M)][-1]
p = (p[:last.end()] + NL + '/* ---- spchpick.obj\'s own static copies of the shared Vox accessors (retail SYM: local labels 0x80100710..) ---- */' + NL +
     body + p[last.end():])
p = p.replace(inc, '')
open(R + 'spchpick.c', 'w', encoding='utf-8', newline='').write(p)
x = open(R + 'spch_externs.h', encoding='utf-8').read()
assert x.count(inc) == 1
open(R + 'spch_externs.h', 'w', encoding='utf-8', newline='').write(x.replace(inc, ''))
os.remove(R + 'spchdata.c')
os.remove(R + 'spchdata.h')
print('ok')
