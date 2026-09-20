"""vfpod5.py -- recon/nfs4_types.h (the monolithic surface 26 small TUs use): every hand `_vf` pointer member becomes a
declared-only virtual destructor = the compiler's own vptr in the same place (layout-only, nothing dispatches here)."""
import re
P = 'C:/Temp/nfs4-decomp/recon/nfs4_types.h'
s = open(P, encoding='utf-8', errors='surrogateescape').read()
out, name, n = [], None, 0
for line in s.split(chr(10)):
    m = re.match(r'^(?:struct|class) (\w+)', line)
    if m:
        name = m.group(1)
    m = re.match(r'^(\s*)__vtbl_ptr_type\s+\(\*_vf\)\[\d+\];\s*(/\*.*\*/)?\s*$', line)
    if m:
        line = '%svirtual ~%s();   %s' % (m.group(1), name, (m.group(2) or '/* vptr */').replace('*/', '(the vptr; layout-only surface) */'))
        n += 1
    out.append(line)
open(P, 'w', encoding='utf-8', errors='surrogateescape', newline='').write(chr(10).join(out))
print('converted', n)
