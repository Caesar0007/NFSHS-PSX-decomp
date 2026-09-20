"""vfpod8.py -- remove the hand vtable-entry type (`typedef struct __nfs4_vtbl_ptr_t {...}; #define __vtbl_ptr_type ...`)
and its lead comment from every surface: no live code names it any more (the compiler emits every table)."""
import glob
import re

R = 'C:/Temp/nfs4-decomp/recon/'
pat = re.compile(r'(?:/\*(?:(?!\*/).)*?(?:vtable|vtbl)(?:(?!\*/).)*?\*/\n)?'
                 r'typedef struct __nfs4_vtbl_ptr_t \{[^}]*\} __nfs4_vtbl_ptr_t;\n#define __vtbl_ptr_type __nfs4_vtbl_ptr_t\n\n?', re.S)
for p in glob.glob(R + '**/*', recursive=True):
    p = p.replace(chr(92), '/')
    if not p.endswith(('.h', '.cpp', '.inc')):
        continue
    s = open(p, encoding='utf-8', errors='surrogateescape').read()
    if '__nfs4_vtbl_ptr_t' not in s:
        continue
    t, n = pat.subn('', s)
    left = t.count('__nfs4_vtbl_ptr_t') + len(re.findall(r'__vtbl_ptr_type', t))
    open(p, 'w', encoding='utf-8', errors='surrogateescape', newline='').write(t)
    print('%-50s blocks %d  mentions left %d' % (p.replace(R, ''), n, left))
