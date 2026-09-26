/* Camera private type projection; owner-derived foreign bodies are noted below. */
#ifndef NFS4_GAME_COMMON_CAMERA_TYPES_H
#define NFS4_GAME_COMMON_CAMERA_TYPES_H

#include "color_types.h"

#define RaceType_HotPursuit 1
#define RaceType_Id5 5

/* Owner-derived bworldSm type: SYM1cec71..1cedc3,32 bytes. Camera's
 * surviving type stream does not preserve this foreign body; its original
 * header visibility remains a source-recovery question, not a sealed claim. */
#include "shared/Trk_NewSlice.h"







/* Canonical gmesetup.obj aggregate used by this translation unit. */
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

struct Sched_tSchedule;
#include "shared/Sim_tSimGlobalVar.h"




struct Sim_tSimSystemVar {
    int restartGame, endSimGame, pauseSim, keyRelease, quickPauseSim;
    int goalClockTicks, currentClockTicks;
};

struct tReplayInterface {
    int pause, speed, end, camera, selection, depressed, changeCamera;
    int statsScreen;
};

/* Owner-derived replay type (SYM326706..32678F); camera.obj's own type
 * stream does not retain this foreign body. This is not a caller-graph seal. */
#include "shared/tReplayCameraModes.h"



typedef enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
} forceFocus_t;

#include "shared/Sched_tSchedule.h"




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

struct POLY_GT4 {
    u_long tag;
    u_char r0,g0,b0,code; short x0,y0; u_char u0,v0; u_short clut;
    u_char r1,g1,b1,p1; short x1,y1; u_char u1,v1; u_short tpage;
    u_char r2,g2,b2,p2; short x2,y2; u_char u2,v2; u_short pad2;
    u_char r3,g3,b3,p3; short x3,y3; u_char u3,v3; u_short pad3;
};
#include "shared/Draw_SubdivStruct.h"
struct Track_tArtresource {
    int id;
    char *shapeFile;
    int shapeCount;
    Draw_tPixMap *pPmx;
    int pmxCount, basePmxCount;
};
struct Track_tMaterial { char flag, mipmap_offset; short pmxIndex; };

#include "shared/Trk_AnimateInst.h"





#include "shared/DRender_tView.h"




#include "shared/camera_info.h"





























struct camera_flags {
    coorddef arm;
    int pitch : 1;
    int jostling : 1;
    int tracking : 1;
    int checkwalls : 1;
    int noLookBack : 1;
    int checkcollisions : 1;
};

#include "shared/Camera_tCamSlot.h"











struct kernpair { u_short previouscode, code; char kernvalue; char pad[3]; };

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

#include "shared/Skidmark_Segment.h"





struct Skidmark_Chunk {
    coorddef cp;
    short n, slice;
    Skidmark_Segment seg[24];
};

typedef int Input_tDeviceCall();
typedef kernpair KERN;
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();
typedef camera_info Camera_tInfo;
typedef camera_flags Camera_tFlags;

#endif
