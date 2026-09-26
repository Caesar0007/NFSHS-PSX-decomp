/* chunk.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_COMMON_CHUNK_TYPES_H
#define NFS4_GAME_COMMON_CHUNK_TYPES_H

#include "draw_leaf_types.h"
#include "gamesetup_leaf_types.h"
#include "group_types.h"

#ifndef NFS4_CHUNK_OMIT_TRACK_FOREIGN_TYPES
struct POLY_GT4 {
    u_long tag;
    u_char r0, g0, b0, code; short x0, y0; u_char u0, v0; u_short clut;
    u_char r1, g1, b1, p1; short x1, y1; u_char u1, v1; u_short tpage;
    u_char r2, g2, b2, p2; short x2, y2; u_char u2, v2; u_short pad2;
    u_char r3, g3, b3, p3; short x3, y3; u_char u3, v3; u_short pad3;
};
#endif

struct CCOORD16 { short x, y, z, light; };

#ifndef NFS4_CHUNK_OMIT_TRACK_FOREIGN_TYPES
#include "shared/DRender_tView.h"




#include "shared/Draw_SubdivStruct.h"
#endif

#include "shared/Trk_ObjectDef.h"




#include "shared/Trk_SimpleInst.h"






#include "shared/Trk_CollideBoomInst.h"








#include "shared/Trk_AnimateInst.h"





#include "shared/Trk_Quad.h"
struct Trk_NewStrip { u_char topVert, botVert; char quadCount, size; };
#include "shared/Trk_NewSimQuad.h"
struct Trk_NewSimSlice {
    u_char stripIndex, quadCount, simquadIndex, simquadCount, simquadStartIndex;
};

#include "shared/Trk_SimObject.h"





struct RelCoord16 { short x, z; };

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

struct Track_tArtresource {
    int id;
    char *shapeFile;
    int shapeCount;
    Draw_tPixMap *pPmx;
    int pmxCount, basePmxCount;
};

struct Track_tMaterial { char flag, mipmap_offset; short pmxIndex; };
#include "shared/tSaveSurface.h"

#ifndef NFS4_CHUNK_OMIT_TRACK_FOREIGN_TYPES
#include "shared/Skidmark_Segment.h"






struct Skidmark_Chunk {
    coorddef cp;
    short n, slice;
    Skidmark_Segment seg[24];
};
#endif

struct AnimScript {
    int baseTicks, baseFrame, flags, numParts;
    Trk_AnimateInst **inst;
};

struct BWorldSm_Pos {
    short slice, stripQuadInd, simRotFlag;
    coorddef quadPts[4];
    CCOORD16 quadPts16[4];
    char sliceChanged, quadChanged, offEdge, triangleFlag;
    coorddef normal, forward;
    char quad;
    u_char chunk;
    char lastRezRequested, rez;
    Trk_NewSimQuad *simQuad;
    Trk_NewStrip *strip;
    Trk_NewSimSlice *simSlice;
};

struct BO_tNewtonObj;
struct BO_tNewtonCollisionInfo {
    int collided, impulse;
    BO_tNewtonObj *otherObj;
    int sfxType, disableCollisionTimer;
    coorddef collisionPoint;
    int lastCollision;
    BO_tNewtonObj *lastOtherObj;
    int lastImpulse, lastTime;
};

struct BO_tNewtonObj {
    int objID;
    u_short oldSlice, totalSlice;
    BWorldSm_Pos simRoadInfo;
    int distToPlayer;
    u_char simOptz, active, reOrthoCounter;
    int gravityMult, cumulatedRot, lastUpdated;
    coorddef position, linearVel;
    int mass, massInv, speedXZ, xRelRoadCenter;
    short positionXZ, eIndexEnvMap, eIndexShadow;
    int wheelRot[2];
    int wheelFrontX, wheelFrontZ, wheelBackX, wheelBackZ, wheelWidthF, wheelWidthB;
    matrixtdef orientMat;
    coorddef angularVel;
    int moInertia, moInertiaInv;
    coorddef orientationToGround, dimension;
    int dimensionRadius;
    matrixtdef roadMatrix;
    coorddef roadCenterPoint;
    int roadGravityModifier, roadYaw;
    u_short flightTime, deadTimer;
    int groundElevation, groundVel, objAltitude;
    BO_tNewtonCollisionInfo collision;
    int groundSurfaceType, driveSurfaceType;
    matrixtdef shadowMat;
    coorddef shadowCoord[4];
    int damage[10];
};

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
