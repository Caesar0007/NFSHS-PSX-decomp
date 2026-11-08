/* collide.obj's exact source-visible delta over the shared color graph. */
#if !defined(NFS4_GAME_COMMON_COLLIDE_TYPES_H)   /* first pass */
#define NFS4_GAME_COMMON_COLLIDE_TYPES_H
#define NFS4_COLOR_TRK_OBJ   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_HOOK_AFTER_BO "collide_types.h"   /* retail: anim/scene/object types right after the BO types (second pass below) */
#include "color_types.h"
#include "shared/Sched_tSchedule.h"
#endif
#if defined(NFS4_COLOR_IN_HOOK) && !defined(NFS4_COLLIDE_EARLY_DONE)   /* second pass, from color_types.h */
#define NFS4_COLLIDE_EARLY_DONE
#include "shared/Trk_ObjectDef.h"
#include "shared/Trk_CollideBoomInst.h"




#include "shared/Trk_AnimateInst.h"





#include "shared/Trk_SimObject.h"





struct AnimScript {
    int baseTicks, baseFrame, flags, numParts;
    Trk_AnimateInst **inst;
    AnimScript(int num);
    AnimScript(int num, int numParts);
    AnimScript(Group *instanceGroup, int type, int boomIndex, int numParts);
    ~AnimScript() { delete [] inst; }
    void SetAnimAttrib(int flags);
    void GetAnimFrameInfo(int *frame, int *numFrames);
    int GetTimedAnimPosRot(coorddef *pt, matrixtdef *mat);
    int GetTimedAnimPosRot(int index, coorddef *pt, matrixtdef *mat);
    int GetStatus();
};

#include "shared/SceneElem.h"






#include "shared/SceneSortedElem.h"
#include "shared/AnimDef.h"

struct DRender_tView;
struct Draw_DCache;
struct ObjectAnim {
    ObjectAnim() {}
    virtual ~ObjectAnim() {}
    virtual int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset) = 0;
};
struct DRender_tView;
struct Draw_DCache;
typedef struct ObjectFinishedMultiAnim : public ObjectAnim { ObjectFinishedMultiAnim() {}
    int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset);
} ObjectFinishedMultiAnim;
typedef struct ObjectFinishedSignAnim : public ObjectAnim { ObjectFinishedSignAnim() {}
    matrixtdef finalMatrix;
    Trk_ObjectDef *objDef;
    Trk_CollideBoomInst *objCollideInstance;
    int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset);
} ObjectFinishedSignAnim;
#include "shared/Object_tSimObjList.h"

#endif





