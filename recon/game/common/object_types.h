/* object.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_COMMON_OBJECT_TYPES_H
#define NFS4_GAME_COMMON_OBJECT_TYPES_H

#define NFS4_SIM_OMIT_OBJECT_FOREIGN_TYPES
#include "sim_types.h"
#undef NFS4_SIM_OMIT_OBJECT_FOREIGN_TYPES

struct SerializedGroup;
struct SimpleMem;
struct AIHigh_Cop;

struct Trk_ObjectDef { short id; u_char vertexCount, quadCount; };
struct Trk_CollideBoomInst {
    short size; u_char type, objectIndex, zoffset, flags; short pad;
    int x, y, z; short qx, qy, qz, qw, sx, sy, sz;
    u_char simIndex, boomIndex;
};
struct Trk_AnimateInst {
    short size; u_char type, objectIndex, zoffset, flags;
    short pad, count, interval;
};
struct Trk_SimObject {
    int point[3]; short radius, serialNum;
    u_char topCRAP, bottomCRAP, instIndex, type;
};
struct Trk_SimpleInst {
    short size; u_char type, objectIndex, zoffset, flags; short pad;
    int x, y, z;
};
struct Trk_AnimateBoomInst {
    short size; u_char type, objectIndex, zoffset, flags;
    short pad, count, interval; u_char simIndex, boomIndex; short pad2;
};
struct Trk_SFX { int point[3]; short type, pad; };

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
struct AnimDef { int type, numPieces, objDefIndex, baseAnim, animIndex; };

struct DRender_tView { int id, player; DRender_tCalcView cview; };
struct Draw_DCache {
    Draw_tCacheHeader head;
    MATRIX matB, matNight, matCop, identMat;
    int otz;
    VECTOR tVn0, tVn1, tVn2, tVn3;
    short light, doublelayer;
};

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

struct Object_tSimObjList { int numObjects, chunk, numObjects2, chunk2; };
struct Object_tIMassObjInfo {
    Trk_AnimateInst *animInst;
    coorddef dimension, lastPos;
    int lastTick;
};

/* Real virtuals since 2026-09-19.  Declaration order, in-class inline destructors and the pure base Draw are all retail
 * evidence (vtable order, deferred-inline tail order, __pure_virtual slot) -- see scratchpad/psyq_pipe/fevirt_object.py. */
struct ObjectAnim {
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

struct tQuat { short x, y, z, w; };
typedef tQuat Quatern_quat;

struct Trk_NewSlice {
    int center[3];
    char normal[3], forward[3], right[3];
    u_char acousticType;
    short pavedProfile, leftDrive, rightDrive;
    u_char chunkIndex, laneCount, avgPavedWidthLf, avgPavedWidthRt;
};

struct Sim_tSimGlobalVar {
    int gameStarted, gameTicks, time32Hz;
    Sched_tSchedule *schedule64Hz, *schedule32Hz, *schedule32Hz2;
};

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
