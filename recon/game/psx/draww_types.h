/* DrawW.obj's exact source-visible type surface reconstructed from SYM.
 * color.obj is an exact 71-record subset; the declarations below are the
 * complete DrawW owner delta, including the independent SDK typedef lane. */
#ifndef NFS4_GAME_PSX_DRAWW_TYPES_H
#define NFS4_GAME_PSX_DRAWW_TYPES_H

#include "../common/color_types.h"

#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)
#define gScratchLastWord   (*(int *)0x1F8003FC)

typedef enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
} forceFocus_t;

#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
typedef enum AIDataRecord_RecordMethod_t {
    NORMAL_M = 0,
    RECORD_M = 1,
    TEST_M = 2
} AIDataRecord_RecordMethod_t;

struct AIDataRecord_t {
    int numElements_, bSize_;
    char name_[64];
    char *dataBuffer_, *preAllocatedBuffer_;
    AIDataRecord_RecordMethod_t recordMethod_;
    virtual ~AIDataRecord_t();   /* aidatarecord.cpp owns the family; slots: dtor, Setup */
    virtual void Setup();
};
struct AIDataRecord_AccTable_t : public AIDataRecord_t { int scale_; };
struct AIDataRecord_CurveSpeedTable_t : public AIDataRecord_t {};
#endif

#include "shared/Trk_ObjectDef.h"
#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
#include "shared/Trk_SimpleInst.h"





#endif
#include "shared/Trk_CollideBoomInst.h"







#include "shared/Trk_AnimateInst.h"




#include "shared/Trk_SimObject.h"





#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
/* Canonical bworldSm.obj aggregate (SYM: Trk_NewSlice, size 32). */
#include "shared/Trk_NewSlice.h"






#endif

struct BW_tContext {
    int client;
    BWorldSm_Pos slicePos;
    int currentChunk, chunkFarZClipSq, polyFarZClipSq, lowDetailDistSq;
    int lineFarZClipSq;
};

struct AnimScript {
    int baseTicks, baseFrame, flags, numParts;
    Trk_AnimateInst **inst;
};
#include "shared/SceneElem.h"






#include "shared/SceneSortedElem.h"
#include "shared/AnimDef.h"

struct DRender_tView;
struct Draw_DCache;
/* object.cpp's polymorphic family, as this surface needs it: virtual dtor [slot 1], pure Draw [slot 2] */
struct ObjectAnim {
    virtual ~ObjectAnim();
    virtual int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset) = 0;
};
struct ObjectFinishedMultiAnim : public ObjectAnim { int Draw(DRender_tView *, Draw_DCache *, int); };
struct ObjectFinishedSignAnim : public ObjectAnim {
    int Draw(DRender_tView *, Draw_DCache *, int);
    matrixtdef finalMatrix;
    Trk_ObjectDef *objDef;
    Trk_CollideBoomInst *objCollideInstance;
};

#include "shared/DRender_tView.h"
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
};
struct tBuildEntry { short chunkInd; char geomRez, enableBits; };

struct CHorizonSpec {
    int mirror, angle, yoffset, height;
    CVECTOR frontColor[2], backColor[2];
    char ringPMX[16];
};
struct CSkySpec {
    int type, flags;
    CVECTOR frontcolors[5], backcolors[5], clearcolor;
    int sunAngleInSky, sunHeightInSky, moonAngleInSky, moonHeightInSky;
    int numStars, starAngleLow, starAngleHigh, starBrightMin, starBrightMax;
    CVECTOR starBaseColor;
    int starRandomSeed;
    CVECTOR sunBeamColor, sunHaloColor;
    int yoffset;
    char cloudIndices[5][4];
    int ringAngles[5];
};
#include "shared/CNightSpec.h"
struct CWeatherSpec { int type, intensity_limit; };
struct CFogSpec { int contrast; CVECTOR color; int start, dist2base; };
#include "shared/CDepthCueSpec.h"
struct CWorldColor {
    int contrast;
    CVECTOR contrast_color;
    short worldR, worldG, worldB, type;
};

