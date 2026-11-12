/* game/common/object_anim_classes.h -- the OBJECT.H object-animation class family, one definition for every includer
 * (header-truth 4h; moved verbatim from object_types.h, the owner).  Members are defined in object.cpp. */
#ifndef NFS4_GAME_COMMON_OBJECT_ANIM_CLASSES_H
#define NFS4_GAME_COMMON_OBJECT_ANIM_CLASSES_H
#ifdef NFS4_GAME_COMMON_OBJECT_TYPES_H   /* object.obj (key object) emits standalone copies of the Finished* constructors; the retail link removed them */
#define NFS4_OBJECT_ANIM_STRIP LINK_STRIPPED
#else
#define NFS4_OBJECT_ANIM_STRIP
#endif
struct DRender_tView; struct Draw_DCache;
/* Real virtuals since 2026-09-19.  Declaration order, in-class inline destructors and the pure base Draw are all retail
 * evidence (vtable order, deferred-inline tail order, __pure_virtual slot) -- see scratchpad/psyq_pipe/fevirt_object.py. */
struct ObjectAnim {
    /* Retail derived-ctor SYM has the empty inline base-construction scope. */
    ObjectAnim() {}
#line 53 "C:/nfs4/GAME/COMMON/OBJECT.H"
    virtual ~ObjectAnim() {}
#line 19 "recon/game/common/object_anim_classes.h"
    virtual int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset) = 0;
};
/* Empty Finished* constructor bodies supply retail's inline body regions.
 * Original SLINK /strip removes their two unreferenced standalone copies.
 * LINK_STRIPPED models that linker decision, not an instruction rewrite.
 * Proof: build/nc12/object_ctor_strip_20261026/probe-proof.json. */
struct ObjectFinishedMultiAnim : public ObjectAnim {
    ObjectFinishedMultiAnim() NFS4_OBJECT_ANIM_STRIP;
#line 61 "C:/nfs4/GAME/COMMON/OBJECT.H"
    ~ObjectFinishedMultiAnim() {}
#line 30 "recon/game/common/object_anim_classes.h"
    int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset);
};
inline ObjectFinishedMultiAnim::ObjectFinishedMultiAnim() {}
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
#line 84 "C:/nfs4/GAME/COMMON/OBJECT.H"
    ~ObjectMultiAnim() {
        delete script;
        if (finishedAnim) delete finishedAnim; }
#line 49 "recon/game/common/object_anim_classes.h"
    int Draw(DRender_tView *, Draw_DCache *, int);
};
struct ObjectFinishedSignAnim : public ObjectAnim {
    ObjectFinishedSignAnim() NFS4_OBJECT_ANIM_STRIP;
    matrixtdef finalMatrix;
    Trk_ObjectDef *objDef;
    Trk_CollideBoomInst *objCollideInstance;
#line 101 "C:/nfs4/GAME/COMMON/OBJECT.H"
    ~ObjectFinishedSignAnim() {}
#line 59 "recon/game/common/object_anim_classes.h"
    int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset);
};
inline ObjectFinishedSignAnim::ObjectFinishedSignAnim() {}
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
#line 124 "C:/nfs4/GAME/COMMON/OBJECT.H"
    ~ObjectSignAnim() {
        delete script;
        if (finishedAnim) delete finishedAnim; }
#line 79 "recon/game/common/object_anim_classes.h"
    int Draw(DRender_tView *, Draw_DCache *, int);
};
#endif
