"""vfpod6.py -- drop every `#include ".../nfs4_types.h"` (the monolithic hand-vtable-era surface).  A probe showed only 26
(near-)empty TUs really compile it; whatever they need is then given to them directly."""
import glob
import re

R = 'C:/Temp/nfs4-decomp/recon/'
n = 0
for p in glob.glob(R + '**/*', recursive=True):
    p = p.replace(chr(92), '/')
    if not p.endswith(('.h', '.cpp', '.c')):
        continue
    s = open(p, encoding='utf-8', errors='surrogateescape').read()
    t = re.sub(r'^#include "(?:\.\./)*nfs4_types\.h"[^\n]*\n', '', s, flags=re.M)
    if t != s:
        open(p, 'w', encoding='utf-8', errors='surrogateescape', newline='').write(t)
        n += 1
print('includes dropped in', n, 'files')
