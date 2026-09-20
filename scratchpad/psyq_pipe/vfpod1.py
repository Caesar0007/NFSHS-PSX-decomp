"""vfpod1.py -- the POD layout copies of polymorphic classes that non-dispatching surfaces still carry (a hand `_vf`
pointer member): ObjectAnim and AIDataRecord_t become real polymorphic declarations (vptr in the same place, nothing is
emitted: the key functions live in object.cpp / aidatarecord.cpp).  Verified by object hashes (must not change)."""
import glob
import re

R = 'C:/Temp/nfs4-decomp/recon/'
NL = chr(10)
ROOT = ('struct DRender_tView;' + NL + 'struct Draw_DCache;' + NL +
        "/* object.cpp's polymorphic root, as this surface needs it: virtual dtor [slot 1], pure Draw [slot 2] */" + NL +
        'struct ObjectAnim {' + NL + '    virtual ~ObjectAnim();' + NL +
        '    virtual int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset) = 0;' + NL + '};')
for p in glob.glob(R + '**/*_types.h', recursive=True):
    p = p.replace('\\', '/')
    h = open(p, encoding='utf-8').read()
    o = h
    h = re.sub(r'struct ObjectAnim \{\s*__vtbl_ptr_type \(\*_vf\)\[3\];\s*\};', lambda m: ROOT, h)
    h = re.sub(r'^struct (\w+) \{(\s*)ObjectAnim _base_ObjectAnim;[ ]*\n?', lambda m: 'struct %s : public ObjectAnim {%s' % (m.group(1), NL if NL in m.group(2) else ' '), h, flags=re.M)
    m = re.search(r'^struct AIDataRecord_t \{.*?^\};', h, re.M | re.S)
    if m and '(*_vf)[3];' in m.group(0):
        body = m.group(0).replace('    __vtbl_ptr_type (*_vf)[3];',
                                  '    virtual ~AIDataRecord_t();   /* aidatarecord.cpp owns the family; slots: dtor, Setup */' + NL +
                                  '    virtual void Setup();')
        h = h[:m.start()] + body + h[m.end():]
    if h != o:
        open(p, 'w', encoding='utf-8', newline='').write(h)
        print('ok', p.replace(R, ''))
