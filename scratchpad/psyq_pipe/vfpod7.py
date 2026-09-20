"""vfpod7.py -- femenuoptions.cpp: the dead `__vtbl_ptr_type *entry...` / `char *adjusted` carrier locals (unused since the
real-virtuals conversion) and their SYM-CODEGEN-CARRIER notes go; then the now-unused `__nfs4_vtbl_ptr_t` typedef blocks
and the stale D_80054F24 extern are removed where nothing uses them any more."""
import glob
import re

R = 'C:/Temp/nfs4-decomp/recon/'
NL = chr(10)
p = R + 'frontend/common/femenuoptions.cpp'
s = open(p, encoding='utf-8').read()
for old in ('   * SYM-CODEGEN-CARRIER: entry' + NL + '   * SYM-CODEGEN-CARRIER: adjusted' + NL,
            '  __vtbl_ptr_type *entry;' + NL + '  char *adjusted;' + NL):
    assert s.count(old) == 1, old
    s = s.replace(old, '')
s, n = re.subn(r'  /\* SYM-CODEGEN-CARRIER: entry -- (?:(?!\*/).)*\*/\n  __vtbl_ptr_type \*entry;\n'
               r'  /\* SYM-CODEGEN-CARRIER: adjusted -- (?:(?!\*/).)*\*/\n  char \*adjusted;\n', '', s, flags=re.S)
assert n == 1
s, n = re.subn(r'  /\* SYM-CODEGEN-CARRIER: entry10 -- (?:(?!\*/).)*\*/\n  __vtbl_ptr_type \*entry10;\n'
               r'  /\* SYM-CODEGEN-CARRIER: entry6 -- (?:(?!\*/).)*\*/\n  __vtbl_ptr_type \*entry6;\n', '', s, flags=re.S)
assert n == 1
open(p, 'w', encoding='utf-8', newline='').write(s)
print('ok femenuoptions.cpp')

p = R + 'game/common/aih_btccop_externs.h'
s = open(p, encoding='utf-8').read()
s, n = re.subn(r'^extern __vtbl_ptr_type D_80054F24\[\];[^\n]*\n', '', s, flags=re.M)
assert n == 1
open(p, 'w', encoding='utf-8', newline='').write(s)
print('ok aih_btccop_externs.h')
