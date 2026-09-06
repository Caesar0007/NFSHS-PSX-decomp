/* Isolated proof that object.h exposes the real member APIs after removal of
 * encoded free-function impostors. No reconstruction source is modified. */
#include "C:/Temp/nfs4-decomp/recon/game/common/object.h"

int (ObjectFinishedMultiAnim::*p875_draw_finished_multi)(DRender_tView *, Draw_DCache *, int) =
    &ObjectFinishedMultiAnim::Draw;
int (ObjectMultiAnim::*p875_draw_multi)(DRender_tView *, Draw_DCache *, int) =
    &ObjectMultiAnim::Draw;
int (ObjectFinishedSignAnim::*p875_draw_finished_sign)(DRender_tView *, Draw_DCache *, int) =
    &ObjectFinishedSignAnim::Draw;
int (ObjectSignAnim::*p875_draw_sign)(DRender_tView *, Draw_DCache *, int) =
    &ObjectSignAnim::Draw;

inline void *operator new(unsigned int, void *storage) { return storage; }

ObjectMultiAnim *p875_construct_multi(void *storage, coorddef *impactVel,
    AnimDef *def, Trk_CollideBoomInst *instance, Trk_ObjectDef *objDef,
    Trk_SimObject *simObj, ObjectFinishedMultiAnim *finishedAnim)
{
    return new (storage) ObjectMultiAnim(impactVel, def, instance, objDef,
                                       simObj, finishedAnim);
}

ObjectSignAnim *p875_construct_sign(void *storage, coorddef *impactVel,
    int impactAngle, AnimDef *def, Trk_CollideBoomInst *instance,
    Trk_ObjectDef *objDef, Trk_SimObject *simObj, coorddef *roadNormal,
    ObjectFinishedSignAnim *finishedAnim)
{
    return new (storage) ObjectSignAnim(impactVel, impactAngle, def, instance,
                                      objDef, simObj, roadNormal, finishedAnim);
}
