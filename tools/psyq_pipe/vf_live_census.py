"""vf_live_census.py -- hand-vtable residue in LIVE recon code (comments and `#if 0` blocks removed):
`_vf` members / accesses, `X_vtable` names, `__vtbl_ptr_type` uses, asm-labelled `_vt` symbols."""
import glob
import re

R = 'C:/Temp/nfs4-decomp/recon/'
tot = 0
for p in glob.glob(R + '**/*', recursive=True):
    p = p.replace(chr(92), '/')
    if not p.endswith(('.h', '.cpp', '.c', '.inc')):
        continue
    s = open(p, encoding='utf-8', errors='replace').read()
    s = re.sub(r'/\*.*?\*/', lambda m: chr(10) * m.group(0).count(chr(10)), s, flags=re.S)
    s = re.sub(r'//[^\n]*', '', s)
    out, skip = [], 0
    for i, line in enumerate(s.split(chr(10)), 1):
        t = line.strip()
        if skip:
            if re.match(r'#\s*if', t):
                skip += 1
            elif re.match(r'#\s*endif', t):
                skip -= 1
            continue
        if re.match(r'#\s*if\s+0\b', t):
            skip = 1
            continue
        if re.search(r'\b_vf\b|\w+_vtable\b|__vtbl_ptr_type|__nfs4_vtbl_ptr_t|"_vt[._$]', line):
            out.append((i, t[:130]))
    if out:
        tot += len(out)
        print(p.replace(R, ''))
        for i, t in out[:6]:
            print('   %5d  %s' % (i, t))
print('live hits', tot)
