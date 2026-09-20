"""vfpod3.py -- the four surfaces whose ObjectAnim copy had a hand `_vf` member plus a declared non-virtual destructor."""
import re
R = 'C:/Temp/nfs4-decomp/recon/game/common/'
NL = chr(10)
for f in ('audedit', 'chunk', 'collide', 'scene'):
    p = R + f + '_types.h'
    h = open(p, encoding='utf-8').read()
    old = 'struct ObjectAnim {' + NL + '    __vtbl_ptr_type (*_vf)[3];' + NL + '    ~ObjectAnim();' + NL + '};'
    assert h.count(old) == 1, f
    new = ('struct DRender_tView;' + NL + 'struct Draw_DCache;' + NL + 'struct ObjectAnim {' + NL + '    virtual ~ObjectAnim();' + NL +
           '    virtual int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset) = 0;' + NL + '};')
    open(p, 'w', encoding='utf-8', newline='').write(h.replace(old, new))
    print('ok', f)
