"""vfpod4.py -- delete the `extern __vtbl_ptr_type X_vtable[] ...;` declarations that outlived the hand-written tables
(every table is compiler-emitted now; the objects never reference these names)."""
import glob
import re

R = 'C:/Temp/nfs4-decomp/recon/'
NL = chr(10)
for p in glob.glob(R + '**/*', recursive=True):
    p = p.replace('\\', '/')
    if not p.endswith(('.h', '.cpp')) or p.endswith('nfs4_types.h'):
        continue
    s = open(p, encoding='utf-8', errors='surrogateescape').read()
    o = s
    s = re.sub(r'^extern (?:__vtbl_ptr_type|__nfs4_vtbl_ptr_t)\s+\w+_vtable\[\d*\](?:\s*,\s*\w+_vtable\[\d*\])*\s*;[ ]*\n', '', s, flags=re.M)
    if s != o:
        open(p, 'w', encoding='utf-8', errors='surrogateescape', newline='').write(s)
        print('ok', p.replace(R, ''))
