"""vfpod2.py -- layout-only copies of the front-end roots (tListIterator, tMenuItem, tMenu, tScreen) on surfaces that never
dispatch through them: the hand `_vf` pointer member becomes a real (declared-only) virtual destructor, which puts the
compiler's own vptr in the same place.  Nothing is emitted (no key function is defined on these surfaces)."""
import glob
import re

R = 'C:/Temp/nfs4-decomp/recon/'
NL = chr(10)
for p in glob.glob(R + '**/*_types.h', recursive=True):
    p = p.replace('\\', '/')
    h = open(p, encoding='utf-8').read()
    o = h

    def fix(m):
        cls = m.group(1)
        if cls not in ('tListIterator', 'tMenuItem', 'tMenu', 'tScreen'):
            return m.group(0)
        return m.group(0).replace(m.group(2),
                                  '    virtual ~%s();   /* layout-only surface: polymorphic root, never dispatched here (FE owns the interface) */' % cls)
    h = re.sub(r'^struct (\w+) \{(?:(?!^\};).)*?^(    __vtbl_ptr_type \(\*_vf\)\[\d+\];)', fix, h, flags=re.M | re.S)
    if h != o:
        open(p, 'w', encoding='utf-8', newline='').write(h)
        print('ok', p.replace(R, ''))
