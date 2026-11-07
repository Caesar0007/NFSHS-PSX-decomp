#ifndef NFS4_GAME_COMMON_CHUNK_TYPES_H
#define NFS4_GAME_COMMON_CHUNK_TYPES_H   /* chunk.obj source-visible types; full supplied type-copy/order audit remains open. */
#define NFS4_CORE_CCOORD16   /* CCOORD16 at its retail place (after COORD16, before the pads) */
#ifndef NFS4_CHUNK_OMIT_TRACK_FOREIGN_TYPES   /* track.obj sees chunk without POLY_GT4 */
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_CORE_DRVIEW   /* retail: DRender_tView right after DRender_tCalcView (draw_leaf_types.h) */
#define NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct after Draw_SVertex, Track_tArt/Material after RelCoord16 */
#define NFS4_PADS_HOOK_AFTER "group_types.h"   /* retail chunk.obj: SimpleMem SerializedGroup Group right after PAD_COMMON */
#define NFS4_GROUP_KERNEL_LATE
#endif
#include "draw_leaf_types.h"
#include "group_types.h"
#ifndef NFS4_CHUNK_OMIT_TRACK_FOREIGN_TYPES
#include "shared/POLY_GT4.h"



#endif

#include "shared/CCOORD16.h"

#ifndef NFS4_CHUNK_OMIT_TRACK_FOREIGN_TYPES
#include "shared/DRender_tView.h"
#include "shared/Draw_SubdivStruct.h"
#endif
#ifdef NFS4_CHUNK_HOOK   /* track.obj: Trk_Material right after the draw leaf (owner second pass, 1..3) */
#define NFS4_CHUNK_IN_HOOK 1
#include NFS4_CHUNK_HOOK
#undef NFS4_CHUNK_IN_HOOK
#endif
#include "shared/Trk_ObjectDef.h"




#include "shared/Trk_SimpleInst.h"






#include "shared/Trk_CollideBoomInst.h"








#include "shared/Trk_AnimateInst.h"





#include "shared/Trk_Quad.h"
#include "shared/Trk_NewStrip.h"
#include "shared/Trk_NewSimQuad.h"
#include "shared/Trk_NewSimSlice.h"
#include "shared/Trk_SimObject.h"
#include "shared/RelCoord16.h"
#ifdef NFS4_CHUNK_HOOK   /* track.obj: TrackHeader between RelCoord16 and Chunk */
#define NFS4_CHUNK_IN_HOOK 2
#include NFS4_CHUNK_HOOK
#undef NFS4_CHUNK_IN_HOOK
#endif
struct Chunk {
    RelCoord16 boundPts[4], chunkboundPts[4];
    u_char quadCounts[6];
    u_char pad[2];
    Trk_Quad *renderQuads[4];
    Group *stripBuf, *lorezstripBuf, *objInstanceBuf, *objSpecialInstanceBuf;
    Group *simSliceBuf, *simQuadBuf, *simObjBuf, *sfxBuf, *lineBuf;
    Group *objVertexBuf, *objQuadBuf, *objQuadInstanceBuf;
    short firstSimSliceInd, chunkInd;
    Group *vertexBuf;
    void InstanceGroup(SerializedGroup *chunkGroup, SimpleMem *mem);
};
#include "shared/Track_tArtresource.h"
#include "shared/Track_tMaterial.h"
#include "shared/tSaveSurface.h"
#ifdef NFS4_CHUNK_HOOK   /* track.obj: SaveSurface, tBoundingSphere right after tSaveSurface */
#define NFS4_CHUNK_IN_HOOK 3
#include NFS4_CHUNK_HOOK
#undef NFS4_CHUNK_IN_HOOK
#endif
#include "gamesetup_leaf_types.h"   /* retail: GameSetup right after tSaveSurface (chunk.obj, track.obj) */
#ifdef NFS4_CHUNK_OMIT_TRACK_FOREIGN_TYPES   /* retail track.obj: the scheduler types right after GameSetup */
typedef void (*Sched_tFunctionPt)(void *);
#include "shared/Sched_tFunctionSchedule.h"
#include "shared/Sched_tSchedule.h"
#endif

#ifndef NFS4_CHUNK_OMIT_TRACK_FOREIGN_TYPES
#include "shared/TCB.h"   /* retail chunk.obj: kernel types after GameSetup (group_types.h NFS4_GROUP_KERNEL_LATE) */
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#include "shared/Skidmark_Segment.h"




#include "shared/Skidmark_Chunk.h"




#endif

typedef struct AnimScript {   /* retail: C-style typedef (two TPDEF AnimScript) */
    int baseTicks, baseFrame, flags, numParts;
    Trk_AnimateInst **inst;
} AnimScript;

#include "shared/BWorldSm_Pos.h"













struct BO_tNewtonObj;
#include "shared/BO_tNewtonCollisionInfo.h"









#include "shared/BO_tNewtonObj.h"




























#include "shared/SceneElem.h"







#include "shared/SceneSortedElem.h"
#include "shared/AnimDef.h"

/* __vtbl_ptr_type is GCC 2.7.2's built-in vtable-entry typedef. */
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

typedef void Trk_Chunk;
typedef void *lpTrk_Chunk;
typedef short (*tPA32)[32];

#endif
