/* object.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_COMMON_OBJECT_TYPES_H
#define NFS4_GAME_COMMON_OBJECT_TYPES_H

#include "link_stripped.h"

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
#line 53 "C:/nfs4/GAME/COMMON/OBJECT.H"
    virtual ~ObjectAnim() {}
#line 88 "C:/Temp/nfs4-decomp/recon/game/common/object_types.h"
    virtual int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset) = 0;
};
/* Empty Finished* constructor bodies supply retail's inline body regions.
 * Original SLINK /strip removes their two unreferenced standalone copies.
 * LINK_STRIPPED models that linker decision, not an instruction rewrite.
 * Proof: build/nc12/object_ctor_strip_20261026/probe-proof.json. */
struct ObjectFinishedMultiAnim : public ObjectAnim {
    ObjectFinishedMultiAnim() LINK_STRIPPED;
#line 61 "C:/nfs4/GAME/COMMON/OBJECT.H"
    ~ObjectFinishedMultiAnim() {}
#line 95 "C:/Temp/nfs4-decomp/recon/game/common/object_types.h"
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
#line 109 "C:/Temp/nfs4-decomp/recon/game/common/object_types.h"
    int Draw(DRender_tView *, Draw_DCache *, int);
};
struct ObjectFinishedSignAnim : public ObjectAnim {
    ObjectFinishedSignAnim() LINK_STRIPPED;
    matrixtdef finalMatrix;
    Trk_ObjectDef *objDef;
    Trk_CollideBoomInst *objCollideInstance;
#line 101 "C:/nfs4/GAME/COMMON/OBJECT.H"
    ~ObjectFinishedSignAnim() {}
#line 116 "C:/Temp/nfs4-decomp/recon/game/common/object_types.h"
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
#line 131 "C:/Temp/nfs4-decomp/recon/game/common/object_types.h"
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

#define NFS4_AIHIGH_TYPE_PART 2
#include "aihigh.h"
#undef NFS4_AIHIGH_TYPE_PART

#endif