#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
/* Canonical gmesetup.obj aggregate (SYM: GameSetup_tData, size 2600). */
struct GameSetup_tData {
    int raceType, numLaps, skill, commMode, tournamentMultiplier, cops;
    int trafficDensity, localCar, catchupLogic, replayMode, instantReplay;
    int mirrorTrack, reverseTrack, measurement, sgge, track, trackSegment;
    int song, Weather, Fog, Damage, Time, randSeed, easter;
    GameSetup_tControllerData controllerData;
    int pinkSlipsForfeit, checkpointType;
    int checkpointHUD[2];
    int dispatchSpeech, reverseCallSpeech, languageSpeech;
    int SceneNumber, SceneStartLap, SceneEndLap;
    GameSetup_tUserSetting userSetting;
    int numPerps, stageOffset, perpArrests, finalPerpArrests;
    GameSetup_tPerpData perpInfo[10];
    int numCars, numPlayerRaceCars, numOpponentRaceCars, opponentCarType;
    GameSetup_tCarData carInfo[9];
};

/* Canonical trackspec.obj aggregate (SYM: CTrackSpec, size 264). */
#include "shared/CTrackSpec.h"











/* Canonical camera.obj aggregate (SYM: camera_info, size 272). */
#include "shared/camera_info.h"




























#endif

#include "shared/TCB.h"
struct EXEC {
    u_long pc0, gp0, t_addr, t_size, d_addr, d_size, b_addr, b_size;
    u_long s_addr, s_size, sp, fp, gp, ret, base;
};
struct DIRENTRY {
    char name[20];
    long attr, size;
    DIRENTRY *next;
    long head;
    char system[4];
};

#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
struct POLY_GT3 {
    u_long tag;
    u_char r0, g0, b0, code; short x0, y0; u_char u0, v0; u_short clut;
    u_char r1, g1, b1, p1; short x1, y1; u_char u1, v1; u_short tpage;
    u_char r2, g2, b2, p2; short x2, y2; u_char u2, v2; u_short pad2;
};
#endif
struct POLY_GT4 {
    u_long tag;
    u_char r0, g0, b0, code; short x0, y0; u_char u0, v0; u_short clut;
    u_char r1, g1, b1, p1; short x1, y1; u_char u1, v1; u_short tpage;
    u_char r2, g2, b2, p2; short x2, y2; u_char u2, v2; u_short pad2;
    u_char r3, g3, b3, p3; short x3, y3; u_char u3, v3; u_short pad3;
};
#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
struct DR_TWIN { u_long tag, code[2]; };
#endif

#include "shared/Draw_SubdivStruct.h"
struct Track_tArtresource {
    int id;
    char *shapeFile;
    int shapeCount;
    Draw_tPixMap *pPmx;
    int pmxCount, basePmxCount;
};
struct Track_tMaterial { char flag, mipmap_offset; short pmxIndex; };
#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
struct Trk_Line { u_char firstPoint, slice, type, quadIndex; };

#include "shared/Draw_tGiveShelbyMoreCache.h"

























#endif

#include "shared/Skidmark_Segment.h"





struct Skidmark_Chunk {
    coorddef cp;
    short n, slice;
    Skidmark_Segment seg[24];
};
#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
#include "shared/Draw_tCtrlSkidmark.h"






struct ChunkObjectInfo {
    Trk_SimObject *simObjs;
    Group *objInstanceBuf;
    int doFrustumClip, zClipSq, offset;
    short *visList;
};
#endif

struct FLARE_PIECE_DEF { int distance, size; CVECTOR color; char type; };
#include "shared/Sched_tSchedule.h"



#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
/* Canonical sim.obj aggregate (SYM: Sim_tSimGlobalVar, size 24). */
#include "shared/Sim_tSimGlobalVar.h"



#include "shared/tBoundingSphere.h"
#include "shared/tQuat.h"
struct kernpair {
    u_short previouscode, code;
    char kernvalue, pad[3];
};

typedef kernpair KERN;
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();
typedef tQuat Quatern_quat;
#endif
typedef u_char Night_tLightingTable[256][16];
typedef u_char Night_tWeatherLightingTable[256];
typedef u_char Night_tCopLightingTable[256][8];

#endif
