/* TrsProj.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_TRSPROJ_TYPES_H
#define NFS4_GAME_PSX_TRSPROJ_TYPES_H

#include "../common/gamesetup_leaf_types.h"
#include "../common/draw_leaf_types.h"

struct CCOORD16 { short x, y, z, light; };
struct Draw_tVertex { PCOORD16 sv; };

struct DRender_tView {
    int id, player;
    DRender_tCalcView cview;
};

struct Trk_Quad { short material; u_char aPoints[4]; };
struct Trk_NewStrip { u_char topVert, botVert; char quadCount, size; };
struct Trk_NewSimQuad { u_char surface; };
struct Trk_NewSimSlice {
    u_char stripIndex, quadCount, simquadIndex, simquadCount, simquadStartIndex;
};
struct RelCoord16 { short x, z; };

struct Group {
    int m_num_elements;
    inline void *GetData() { return this + 1; }
    inline int GetNumElements() { return m_num_elements; }
};

struct tSaveSurface { Trk_NewSimQuad *fSimQuad; u_char fSurface; };

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

typedef enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
} forceFocus_t;

typedef void Trk_Chunk;
typedef void *lpTrk_Chunk;
typedef short (*tPA32)[32];

#endif
