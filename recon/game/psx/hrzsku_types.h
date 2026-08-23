/* hrzsku.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_HRZSKU_TYPES_H
#define NFS4_GAME_PSX_HRZSKU_TYPES_H

#include "../common/gamesetup_leaf_types.h"
#include "../common/draw_leaf_types.h"

#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

struct TCB { long status, mode; u_long reg[40]; long system[6]; };
struct EXEC {
    u_long pc0, gp0, t_addr, t_size, d_addr, d_size, b_addr, b_size;
    u_long s_addr, s_size, sp, fp, gp, ret, base;
};
struct DIRENTRY { char name[20]; long attr, size; DIRENTRY *next; long head; char system[4]; };

struct POLY_FT4 {
    u_long tag; u_char r0,g0,b0,code; short x0,y0; u_char u0,v0; u_short clut;
    short x1,y1; u_char u1,v1; u_short tpage; short x2,y2; u_char u2,v2;
    u_short pad1; short x3,y3; u_char u3,v3; u_short pad2;
};
struct POLY_G4 {
    u_long tag; u_char r0,g0,b0,code; short x0,y0; u_char r1,g1,b1,pad1;
    short x1,y1; u_char r2,g2,b2,pad2; short x2,y2; u_char r3,g3,b3,pad3;
    short x3,y3;
};
struct POLY_GT4 {
    u_long tag; u_char r0,g0,b0,code; short x0,y0; u_char u0,v0; u_short clut;
    u_char r1,g1,b1,p1; short x1,y1; u_char u1,v1; u_short tpage;
    u_char r2,g2,b2,p2; short x2,y2; u_char u2,v2; u_short pad2;
    u_char r3,g3,b3,p3; short x3,y3; u_char u3,v3; u_short pad3;
};
struct TILE_1 { u_long tag; u_char r0,g0,b0,code; short x0,y0; };

struct CCOORD16 { short x,y,z,light; };
struct DRender_tView { int id, player; DRender_tCalcView cview; };
struct Draw_SubdivStruct { Draw_SVertex v[15]; };
struct Draw_DCache {
    Draw_tCacheHeader head; MATRIX matB,matNight,matCop,identMat; int otz;
    VECTOR tVn0,tVn1,tVn2,tVn3; short light,doublelayer;
};
struct Trk_Quad { short material; u_char aPoints[4]; };
struct Trk_NewStrip { u_char topVert,botVert; char quadCount,size; };
struct Trk_NewSimQuad { u_char surface; };
struct Trk_NewSimSlice { u_char stripIndex,quadCount,simquadIndex,simquadCount,simquadStartIndex; };
struct RelCoord16 { short x,z; };
struct Group { int m_num_elements; inline void *GetData(){return this+1;} inline int GetNumElements(){return m_num_elements;} };
struct Track_tArtresource { int id; char *shapeFile; int shapeCount; Draw_tPixMap *pPmx; int pmxCount,basePmxCount; };
struct Track_tMaterial { char flag,mipmap_offset; short pmxIndex; };
struct tSaveSurface { Trk_NewSimQuad *fSimQuad; u_char fSurface; };

struct BWorldSm_Pos {
    short slice,stripQuadInd,simRotFlag; coorddef quadPts[4]; CCOORD16 quadPts16[4];
    char sliceChanged,quadChanged,offEdge,triangleFlag; coorddef normal,forward;
    char quad; u_char chunk; char lastRezRequested,rez; Trk_NewSimQuad *simQuad;
    Trk_NewStrip *strip; Trk_NewSimSlice *simSlice;
};
struct BO_tNewtonObj;
struct BO_tNewtonCollisionInfo {
    int collided,impulse; BO_tNewtonObj *otherObj; int sfxType,disableCollisionTimer;
    coorddef collisionPoint; int lastCollision; BO_tNewtonObj *lastOtherObj;
    int lastImpulse,lastTime;
};
struct BO_tNewtonObj {
    int objID; u_short oldSlice,totalSlice; BWorldSm_Pos simRoadInfo; int distToPlayer;
    u_char simOptz,active,reOrthoCounter; int gravityMult,cumulatedRot,lastUpdated;
    coorddef position,linearVel; int mass,massInv,speedXZ,xRelRoadCenter;
    short positionXZ,eIndexEnvMap,eIndexShadow; int wheelRot[2];
    int wheelFrontX,wheelFrontZ,wheelBackX,wheelBackZ,wheelWidthF,wheelWidthB;
    matrixtdef orientMat; coorddef angularVel; int moInertia,moInertiaInv;
    coorddef orientationToGround,dimension; int dimensionRadius; matrixtdef roadMatrix;
    coorddef roadCenterPoint; int roadGravityModifier,roadYaw; u_short flightTime,deadTimer;
    int groundElevation,groundVel,objAltitude; BO_tNewtonCollisionInfo collision;
    int groundSurfaceType,driveSurfaceType; matrixtdef shadowMat; coorddef shadowCoord[4];
    int damage[10];
};
struct Skidmark_Segment { SVECTOR svx[2]; CVECTOR rgb; int type; Skidmark_Segment *next; };
struct Skidmark_Chunk { coorddef cp; short n,slice; Skidmark_Segment seg[24]; };

typedef enum forceFocus_t { FOCUS_NORMAL=0, FOCUS_AI=1, FOCUS_COPANDAI=2 } forceFocus_t;
struct FLARE_PIECE_DEF { int distance,size; CVECTOR color; char type; };
struct CHorizonSpec { int mirror,angle,yoffset,height; CVECTOR frontColor[2],backColor[2]; char ringPMX[16]; };
struct CSkySpec {
    int type,flags; CVECTOR frontcolors[5],backcolors[5],clearcolor;
    int sunAngleInSky,sunHeightInSky,moonAngleInSky,moonHeightInSky;
    int numStars,starAngleLow,starAngleHigh,starBrightMin,starBrightMax;
    CVECTOR starBaseColor; int starRandomSeed; CVECTOR sunBeamColor,sunHaloColor;
    int yoffset; char cloudIndices[5][4]; int ringAngles[5];
};
struct CNightSpec { CVECTOR nightcolor; };
struct CWeatherSpec { int type,intensity_limit; };
struct CFogSpec { int contrast; CVECTOR color; int start,dist2base; };
struct CDepthCueSpec { CVECTOR color; int distance; };
struct CWorldColor { int contrast; CVECTOR contrast_color; short worldR,worldG,worldB,type; };
struct kernpair { u_short previouscode,code; char kernvalue; char pad[3]; };
typedef kernpair KERN;
typedef void Trk_Chunk;
typedef void *lpTrk_Chunk;
typedef short (*tPA32)[32];
typedef int (*getcode)();
typedef void (*adjustchar)();
typedef void (*fontblit)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();

struct Draw_HorizonCache {
    Draw_tCacheHeader head; DVECTOR scptTop[17],scptMidBot[17],scptPmxLeft[17],scptPmxRight[17];
    int vertexTop[18];
};
struct Draw_SkyCache { Draw_tCacheHeader head; DVECTOR pSkyMesh[85]; int pSkyZ[85]; };
struct tHrz_LightningFork { DVECTOR pos; char pmxIndex; };
struct tHrz_Lightning { tHrz_LightningFork forks[16]; int brightness; char numForks; };

struct Draw_FlareCache;

#endif
