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
struct DRender_tView {
    int id, player;
    DRender_tCalcView cview;
};

struct Draw_SubdivStruct { Draw_SVertex v[15]; };
#endif

struct Trk_ObjectDef {
    short id;
    u_char vertexCount, quadCount;
};

struct Trk_SimpleInst {
    short size;
    u_char type, objectIndex, zoffset, flags;
    short pad;
    int x, y, z;
};

struct Trk_CollideBoomInst {
    short size;
    u_char type, objectIndex, zoffset, flags;
    short pad;
    int x, y, z;
    short qx, qy, qz, qw, sx, sy, sz;
    u_char simIndex, boomIndex;
};

struct Trk_AnimateInst {
    short size;
    u_char type, objectIndex, zoffset, flags;
    short pad, count, interval;
};

struct Trk_Quad { short material; u_char aPoints[4]; };
struct Trk_NewStrip { u_char topVert, botVert; char quadCount, size; };
struct Trk_NewSimQuad { u_char surface; };
struct Trk_NewSimSlice {
    u_char stripIndex, quadCount, simquadIndex, simquadCount, simquadStartIndex;
};

struct Trk_SimObject {
    int point[3];
    short radius, serialNum;
    u_char topCRAP, bottomCRAP, instIndex, type;
};

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
struct tSaveSurface { Trk_NewSimQuad *fSimQuad; u_char fSurface; };

#ifndef NFS4_CHUNK_OMIT_TRACK_FOREIGN_TYPES
struct Skidmark_Segment {
    SVECTOR svx[2];
    CVECTOR rgb;
    int type;
    Skidmark_Segment *next;
};

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

struct SceneElem {
    int type, size, committed, visible;
    coorddef cp;
    int height;
    matrixtdef orient;
    int subType, subTypeIndex, scalar1, scalar2, scalar3, scalar4;
};

struct SceneSortedElem { int slice_; SceneElem *se; };
struct AnimDef { int type, numPieces, objDefIndex, baseAnim, animIndex; };

/* __vtbl_ptr_type is GCC 2.7.2's built-in vtable-entry typedef. */
struct ObjectAnim {
    __vtbl_ptr_type (*_vf)[3];
    ~ObjectAnim();
};

struct DRender_tView;
struct Draw_DCache;
struct ObjectFinishedMultiAnim {
    ObjectAnim _base_ObjectAnim;
    int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset);
};

struct ObjectFinishedSignAnim {
    ObjectAnim _base_ObjectAnim;
    matrixtdef finalMatrix;
    Trk_ObjectDef *objDef;
    Trk_CollideBoomInst *objCollideInstance;
    int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset);
};

typedef void Trk_Chunk;
typedef void *lpTrk_Chunk;
typedef short (*tPA32)[32];

#endif
