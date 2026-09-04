/* Weather.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_WEATHER_TYPES_H
#define NFS4_GAME_PSX_WEATHER_TYPES_H

#include "../common/gamesetup_leaf_types.h"
#include "../common/draw_leaf_types.h"

/* Canonical GameSetup_gData aggregate used by this translation unit. */
struct GameSetup_tData {
    int raceType, numLaps, skill, commMode, tournamentMultiplier, cops;
    int trafficDensity, localCar, catchupLogic, replayMode, instantReplay;
    int mirrorTrack, reverseTrack, measurement, sgge, track, trackSegment, song;
    int Weather, Fog, Damage, Time, randSeed, easter;
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

struct TCB { long status, mode; u_long reg[40]; long system[6]; };
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

struct CCOORD16 { short x, y, z, light; };

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

struct CHorizonSpec {
    int mirror, angle, yoffset, height;
    CVECTOR frontColor[2], backColor[2];
    char ringPMX[16];
};
struct CSkySpec {
    int type, flags;
    CVECTOR frontcolors[5], backcolors[5];
    CVECTOR clearcolor;
    int sunAngleInSky, sunHeightInSky, moonAngleInSky, moonHeightInSky;
    int numStars, starAngleLow, starAngleHigh, starBrightMin, starBrightMax;
    CVECTOR starBaseColor;
    int starRandomSeed;
    CVECTOR sunBeamColor, sunHaloColor;
    int yoffset;
    char cloudIndices[5][4];
    int ringAngles[5];
};
struct CNightSpec { CVECTOR nightcolor; };
struct CWeatherSpec { int type, intensity_limit; };
struct CFogSpec { int contrast; CVECTOR color; int start, dist2base; };
struct CDepthCueSpec { CVECTOR color; int distance; };
struct CWorldColor {
    int contrast;
    CVECTOR contrast_color;
    short worldR, worldG, worldB, type;
};

typedef void (*Sched_tFunctionPt)(void *);
struct Sched_tFunctionSchedule {
    int priority;
    Sched_tFunctionPt function;
    void *var1, *var2;
};
struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
};

struct Sim_tSimGlobalVar {
    int gameStarted, gameTicks, time32Hz;
    Sched_tSchedule *schedule64Hz, *schedule32Hz, *schedule32Hz2;
};

struct POLY_F4 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0, x1, y1, x2, y2, x3, y3;
};
struct POLY_FT4 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0;
    u_char u0, v0;
    u_short clut;
    short x1, y1;
    u_char u1, v1;
    u_short tpage;
    short x2, y2;
    u_char u2, v2;
    u_short pad1;
    short x3, y3;
    u_char u3, v3;
    u_short pad2;
};
struct LINE_G2 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0;
    u_char r1, g1, b1, p1;
    short x1, y1;
};

struct Weather_tSys {
    int num[2];
    SVECTOR velocity;
    long hdist;
    short znear, zfar, length, bottom, top, height, width;
};
struct Weather_tSplatInfo { DVECTOR pos; int startTick; };
typedef enum Weather_tState {
    Weather_kSnow = 0,
    Weather_kRain = 1
} Weather_tState;
typedef enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
} forceFocus_t;

struct kernpair {
    u_short previouscode, code;
    char kernvalue;
    char pad[3];
};
typedef kernpair KERN;

typedef void Trk_Chunk;
typedef void *lpTrk_Chunk;
typedef short (*tPA32)[32];
typedef int Input_tDeviceCall();
typedef void (*adjustchar)();
typedef void (*fontblit)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef int (*getcode)();

#endif
