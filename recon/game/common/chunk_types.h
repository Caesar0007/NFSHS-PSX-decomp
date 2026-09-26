/* chunk.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_COMMON_CHUNK_TYPES_H
#define NFS4_GAME_COMMON_CHUNK_TYPES_H

#include "draw_leaf_types.h"
#include "gamesetup_leaf_types.h"
#include "group_types.h"

#ifndef NFS4_CHUNK_OMIT_TRACK_FOREIGN_TYPES
#include "shared/POLY_GT4.h"






#endif

#include "shared/CCOORD16.h"

#ifndef NFS4_CHUNK_OMIT_TRACK_FOREIGN_TYPES
#include "shared/DRender_tView.h"




#include "shared/Draw_SubdivStruct.h"
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

#ifndef NFS4_CHUNK_OMIT_TRACK_FOREIGN_TYPES
#include "shared/Skidmark_Segment.h"






#include "shared/Skidmark_Chunk.h"




#endif

struct AnimScript {
    int baseTicks, baseFrame, flags, numParts;
    Trk_AnimateInst **inst;
};

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
