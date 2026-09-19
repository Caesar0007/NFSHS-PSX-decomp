"""Real C++ virtuals, step 2 (2026-09-19): the ObjectAnim family in game/common/object.cpp -- replaces
recon/game/common/vtables_object.cpp, the composition model (`_base_ObjectAnim`), the extern-"C" destructor devices and
the manual `_vf` dispatch.
Retail evidence:
  * vtables 0x80056088.. in order SignAnim, FinishedSignAnim, MultiAnim, FinishedMultiAnim, ObjectAnim = REVERSE declaration
    order => declared ObjectAnim, FinishedMultiAnim, MultiAnim, FinishedSignAnim, SignAnim (what object_types.h already has);
  * the five destructors close the object in the order ~SignAnim, ~FinishedSignAnim, ~MultiAnim, ~FinishedMultiAnim,
    ~ObjectAnim = the deferred-inline batch (reverse definition order) => all five are IN-CLASS inline destructors
    (SLD puts ~ObjectAnim at OBJECT.H:53);
  * slots [1] dtor, [2] Draw; the base's Draw slot is __pure_virtual; the SYM has `_vt.` records for the four derived
    classes only => ObjectAnim has no key function (local table), the derived ones key on their out-of-line Draw."""
import json
import os
import re

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)


def rd(f):
    return open(R + f, encoding='utf-8').read()


def wr(f, s):
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


h = rd('recon/game/common/object_types.h')
a = h.index('struct ObjectAnim {')
b = h.index('struct tQuat {')
NEWH = '''/* Real virtuals since 2026-09-19.  Declaration order, in-class inline destructors and the pure base Draw are all retail
 * evidence (vtable order, deferred-inline tail order, __pure_virtual slot) -- see scratchpad/psyq_pipe/fevirt_object.py. */
struct ObjectAnim {
    virtual ~ObjectAnim() {}
    virtual int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset) = 0;
};
struct ObjectFinishedMultiAnim : public ObjectAnim {
    ObjectFinishedMultiAnim() {}
    ~ObjectFinishedMultiAnim() {}
    int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset);
};
struct ObjectMultiAnim : public ObjectAnim {
    coorddef impactVel;
    Trk_SimObject *simObj;
    Trk_CollideBoomInst *objCollideInstance;
    Trk_ObjectDef *objDef;
    AnimDef *animParms;
    int objectAngle, impactAngle;
    AnimScript *script;
    ObjectFinishedMultiAnim *finishedAnim;
    ObjectMultiAnim(coorddef *, AnimDef *, Trk_CollideBoomInst *,
                    Trk_ObjectDef *, Trk_SimObject *, ObjectFinishedMultiAnim *);
    ~ObjectMultiAnim() { delete script; if (finishedAnim) delete finishedAnim; }
    int Draw(DRender_tView *, Draw_DCache *, int);
};
struct ObjectFinishedSignAnim : public ObjectAnim {
    matrixtdef finalMatrix;
    Trk_ObjectDef *objDef;
    Trk_CollideBoomInst *objCollideInstance;
    ObjectFinishedSignAnim() {}
    ~ObjectFinishedSignAnim() {}
    int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset);
};
struct ObjectSignAnim : public ObjectAnim {
    coorddef impactVel;
    Trk_SimObject *simObj;
    Trk_CollideBoomInst *objCollideInstance;
    Trk_ObjectDef *objDef;
    AnimDef *animParms;
    int objectAngle, impactAngle;
    AnimScript *script;
    ObjectFinishedSignAnim *finishedAnim;
    ObjectSignAnim(coorddef *, int, AnimDef *, Trk_CollideBoomInst *,
                   Trk_ObjectDef *, Trk_SimObject *, coorddef *,
                   ObjectFinishedSignAnim *);
    ~ObjectSignAnim() { delete script; if (finishedAnim) delete finishedAnim; }
    int Draw(DRender_tView *, Draw_DCache *, int);
};

'''
wr('recon/game/common/object_types.h', h[:a] + NEWH + h[b:])

s = rd('recon/game/common/object.cpp')
# constructors: the compiler stores the vptr
s, n = re.subn(r'  _base_ObjectAnim\._vf = \(__vtbl_ptr_type \(\*\) \[3\]\)Object(?:Multi|Sign)Anim_vtable;\n', '', s)
assert n == 2, n
# delete-through-vtable sites
s, n = re.subn(r'\(\*\(\*gSimObjAnims\[i\]->_vf\)\[1\]\.pfn\)\s*\(\(int\)&gSimObjAnims\[i\]->_vf \+\s*\(int\)\(\*gSimObjAnims\[i\]->_vf\)\[1\]\.delta,\s*3\);',
               'delete gSimObjAnims[i];', s)
assert n == 3, n
s, n = re.subn(r'return \(\*\(\*anim->_vf\)\[2\]\.pfn\)\s*\(\(int\)(?:&anim->_vf|anim) \+ \(int\)\(\*anim->_vf\)\[2\]\.delta,Vi,sd,offset\);',
               'return anim->Draw(Vi,sd,offset);', s)
assert n == 2, n
for a, b in (('                                finishedMulti))->_base_ObjectAnim;', '                                finishedMulti));'),
             ('          &(new ObjectMultiAnim(&N->linearVel,animDef,', '          (new ObjectMultiAnim(&N->linearVel,animDef,'),
             ('          &Object_CreateSignAnim(N,animDef,', '          Object_CreateSignAnim(N,animDef,'),
             ('                                 objDef,simObj,new ObjectFinishedSignAnim)' + NL + '               ->_base_ObjectAnim;',
              '                                 objDef,simObj,new ObjectFinishedSignAnim);'),
             ('    anim = &this->finishedAnim->_base_ObjectAnim;', '    anim = this->finishedAnim;')):
    assert s.count(a) == 1, a
    s = s.replace(a, b)
s, n = re.subn(r'extern "C" void ___\d+Object\w+Anim\(Object\w+Anim \*pThis,int __in_chrg\);\n', '', s)
assert n == 4, n
cut = s.index('/* ---- ___14ObjectSignAnim  [OBJECT.CPP:?] SLD-FLAG:NO_SLD ---- */')
end = s.index('/* end of object.cpp */')
s = (s[:cut] + '/* The object ends with the five IN-CLASS inline destructors (object_types.h), emitted as the deferred-inline batch in' + NL +
     ' * reverse order: ~ObjectSignAnim, ~ObjectFinishedSignAnim, ~ObjectMultiAnim, ~ObjectFinishedMultiAnim, ~ObjectAnim. */' + NL + NL + s[end:])
wr('recon/game/common/object.cpp', s)
for f in ('recon/game/common/object_externs.h', 'recon/game/common/object.h'):
    x = rd(f)
    x2 = re.sub(r'^extern __vtbl_ptr_type Object\w*_vtable\[\][^\n]*\n', '', x, flags=re.M)
    if x2 != x:
        wr(f, x2)
os.remove(R + 'recon/game/common/vtables_object.cpp')
