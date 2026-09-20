"""Real virtuals, leftovers (2026-09-20): draww.cpp dispatched ObjectAnim::Draw through its private POD copy of the class.
object.cpp owns the real family (fevirt_object.py); draww's surface now declares the same polymorphic root (destructor
declared, Draw pure) -- it emits nothing here (no key function, never constructed), it only makes `anim->Draw(...)` a
real virtual call.  The two finished-anim copies draww never used as objects become real derived declarations."""
import re

R = 'C:/Temp/nfs4-decomp/recon/game/psx/'
NL = chr(10)
h = open(R + 'draww_types.h', encoding='utf-8').read()
old = ('struct ObjectAnim { __vtbl_ptr_type (*_vf)[3]; };' + NL + 'struct ObjectFinishedMultiAnim { ObjectAnim _base_ObjectAnim; };' + NL +
       'struct ObjectFinishedSignAnim {' + NL + '    ObjectAnim _base_ObjectAnim;' + NL)
assert h.count(old) == 1
m = re.search(r'^struct DRender_tView \{[^\n]*\n', h, re.M)
assert m and m.start() > h.index(old)
new = ('struct DRender_tView;' + NL + 'struct Draw_DCache;' + NL +
       '/* object.cpp\'s polymorphic family, as this surface needs it: virtual dtor [slot 1], pure Draw [slot 2] */' + NL +
       'struct ObjectAnim {' + NL + '    virtual ~ObjectAnim();' + NL +
       '    virtual int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset) = 0;' + NL + '};' + NL +
       'struct ObjectFinishedMultiAnim : public ObjectAnim { int Draw(DRender_tView *, Draw_DCache *, int); };' + NL +
       'struct ObjectFinishedSignAnim : public ObjectAnim {' + NL + '    int Draw(DRender_tView *, Draw_DCache *, int);' + NL)
open(R + 'draww_types.h', 'w', encoding='utf-8', newline='').write(h.replace(old, new))
s = open(R + 'draww.cpp', encoding='utf-8').read()
s, n1 = re.subn(r'\(\*\(\*anim->_vf\)\[2\]\.pfn\)\s*\(\(int\)&anim->_vf \+ \(int\)\(\*anim->_vf\)\[2\]\.delta,Vi,sd,objectOffset\)',
                'anim->Draw(Vi,sd,objectOffset)', s)
s, n2 = re.subn(r'\(\*\(\*anim->_vf\)\[2\]\.pfn\)\s*\(\(int\)&anim->_vf \+ \(int\)\(\*anim->_vf\)\[2\]\.delta,Vi,0x1f800000,objectOffset\)',
                'anim->Draw(Vi,(Draw_DCache *)0x1f800000,objectOffset)', s)
assert (n1, n2) == (1, 1), (n1, n2)
open(R + 'draww.cpp', 'w', encoding='utf-8', newline='').write(s)
print('ok')
