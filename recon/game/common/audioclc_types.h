/* audioclc.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_AUDIOCLC_TYPES_H
#define NFS4_GAME_COMMON_AUDIOCLC_TYPES_H

#include "color_types.h"

#define RaceType_HotPursuit 1
#define RaceType_Id5 5

/* The completed s_type enum is absent from audioclc.obj; it survives only in
 * two external C++ function names. */
#ifndef NFS4_AUDIOCLC_OMIT_S_TYPE_ALIAS
#define s_type int
#endif

struct POLY_GT4 {
    u_long tag;
    u_char r0, g0, b0, code; short x0, y0; u_char u0, v0; u_short clut;
    u_char r1, g1, b1, p1; short x1, y1; u_char u1, v1; u_short tpage;
    u_char r2, g2, b2, p2; short x2, y2; u_char u2, v2; u_short pad2;
    u_char r3, g3, b3, p3; short x3, y3; u_char u3, v3; u_short pad3;
};

struct Draw_SubdivStruct { Draw_SVertex v[15]; };

struct Track_tArtresource {
    int id;
    char *shapeFile;
    int shapeCount;
    Draw_tPixMap *pPmx;
    int pmxCount, basePmxCount;
};

struct Track_tMaterial { char flag, mipmap_offset; short pmxIndex; };

struct SNDSYSCAP {
    u_short outputratemin, outputratemax;
    u_char outputchannelsmin, outputchannelsmax, inputvoicesmax;
    u_char input3dvoicesmax, eax, voicemanager;
    char pad[2];
};

struct SNDSYSSET {
    u_short maxbanks, outputrate;
    u_char outputchannels, inputvoices, useeax, use3dacceleration, use3dmixing;
    char pad;
    u_short emulationsubtype;
    u_short spkrcfg3d[4][4];
};

struct SNDSYSVEC { int (*issurfacelocked)(void); };
struct SNDSAMPLEFORMAT { u_short samplerate; u_char channels, samplerep; };

struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
};

#ifndef NFS4_AUDIOCLC_OMIT_AUDIOCLC_ONLY_TYPES
struct Trk_AnimateInst {
    short size;
    u_char type, objectIndex, zoffset, flags;
    short pad, count, interval;
};
#endif

#ifndef NFS4_AUDIOCLC_OMIT_SCENE_TYPES
struct SceneElem {
    int type, size, committed, visible;
    coorddef cp;
    int height;
    matrixtdef orient;
    int subType, subTypeIndex, scalar1, scalar2, scalar3, scalar4;
};

struct SceneSortedElem { int slice_; SceneElem *se; };
#endif

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

#ifdef NFS4_AUDIOCLC_OMIT_FORCE_FOCUS
#define forceFocus_t int
#else
#ifdef NFS4_SINGLE_IMPLICIT_ENUM_TYPEDEF
enum forceFocus_t {
#else
typedef enum forceFocus_t {
#endif
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
#ifdef NFS4_SINGLE_IMPLICIT_ENUM_TYPEDEF
};
#else
} forceFocus_t;
#endif
#endif

struct kernpair {
    u_short previouscode, code;
    char kernvalue;
    char pad[3];
};

#ifndef NFS4_AUDIOCLC_OMIT_AUDIOCLC_ONLY_TYPES
struct AudioClc_tSource {
    Car_tObj *car;
    int distToCamera, dopplerShift, relVelocity, gameTicks, distSq;
    int frequency, channel, horn, hornOn, hornOff, hornCount, pursuit, yelled;
};

struct AudioClc_tPlayer {
    int cameraMode, gameTicks, warnings;
    coorddef lastview;
    AudioClc_tSource source;
};

struct AudioClc_tCLCache { Car_tObj *ptr; int dst; };
#endif

/* Foreign completed tags are absent from audioclc.obj. These exact member
 * views retain every retail offset used by its already-matched functions. */
struct AudioClc_GameSetupCodegenView {
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

#ifndef NFS4_AUDIOCLC_OMIT_CAMERA_VIEW
struct AudioClc_CameraInfoCodegenView {
    BO_tNewtonObj *anchor, *target;
    coorddef position, relpos, audioPos;
    int TVHeight;
    matrixtdef rotation;
    int twist;
    coorddef wallLeft, wallRight;
    short mode, camNum;
    char modechange : 1;
    char pitch : 1;
    char jostling : 1;
    char tracking : 1;
    char checkwalls : 1;
    char noLookBack : 1;
    char checkcollisions : 1;
    char splitscreen : 1;
    char intransition, tumbling;
    char direction : 1;
    char zooming : 2;
    char inCar : 1;
    short circleCounter, circleAngle;
    char animNum;
    signed char animHandle;
    char splineMode;
    forceFocus_t forceFocus;
    signed char focusOnAICar;
    int POInhibitor;
    BWorldSm_Pos slicePos;
};
#endif

struct CARDINFO_def;
typedef struct CARDINFO_def CARDINFO_def;
struct Trk_NewSlice;
typedef struct Trk_NewSlice Trk_NewSlice;

#ifndef NFS4_AUDIOCLC_OMIT_CARLOGIC_OBSERVATIONS
typedef int CarLogic_tObservations[1][3];
#endif
#ifndef NFS4_AUDIOCLC_OMIT_INPUT_DEVICE_CALL
typedef int Input_tDeviceCall();
#endif
typedef kernpair KERN;
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif
