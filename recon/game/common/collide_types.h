/* collide.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_COLLIDE_TYPES_H
#define NFS4_GAME_COMMON_COLLIDE_TYPES_H

#include "color_types.h"

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
    virtual ~ObjectAnim();
    virtual int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset) = 0;
};
struct DRender_tView;
struct Draw_DCache;
struct ObjectFinishedMultiAnim : public ObjectAnim {
    int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset);
};
struct ObjectFinishedSignAnim : public ObjectAnim {
    matrixtdef finalMatrix;
    Trk_ObjectDef *objDef;
    Trk_CollideBoomInst *objCollideInstance;
    int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset);
};

#include "shared/Object_tSimObjList.h"

#include "shared/Sched_tSchedule.h"




#endif
