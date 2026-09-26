/* object.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_COMMON_OBJECT_TYPES_H
#define NFS4_GAME_COMMON_OBJECT_TYPES_H

#define NFS4_SIM_OMIT_OBJECT_FOREIGN_TYPES
#include "sim_types.h"
#undef NFS4_SIM_OMIT_OBJECT_FOREIGN_TYPES

struct SerializedGroup;
struct SimpleMem;
struct AIHigh_Cop;

#include "shared/Trk_ObjectDef.h"
#include "shared/Trk_CollideBoomInst.h"




#include "shared/Trk_AnimateInst.h"



#include "shared/Trk_SimObject.h"



#include "shared/Trk_SimpleInst.h"



#include "shared/Trk_AnimateBoomInst.h"



#include "shared/Trk_SFX.h"

struct AnimScript {
    int baseTicks, baseFrame, flags, numParts;
    Trk_AnimateInst **inst;
    AnimScript(int num);
    AnimScript(int num, int numParts);
    AnimScript(Group *instanceGroup, int type, int boomIndex, int numParts);
    /* Same inline class definition owned by anim.cpp; required here so the
       two object-animation deleting destructors expand byte-exactly. */
    ~AnimScript() { delete [] inst; }
    void SetAnimAttrib(int flags);
    void GetAnimFrameInfo(int *frame, int *numFrames);
    int GetTimedAnimPosRot(coorddef *pt, matrixtdef *mat);
    int GetTimedAnimPosRot(int index, coorddef *pt, matrixtdef *mat);
    int GetStatus();
};
#include "shared/AnimDef.h"

#include "shared/DRender_tView.h"
#include "shared/Draw_DCache.h"







struct Chunk {
    RelCoord16 boundPts[4], chunkboundPts[4];
    u_char quadCounts[6], pad[2];
    Trk_Quad *renderQuads[4];
    Group *stripBuf, *lorezstripBuf, *objInstanceBuf, *objSpecialInstanceBuf;
    Group *simSliceBuf, *simQuadBuf, *simObjBuf, *sfxBuf, *lineBuf;
    Group *objVertexBuf, *objQuadBuf, *objQuadInstanceBuf;
    short firstSimSliceInd, chunkInd;
    Group *vertexBuf;
    void InstanceGroup(SerializedGroup *chunkGroup, SimpleMem *mem);
};

#include "shared/Object_tSimObjList.h"
#include "shared/Object_tIMassObjInfo.h"





/* Real virtuals since 2026-09-19.  Declaration order, in-class inline destructors and the pure base Draw are all retail
 * evidence (vtable order, deferred-inline tail order, __pure_virtual slot) -- see scratchpad/psyq_pipe/fevirt_object.py. */
struct ObjectAnim {
    /* Retail derived-ctor SYM has the empty inline base-construction scope. */
    ObjectAnim() {}
    virtual ~ObjectAnim() {}
    virtual int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset) = 0;
};
/* The Finished* classes declare NO constructor: a user-written inline one would get an out-of-line copy (their key
 * function Draw is in object.cpp) and retail has none. */
struct ObjectFinishedMultiAnim : public ObjectAnim {
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

#include "shared/tQuat.h"
typedef tQuat Quatern_quat;

#include "shared/Trk_NewSlice.h"







#include "shared/Sim_tSimGlobalVar.h"




struct SaveSurface {
    short fCount, fMaxCount;
    tSaveSurface *fStack;
    void Save(Trk_NewSimQuad *);
    void RestoreAll();
};

struct AIHigh_Traffic : public AIHigh_Base {
    int ignoreCops_, forcePurgatory_;
    SceneElem *accidentData_;
    AIHigh_Traffic(Car_tObj *carObj);
    Car_tObj *CheckForCops(int *p);
    AIHigh_Cop *CopCheck(int *p);
    void HighExecute();
    trigger_t *CheckForNewTriggers();
};

#endif
